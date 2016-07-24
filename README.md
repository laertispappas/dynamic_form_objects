# DynamicFormObjects

Create Form Objects "on the "fly". Useful for defining simple forms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dynamic_form_objects'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamic_form_objects

## Usage
Create a form object:
```ruby
  UserForm = DynamicFormObjects.define_form('UserForm', :name, :age)
 
  # Or add some validations:
  UserForm = DynamicFormObjects.define_form('UserForm', :name, :age).with_validations do 
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
Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dynamic_form_objects.

