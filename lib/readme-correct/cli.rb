module ReadmeCorrect
  require 'readme-correct/config'
  require 'readme-correct/correct'
  require 'readme-correct/version'

  class << self
    def cli
      puts "#{PRODUCT} #{VERSION}"

      unless github_creds
        puts 'GitHub credentials are required in .netrc https://github.com/octokit/octokit.rb#using-a-netrc-file'
        exit
      end

      config = config()

      if ARGV.count == 0
        puts ''
        puts "Usage: #{PRODUCT} <repo> \n"\
          "  i.e. #{PRODUCT} AFNetworking/AFNetworking"
        exit
      end

      cli_repo = ARGV[0]
      cli_correct cli_repo
    end

    def cli_correct(cli_repo)
      repo = cli_repo.sub 'https://github.com/', ''
      puts "Checking #{repo} ..."

      logfile = LOG_FILE
      File.open(logfile, 'a') { |f| f.puts '' }
      log = File.read logfile

      if log.include? repo
        puts "Skipping #{repo}, already in log"
      else
        # log the repo
        File.open(logfile, 'a') { |f| f.puts repo }

        correct repo,
          config['correct'],
          config['incorrect'],
          config['pull_commit_message'],
          config['pull_request_title'],
          config['pull_request_description']    
      end
    end
  end
end
