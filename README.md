# Service Objects for Rails

A lightweight, high-speed service layer for Rails applications.

## Motivation
Gone are the days of fat controllers or fat models. Service objects (also known as Commands) enable an important service layer in your Rails applications to keep your code readable, reusable and testable. This is a widespread and accepted practice in the Ruby on Rails community and this gem hopes to streamline the use of this pattern. Here is an example of a service object that adds a new user to a table in a poker application:

```
module Services
  class AddPlayerToTable
    include Services::Base

    def initialize(user_id:, table_id:)
      @user = User.find(user_id)
      @table = Table.find(table_id)
    end

    def call
      confirm_player_has_available_funds
      assign_player_to_table
      queue_player_for_next_deal
    end

    private

    attr_reader :user, :table

    def confirm_player_has_available_funds
      # business logic
    end

    def assign_player_to_table
      # business logic
    end

    def queue_player_for_next_deal
      # business logic
    end
  end
end
```

## Installation
Include the gem in your Gemfile:
```
gem "services"
```

and install:
```
bundle install
```

Then generate boilerplate directories and gem configuration files with
```
rails generate services:install
```

This will create the `app/services` directory which will hold the namespaced service objects you create and use in your application.

## Quick start
```
## generate a service

rails g services:new AddPlayerToTable user_id table_id

## write out and test the service

module Services
  class AddPlayerToTable
    include Services::Base

    def initialize(user_id:, table_id:)
      @user = User.find(user_id)
      @table = Table.find(table_id)
    end

    def call
      confirm_player_has_available_funds
      assign_player_to_table
      queue_player_for_next_deal
    end

    private

    attr_reader :user, :table

    def confirm_player_has_available_funds
      # business logic
    end

    def assign_player_to_table
      # business logic
    end

    def queue_player_for_next_deal
      # business logic
    end
  end
end

## use the service

# app/controllers/tables_controller.rb
def join_table
  service_response = AddPlayerToTable.call(user_id: uid, table_id: tid)

  if service_response.success?
    render :show, status: 204
  else
    render json: { errors: service_response.errors.full_messages }
  end
end
```

## Usage
All service objects have the same skeleton: an `initialize` method, a `call` method, and an included `Services::Base` mixin. The `Services::Base` mixin enforces strict, predictable usage of service objects such that they

1. Are always called with named arguemnts
1. Can never be publicly instantiated; only `call`ed
1. Always return an instance of a Services::Response object

It is a best-practice to name service objects in the format <ACTION><NOUN> to abstract the responsibilty and function of the service at the highest level, e.g. `Services::AddPlayerToTable` as opposed to `Services::NewPlayerTable`.

### Using the Generator
To quickly whip up a new service object and corresponding spec, use the provided generator:
```
rails generate services:new <MyNewServiceName> <named_arg_1> <named_arg_2> ...
```

An example of using the generator:
```
rails g services:new AddPlayerToTable user_id table_id

# app/services/add_player_to_table.rb
module Services
  class AddPlayerToTable
    include ServiceObject::Base

    def initialize(user_id:, table_id:,)
      @user_id = user_id
      @table_id = table_id
    end

    def call
    end

    private

    attr_reader :user_id, :table_id
  end
end


# spec/services/add_player_to_table_spec.rb
include "rails_helper"

RSpec.describe Services::AddPlayerToTable do
  subject(:service_response) do
    described_class.call(user_id: user_id, table_id: table_id)
  end

  let(:user_id) { nil }
  let(:table_id) { nil }

  it "does what it says" do
  end

  it "returns what is expected" do
  end
end
```
