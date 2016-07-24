# SimpleFormObject

Create Form Objects "on the "fly". Useful for defining simple forms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_form_object'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_form_object

## Usage
Create a form object:
```ruby
  UserForm = SimpleFormObject.define_form('UserForm', :name, :age)
 
  # Or add some validations:
  UserForm = SimpleFormObject.define_form('UserForm', :name, :age).with_validations do 
    validates_presence_of :name
    # Other validations...
  end

  def new
    @user = UserForm.new
  end

  def create
    @user = UserForm.new(params[:user])
    if @user.valid?
      ...
    else
      ...
    end
  end

```

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_form_object.

