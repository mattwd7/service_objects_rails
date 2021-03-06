# Service Objects for Rails

[![mattwd7](https://circleci.com/gh/mattwd7/service_objects_rails.svg?style=svg)](https://app.circleci.com/pipelines/github/mattwd7/service_objects_rails?filter=all)
[![Test Coverage](https://codecov.io/gh/mattwd7/service_objects_rails/graph/badge.svg)](https://codecov.io/gh/mattwd7/service_objects_rails)

A lightweight, high-speed service layer for Rails applications.

## Motivation
Gone are the days of fat controllers and fat models! Service objects (sometimes known as Commands) enable an important service layer in your Rails applications to keep your code readable, reusable, and testable. Service objects help to facilitate a separation of concerns and the single responsibility principle. Here is an example of a service object that adds a new user to a table in a poker application:

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
Without this Service Object, our Rails models like User, Table, and Queue would require a knowledge of associated models and their logic, consequently bloating model classes and their tests. Instead, this Service Object orchestrates the necessary objects to perform the singular task of adding a player to a poker table.

## Installation
Include the gem in your Gemfile:
```
gem "service_objects_rails"
```

and install:
```
bundle install
```

Then generate boilerplate directories and gem configuration files with
```
rails generate services:install
```

This will create the `app/namespaces/services` directory which will hold the namespaced service objects you create and use in your application.

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
class TablesController < ApplicationController
  def join_table
    service_response = Services::AddPlayerToTable.call(
      user_id: params[:user_id],
      table_id: params[:table_id]
    )

    if service_response.success?
      render :show, status: 204
    else
      render json: { errors: service_response.errors.full_messages }
    end
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

# app/namespaces/services/add_player_to_table.rb
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


# spec/namespaces/services/add_player_to_table_spec.rb
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
