require 'spec_helper'

describe SimpleFormObject do
  context "Form with no validations" do
    let(:form) { SimpleFormObject.define_form("UserForm", :name, :password) }

    it 'instantiates a new form from a hash' do
      instance = form.new(name: 'Laertis', password: 'pappas', not_assigned: 'aaa')
      expect(instance.name).to eq 'Laertis'
      expect(instance.password).to eq 'pappas'
      expect(instance).to_not respond_to :not_assigned
    end
    it 'converts to hash' do
      instance = form.new(name: 'laertis', password: 'pappas')
      hash = instance.to_hash

      expect(hash).to eq(name: 'laertis', password: 'pappas')
    end
    it 'validates the form' do
      instance = form.new
      expect(instance).to be_valid
    end

    it 'has not error messages' do
      instance = form.new
      expect(instance).to be_valid
      expect(instance.errors.full_messages).to be_empty
    end
    it 'implementes model_name' do
      expect(form.model_name).to eq 'UserForm'
    end
  end

  context "Form with validations" do
    let(:form) do
      SimpleFormObject.define_form("UserForm", :name, :age, :password).with_validations do
        validates_presence_of :name
        validates :age, presence: true
      end
    end

    context "when all required fields are present" do
      let(:instance) { form.new(name: 'for', age: 12) }
      it 'validates the form' do
        expect(instance).to be_valid
        expect(instance.errors.full_messages).to be_empty
      end
    end

    context "when the required fields are not present" do
      let(:instance) { form.new }

      it 'validates the form' do
        expect(instance).to_not be_valid
        expect(instance.errors.full_messages.size).to eq 2

        expect(instance.errors.full_messages).to include(/Name can't be blank/)
        expect(instance.errors.full_messages).to include(/Age can't be blank/)
      end
    end
  end
end
