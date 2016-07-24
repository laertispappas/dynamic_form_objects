require "simple_form_object/version"
require 'active_model'

module SimpleFormObject
  # Defines a new form object: 
  #
  # Usage:
  # 
  # UserForm = SimpleFormObject.define_form("UserForm", :first_name, :last_name, :age, :password).with_validations do
  #   validates_presence_of :first_name
  #   validates_presence_of :last_name
  # end
  #
  # -- or
  # UserForm = SimpleFormObject.define_form("UserForm").
  #   with_validations { validates_presence_of :name}.
  #   with_validations { validates_presence_of :age }
  #
  # -- Create a new instance
  # user_form = UserForm.new
  # user_form = UserForm.new first_name: 'Foo', last_name: 'Bar'
  #
  # -- Check if valid
  # if user_form.valid?
  # ...

  def self.define_form(form_name, *args)
    Class.new(Object) do |klass|
      include ActiveModel::Model

      attr_reader(*args)

      @__attrs = args
      @__form_name = form_name

      def self.attrs
        @__attrs
      end

      def self.with_validations(&block)
        class_eval(&block)
        self
      end

      def self.model_name
        ActiveModel::Name.new(self, nil, @__form_name)
      end

      def initialize(opts = {})
        set_instance_variables(opts)
      end

      def to_h
        @__hash_value
      end
      alias_method :to_hash, :to_h

      def persisted?
        false
      end

      def set_instance_variables(opts = {})
        defined_attrs = self.class.attrs
        attrs_and_values = defined_attrs.map{|k| [k, opts[k]]}
        attrs_and_values.each do |k, v|
          instance_variable_set("@#{k.to_s}", v)
        end

        instance_variable_set("@__hash_value", Hash[attrs_and_values])
      end
      private :set_instance_variables
    end
  end
end
