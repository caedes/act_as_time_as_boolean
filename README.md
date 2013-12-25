# ActAsTimeAsBoolean

[![Build Status][travis_img]][travis_url]
[![Gem Version][fury_img]][fury_url]
[![Code Climate][code_climate_img]][code_climate_url]
[![Dependency Status][gemnasium_img]][gemnasium_url]
[![Coverage Status][coveralls_img]][coveralls_url]

_Add time_as_boolean feature to your ruby classes_

## Installation

```shell
gem install act_as_time_as_boolean
```

Or in your Gemfile:

```ruby
gem 'act_as_time_as_boolean'
```

## Usage

```ruby
class Item
  include ActAsTimeAsBoolean

  attr_accessor :active_at

  time_as_boolean :active, opposite: :inactive
end

item = Item.new

item.active?
#=> false

item.inactive?
#=> true

item.active = true

item.active?
#=> true

item.inactive?
#=> false
```

#### On a rails app

```ruby
Item.active
#=>  #<ActiveRecord::Relation [...]>

Item.inactive
#=>  #<ActiveRecord::Relation [...]>
```

## Contributing

1. Fork repository
2. Create a branch following a [successfull branching model](http://nvie.com/posts/a-successful-git-branching-model/)
3. Write your feature/fix
4. Write tests
5. Pull request

## Licence

Released under the MIT License. See the [LICENSE](https://github.com/caedes/act_as_time_as_boolean/blob/master/LICENSE.md) file for further details.

[travis_img]: https://travis-ci.org/caedes/act_as_time_as_boolean.png?branch=master
[travis_url]: https://travis-ci.org/caedes/act_as_time_as_boolean
[fury_img]: https://badge.fury.io/rb/act_as_time_as_boolean.png
[fury_url]: http://badge.fury.io/rb/act_as_time_as_boolean
[code_climate_img]: https://codeclimate.com/github/caedes/act_as_time_as_boolean.png
[code_climate_url]: https://codeclimate.com/github/caedes/act_as_time_as_boolean
[gemnasium_img]: https://gemnasium.com/caedes/act_as_time_as_boolean.png
[gemnasium_url]: https://gemnasium.com/caedes/act_as_time_as_boolean
[coveralls_img]: https://coveralls.io/repos/caedes/act_as_time_as_boolean/badge.png?branch=master
[coveralls_url]: https://coveralls.io/r/caedes/act_as_time_as_boolean?branch=master
