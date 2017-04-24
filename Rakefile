require 'rspec/core/rake_task'
require_relative 'lib/telegram_echo_server.rb'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Run telegram monitor'
task :telegram_monitor do
  TelegramEchoServer::TelegramMonitorQueue.start
end
