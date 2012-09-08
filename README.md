# CodeSpike

Example

```ruby
require 'code_spike'

schema do
 create_table :people do |t|
   t.string :name
 end

class Person < ActiveRecord::Base
end

class CodeSpike
  test "something interesting" do
    assert Person.create!
  end
end
```