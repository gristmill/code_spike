# CodeSpike

CodeSpike is a simple Gem for spiking ActiveRecord models. It uses an in memory sqlite3 database and requires all the necessary libs 
for unit testing. In addition it provides a DSL for creating the database schema as well calling test methods. 

I created this Gem because when working on complex ActiveRecord associations, I like to hop outside of Rails to isolate the problem. Setting up
ActiveRecord outside of Rails is easy enough, but the setup is a little verbose and I can never quite remember all the libraries 
or the exact syntax. So I spend time googling or looking back through old code, which I don't like doing if I've already solved the problem. 

This Gem just wraps the setup and adds a simple DSL so that I can remember!

Example

```ruby
require 'code_spike'

schema do
  create_table(:people ){ |t| t.string :name }
end

class Person < ActiveRecord::Base; end

units do
  test "something interesting" do
    assert Person.create!
  end
end
```