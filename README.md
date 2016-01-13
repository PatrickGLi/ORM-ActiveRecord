# ORM - ActiveRecord

Run ``$ ruby demo.rb`` for a demonstration!

[![Screenshot](/img/screenshot.png)](//github.com/PatrickLi727/ORM-ActiveRecord/)

The purpose of building an ORM like ActiveRecord was to understand how ActiveRecord works, and to gain practice in Ruby metaprogramming. It was fundamentally clarifying to see how ActiveRecord translates associations and queries into SQL.

------
Any class that inherits from my SQLObject class receives all the methods
of ActiveRecord that I implemented, including has_many, belongs_to, and one_through
associations.
