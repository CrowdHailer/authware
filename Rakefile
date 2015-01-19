require 'rake/testtask'

test_tasks = Dir['test/*/'].map { |d| File.basename(d) }
test_tasks.each do |folder|
  Rake::TestTask.new("test:#{folder}") do |test|
    test.pattern = "test/#{folder}/**/*_test.rb"
    test.verbose = true
  end
end

desc "Run application test suite"
Rake::TestTask.new("test") do |test|
  test.pattern = "test/**/*_test.rb"
  test.verbose = true
end


# MIGRATIONS
namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    ENV['DATABASE_URL'] ||= 'sqlite://db/app.db'
    require "sequel"
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end
end
