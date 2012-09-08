# CodeSpike

CodeSpike is a simple Gem that will let you

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