require "http_monkey"
require "http_monkey/cookie"

require "minitest/autorun"
require "minitest/reporters"

require "support/captain_hook"

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
MiniTest::Unit.runner.reporters << CaptainHook.new

require "minion_server"

puts %{ === IMPORTANT ===

$ edit /etc/hosts with:
127.0.0.1       local.cookies.com
127.0.0.1       subdomain.cookies.com

}
