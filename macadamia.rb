require 'date'
require 'dotenv/load'

def command_arguments
  if ARGV.length != 1
    puts 'Usage: ruby macadamia.rb <markdown file path>'
    exit
  else
    ARGV[0]
  end
end

def parse_date(date_string)
  parsed_date = Date.strptime(date_string, '%d/%m/%Y')
  parsed_date.strftime('%Y-%m-%d')
end

def split_sections(document)
  new_sections = []
  sections = document.scan(/^###\s+(.+?)\n\n(.+?)(?=\n\n###|\z)/m)
  sections.each do |header, content|
    new_sections << {
      header: parse_date(header),
      content:
    }
  end
  new_sections
end

def write_sections_in_separate_files(directory, sections)
  sections.each do |section|
    file_name = "#{section[:header].downcase.gsub(' ', '_')}.md"
    file_path = File.join(directory, file_name)
    File.write(file_path, add_tag_to_content(section[:content]))
    puts "Created file: #{file_name}"
  end
end

def add_tag_to_content(text)
  tag_section = "---\ntags: daily-note\n---\n\n"
  tag_section + text
end

# RUN
file_path = command_arguments
directory = File.dirname(file_path)
file_content = File.read(file_path)
sections = split_sections(file_content)
write_sections_in_separate_files(directory, sections)
