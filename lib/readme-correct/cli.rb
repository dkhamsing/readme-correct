module ReadmeCorrect
  require 'readme-correct/version'
  require 'readme-correct/correct'

  require 'yaml'

  class << self
    def cli
      puts "#{PRODUCT} #{VERSION}"

      unless github_creds
        puts 'GitHub credentials are required in .netrc https://github.com/octokit/octokit.rb#using-a-netrc-file'
        exit
      end

      begin
        c = YAML.load_file CONFIG
      rescue
        puts "Missing #{CONFIG} file"
        exit
      end

      keys = [
        'correct',
        'incorrect',
        'pull_commit_message',
        'pull_request_title',
        'pull_request_description'
      ]

      config = {}
      keys.each do |k|
        config[k] = c[k]
        missing config[k], k
      end

      if ARGV.count == 0
        puts ''
        puts "Usage: #{PRODUCT} <repo> \n"\
          "  i.e. #{PRODUCT} AFNetworking/AFNetworking"
        exit
      end

      cli_repo = ARGV[0]
      repo = cli_repo.sub 'https://github.com/', ''
      puts "Checking #{repo} ..."

      logfile = LOG_FILE
      File.open(logfile, 'a') { |f| f.puts '' }
      log = File.read logfile

      if log.include? repo
        puts "Skipping #{repo}, already in log"
        exit
      end

      # log the repo
      File.open(logfile, 'a') { |f| f.puts repo }

      correct repo,
        config['correct'],
        config['incorrect'],
        config['pull_commit_message'],
        config['pull_request_title'],
        config['pull_request_description']
    end

    def missing(key, name)
      if key.nil?
        puts "Missing #{name} in #{CONFIG}"
        exit
      end
    end
  end
end
