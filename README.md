# CodeSpike

CodeSpike is a simple Gem for spiking ActiveRecord models. It uses an in memory sqlite3 database and requires all the necessary libs
for unit testing. In addition it provides a DSL for creating the database schema as well calling test methods.

I created this Gem because when working on complex ActiveRecord associations, I like to hop outside of Rails to isolate the problem. Setting up
ActiveRecord outside of Rails is easy enough, but the setup is a little verbose and I can never quite remember all the libraries
or the exact syntax. So I spend time googling or looking back through old code, which I don't like doing if I've already solved the problem.

This Gem just wraps the setup and adds a simple DSL that I can remember, so I can move right into the problem I'm working on!


## Installation

```bash
gem install code_spike
```

## Usage

```ruby
require 'code_spike'

schema do
  create_table(:people ){ |t| t.string :name }
end

class Person < ActiveRecord::Base; end

units do
  test "person create" do
    assert Person.create!
  end
end
```

For comparison, this is how you would do the same thing without this Gem.

```ruby
require 'test/unit'
require 'active_support/core_ext/class/subclasses'
require 'active_support/test_case'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table(:people ){ |t| t.string :name }
end

class Person < ActiveRecord::Base; end

class CodeSpikeTest < ActiveSupport::TestCase
  teardown { ActiveRecord::Base.subclasses.each { |klass| klass.destroy_all} }

  test "person create" do
    assert Person.create!
  end
end
```

## Using Fixtures

You can also use fixtures to load up seed data for your tests. You have to provide the directory to the YAML files. Here is an example using fixtures.

```ruby
require 'code_spike'

# In ./companies.yml
#
# one:
#   name: Gristmill
fixtures_directory '.'

schema do
  create_table :companies { |t| t.string :name }
end

class Company < ActiveRecord::Base; end

units do
  test "company" do
    assert_equal "Gristmill", Company.first.name
  end
end

```
