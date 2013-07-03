# Dbchecker

Dbchecker is a rails gem to help you maintain the consistency of your database.


## Installation

Add this line to your rails application's Gemfile:

    gem 'dbchecker'

And then execute:

    $ bundle


## Usage

First, you need to have a place to put the definition of the checkers, so create it:

    mkdir db/checks

Now, you can create inside it several files with the checks. The recommended structure is one file/class per model:

**db/checks/user.rb**
    class UserChecker < Dbchecker::Checker
      model :user

      check_nil :email, :name
      check_equal :follower_id, :followed_id
      check_negative :logged_in_times
    end

With the `model` directive, you are specifiying the model you are working with.
There are several checkers, explained below. Each of them return the ids of the affected models, if any.


## Checks

### check_nil
This checks for the presence of `nil` in the specified fields.
You can pass several fields to `check_nil`.

    check_nil :important_field
    check_nil :field1, :field2

### check_references
This checks for the presence of the referenced model.
You can pass several fields to `check_references`.

For example, if you have a `Profile` model with a `belongs_to :user`, that means that
in `Profile` you will have a `user_id` field. To check that the reference exists, use:

    check_references :user

Note that here we are no passing the name of the field but the name of the relationship.

### check_negatives
This checks for negatives in the passed in fields.

    check_negatives :points, :logged_in_times

### check_zero
This checks for zero in the passed in fields.

    check_zero :warnings_left

### check_equal
This checks for the equality of two fields (that should be different).
You have to pass the name of both fields.

    check_equal :follower_id, :followed_id

### check_duplicates
This checks for duplicates in the table.

    check_duplicates :user_id


## Testing

Clone this git repo and then run the tests:

    rake


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
