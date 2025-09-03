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
        puts "  Fetching RSS from: #{src['rss_url']}"
        response = HTTParty.get(src['rss_url'])
        xml = response.body
        
        if xml.nil? || xml.empty?
          puts "  Warning: Empty response from #{src['name']} RSS feed"
          return
        end
        
        puts "  Response size: #{xml.length} characters"
        puts "  Content-Type: #{response.headers['content-type']}"
        
        # Try to parse the feed with detailed error handling
        begin
          feed = Feedjira.parse(xml)
        rescue Feedjira::NoParserAvailable => e
          puts "  Warning: Feedjira failed to parse #{src['name']} RSS feed"
          puts "  Error: #{e.message}"
          puts "  XML preview: #{xml[0..200]}..."
          
          # Try manual RSS parsing as fallback
          puts "  Attempting manual XML parsing as fallback..."
          begin
            doc = Nokogiri::XML(xml)
            if doc.xpath('//item').any?
              puts "  Found #{doc.xpath('//item').count} items via manual parsing"
              process_manual_rss(site, src, doc)
              return
            else
              puts "  No items found in manual XML parsing"
              return
            end
          rescue StandardError => manual_error
            puts "  Manual parsing also failed: #{manual_error.message}"
            return
          end
        end
        
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
        
        puts "  Successfully parsed #{feed.entries.count} entries"
        process_entries(site, src, feed.entries)
      rescue StandardError => e
        puts "  Warning: Error fetching RSS from #{src['name']}: #{e.message}"
        puts "  Feed will be skipped for this build."
      end
    end

    def process_manual_rss(site, src, doc)
      doc.xpath('//item').each do |item|
        begin
          title = item.xpath('.//title').text.strip
          link = item.xpath('.//link').text.strip
          description = item.xpath('.//description').text.strip
          content = item.xpath('.//content:encoded').text.strip
          pub_date_str = item.xpath('.//pubDate').text.strip
          
          # Parse the publication date
          pub_date = Time.parse(pub_date_str).utc rescue Time.now.utc
          
          puts "  ...processing manual entry: #{title}"
          create_document(site, src['name'], link, {
            title: title,
            content: content.empty? ? description : content,
            summary: description,
            published: pub_date
          })
        rescue StandardError => error
          puts "  Warning: Could not process manual entry from #{src['name']}: #{error.message}"
          puts "  Entry will be skipped."
        end
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
