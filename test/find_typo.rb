require 'github-readme'
require 'readme-correct'

REPO = 'dkarchive/test-readme-correct'
CORRECT = 'XCode'
INCORRECT = ['xCode']

LOGFILE = 'log.txt'

def log(string)
  puts string
  File.open(LOGFILE, 'a') { |f| f.puts string }
end

log "Basic integration test to find typos"
log "Version: #{ReadmeCorrect::PRODUCT} #{ReadmeCorrect::VERSION}"
log "Repo: #{REPO}"

r = GitHubReadme::get REPO
e = r['error']

unless e.nil?
  log "Error: #{e}"
  exit
end

readme = r['readme']
log '-- README begin -------------------------'
log readme
log '-- README end ---------------------------'

is_incorrect = ReadmeCorrect::is_incorrect readme, INCORRECT
log "Checking #{CORRECT} ..."
log is_incorrect ? "Found instance(s) of #{INCORRECT.join ','}" : 'No issues'
log '✅'

log "\nWrote log in #{LOGFILE}"

exit 1 if is_incorrect == false
