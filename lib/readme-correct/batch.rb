module ReadmeCorrect
  require 'readme-correct/cli'
  require 'readme-correct/config'
  require 'readme-correct/correct'
  require 'readme-correct/version'

  class << self
    def batch
      puts "#{BATCH} #{VERSION}"

      unless github_creds
        puts 'GitHub credentials are required in .netrc https://github.com/octokit/octokit.rb#using-a-netrc-file'
        exit
      end

      config = config()

      if ARGV.count == 0
        puts ''
        puts "Usage: #{BATCH} <list in file>"
        exit
      end

      file = ARGV[0]
      unless File.exist? file
        puts "Error: could not open #{file}"
        exit
      end

      c = File.read file
      l = c.split "\n"

      l.each_with_index do |r, i|
        print "#{i+1}/#{l.count}... "
        cli_correct r
      end
    end
  end
end
