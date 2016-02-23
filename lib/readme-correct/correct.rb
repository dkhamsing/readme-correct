# Correct README
module ReadmeCorrect
  require 'readme-correct/diff'
  require 'readme-correct/github'
  require 'github-readme'

  class << self
    def is_incorrect(content, incorrect)
      incorrect.each do |i|
        return true if content.include? i
      end

     false
    end

    def corrected(content, correct, incorrect)
      content_corrected = content
      incorrect.each do |i|
        content_corrected = content_corrected.gsub(i, correct)
      end

      content_corrected
    end

    def correct(repo,
      correct,
      incorrect,
      pull_commit_message,
      pull_request_title,
      pull_request_description,
      auto=false,
      abuse=false)

      c = github_client
      ghr = GitHubReadme.get repo, c
      readme = ghr['name']
      content = ghr['readme']

      if readme.nil?
        puts 'No README 😢'
        return
      end

      issues = is_incorrect content, incorrect

      unless issues
        puts 'No issues ✅'
        return
      end

      if abuse
        puts 'abuse mode on, correct later 🔵'
        fname = 'temp-abuse-todo'
        File.open(fname, 'a') { |f| f.puts repo }

        left = c.rate_limit.remaining
        puts "GitHub rate limit remaining: #{left}"

        if left < 300
          puts "Let's take a break 😅  (resets in #{c.rate_limit['resets_in']}s)"
          exit
        end
        return
      end

      content_corrected = corrected content, correct, incorrect

      changes = Differ.diff(content_corrected, content).changes

      puts "Found misspelling of \"#{correct}\" 🔴"

      changes.each_with_index do |c, i|
        puts "#{i+1}. #{c.delete}"
      end

      unless auto
        print "Open pull request? (y/n) "
        user_input = STDIN.gets.chomp
        exit unless user_input.downcase == 'y'
      end

      default_branch = github_default_branch c, repo
      file_updated = 'temp-corrected'
      File.write file_updated, content_corrected
      pull_url = github_pull_request(repo,
        default_branch,
        readme,
        file_updated,
        pull_commit_message,
        pull_request_title,
        pull_request_description,
        nil)
      puts "Done: #{pull_url}"

      if auto
        left = c.rate_limit.remaining
        puts "GitHub rate limit remaining: #{left}"

        if left < 100
          puts "Yeesh, let's take a break 🤔"
          exit
        end

        pause = left > 1000 ? Random.new.rand(30..60) : 300
        puts "Pausing for #{pause}s ... 😴"
        sleep pause
      end
    end # def
  end # class
end
