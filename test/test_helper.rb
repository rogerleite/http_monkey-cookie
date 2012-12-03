require "http_monkey"
require "http_monkey/cookie"

require "minitest/autorun"
require "minitest/reporters"

require "support/captain_hook"

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
MiniTest::Unit.runner.reporters << CaptainHook.new

require "minion_server"
