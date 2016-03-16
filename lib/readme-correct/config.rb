module ReadmeCorrect
  require 'yaml'

  class << self
    def config
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

      config
    end

    def missing(key, name)
      if key.nil?
        puts "Missing #{name} in #{CONFIG}"
        exit
      end
    end
  end
end
