require 'feedjira'
require 'httparty'
require 'jekyll'
require 'nokogiri'
require 'time'

module ExternalPosts
  class ExternalPostsGenerator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      if site.config['external_sources'] != nil
        site.config['external_sources'].each do |src|
          puts "Fetching external posts from #{src['name']}:"
          if src['rss_url']
            fetch_from_rss(site, src)
          elsif src['posts']
            fetch_from_urls(site, src)
          end
        end
      end
    end

    def fetch_from_rss(site, src)
      begin
        xml = HTTParty.get(src['rss_url']).body
        return if xml.nil?
        
        # Try to parse the feed
        feed = Feedjira.parse(xml)
        
        # Check if feed was parsed successfully
        if feed.nil? || !feed.respond_to?(:entries)
          puts "  Warning: Could not parse RSS feed from #{src['name']} (#{src['rss_url']})"
          puts "  Feed will be skipped for this build."
          return
        end
        
        if feed.entries.nil? || feed.entries.empty?
          puts "  No entries found in #{src['name']} RSS feed"
          return
        end
        
        process_entries(site, src, feed.entries)
      rescue Feedjira::NoParserAvailable => e
        puts "  Warning: No valid parser for #{src['name']} RSS feed"
        puts "  Error: #{e.message}"
        puts "  Feed will be skipped for this build."
      rescue StandardError => e
        puts "  Warning: Error fetching RSS from #{src['name']}: #{e.message}"
        puts "  Feed will be skipped for this build."
      end
    end

    def process_entries(site, src, entries)
      entries.each do |e|
        begin
          puts "...fetching #{e.url}"
          create_document(site, src['name'], e.url, {
            title: e.title,
            content: e.content || e.summary,  # Fallback to summary if content is nil
            summary: e.summary,
            published: e.published
          })
        rescue StandardError => error
          puts "  Warning: Could not process entry from #{src['name']}: #{error.message}"
          puts "  Entry will be skipped."
        end
      end
    end

    def create_document(site, source_name, url, content)
      # check if title is composed only of whitespace or foreign characters
      if content[:title].gsub(/[^\w]/, '').strip.empty?
        # use the source name and last url segment as fallback
        slug = "#{source_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}-#{url.split('/').last}"
      else
        # parse title from the post or use the source name and last url segment as fallback
        slug = content[:title].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        slug = "#{source_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}-#{url.split('/').last}" if slug.empty?
      end

      path = site.in_source_dir("_posts/#{slug}.md")
      doc = Jekyll::Document.new(
        path, { :site => site, :collection => site.collections['posts'] }
      )
      doc.data['external_source'] = source_name
      doc.data['title'] = content[:title]
      doc.data['feed_content'] = content[:content]
      doc.data['description'] = content[:summary]
      doc.data['date'] = content[:published]
      doc.data['redirect'] = url
      doc.content = content[:content]
      site.collections['posts'].docs << doc
    end

    def fetch_from_urls(site, src)
      src['posts'].each do |post|
        puts "...fetching #{post['url']}"
        content = fetch_content_from_url(post['url'])
        content[:published] = parse_published_date(post['published_date'])
        create_document(site, src['name'], post['url'], content)
      end
    end

    def parse_published_date(published_date)
      case published_date
      when String
        Time.parse(published_date).utc
      when Date
        published_date.to_time.utc
      else
        raise "Invalid date format for #{published_date}"
      end
    end

    def fetch_content_from_url(url)
      html = HTTParty.get(url).body
      parsed_html = Nokogiri::HTML(html)

      title = parsed_html.at('head title')&.text.strip || ''
      description = parsed_html.at('head meta[name="description"]')&.attr('content')
      description ||= parsed_html.at('head meta[name="og:description"]')&.attr('content')
      description ||= parsed_html.at('head meta[property="og:description"]')&.attr('content')

      body_content = parsed_html.search('p').map { |e| e.text }
      body_content = body_content.join() || ''

      {
        title: title,
        content: body_content,
        summary: description
        # Note: The published date is now added in the fetch_from_urls method.
      }
    end

  end
end
