#!/usr/bin/env ruby
# ABOUTME: Script to manually add external blog posts to the site
# ABOUTME: Useful when RSS feeds are not available or for specific posts

require 'yaml'
require 'time'
require 'fileutils'

def create_external_post
  puts "Add External Blog Post"
  puts "====================="
  
  print "Post title: "
  title = gets.chomp
  
  print "External URL: "
  url = gets.chomp
  
  print "Source (Medium/Substack/Other): "
  source = gets.chomp
  
  print "Published date (YYYY-MM-DD): "
  date = gets.chomp
  
  print "Description/Summary: "
  description = gets.chomp
  
  print "Tags (comma-separated): "
  tags = gets.chomp.split(',').map(&:strip)
  
  print "Categories (comma-separated): "
  categories = gets.chomp.split(',').map(&:strip)
  
  # Create slug from title
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  filename = "_posts/#{date}-#{slug}.md"
  
  # Create front matter
  front_matter = {
    'layout' => 'external-post',
    'title' => title,
    'date' => "#{date} 00:00:00 +0000",
    'description' => description,
    'external_source' => source,
    'redirect' => url,
    'tags' => tags,
    'categories' => categories,
    'author' => 'Narasimha Karthik J'
  }
  
  # Write the file
  File.open(filename, 'w') do |file|
    file.puts front_matter.to_yaml
    file.puts "---"
    file.puts ""
    file.puts description
    file.puts ""
    file.puts "[Read the full article on #{source}](#{url}){:target=\"_blank\"}"
  end
  
  puts "\nPost created: #{filename}"
  puts "The post will appear in your blog listing with an '#{source}' badge."
end

# Run the script
create_external_post