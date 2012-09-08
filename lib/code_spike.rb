require 'test/unit'
require 'active_support/core_ext/class/subclasses'
require 'active_support/test_case'
require 'active_record'

# A simple example using CodeSpike
#
# require 'code_spike'
#
# schema do
#   create_table(:people ){ |t| t.string :name }
# end
#
# class Person < ActiveRecord::Base; end
#
# units do
#   test "something interesting" do
#     assert Person.create!
#   end
# end
def schema(&block)
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
  ActiveRecord::Migration.verbose = false

  ActiveRecord::Schema.define do
    instance_eval(&block)
  end

end

def fixtures_directory(fixtures_directory='.')
  require 'active_record/fixtures'
  require 'yaml'
  require 'erb'

  @fixtures_directory = fixtures_directory
end

class CodeSpike < ActiveSupport::TestCase
  teardown { ActiveRecord::Base.subclasses.each { |klass| klass.destroy_all} }
end

def units(&block)
  if defined?(@fixtures_directory)
    ActiveRecord::Fixtures.create_fixtures(@fixtures_directory, Dir["*.yml"].map { |f| File.basename(f, '.*') })
  end

  CodeSpike.instance_eval(&block)
end
