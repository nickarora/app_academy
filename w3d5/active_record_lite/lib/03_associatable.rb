require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.to_s.constantize #converts the string to an actual object
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      :foreign_key => "#{name}_id".to_sym,
      :primary_key => :id,
      :class_name => name.to_s.camelcase
    }

    defaults.each do |key, value|
      self.send("#{key}=", options[key] || value )
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      :foreign_key => "#{self_class_name.to_s.underscore}_id".to_sym,
      :primary_key => :id,
      :class_name => name.to_s.singularize.camelcase
    }

    defaults.each do |key, value|
      self.send("#{key}=", options[key] || value )
    end
  end
end

module Associatable
  # Phase IIIb

  def belongs_to(name, options = {})
    
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    assoc = self.assoc_options[name]
    define_method(name) do
      foreign_key_val = self.send(assoc.foreign_key)
      assoc.model_class.where(assoc.primary_key => foreign_key_val).first  
    end

  end

  def has_many(name, options = {})
  
    assoc = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      primary_key_value = self.send(assoc.primary_key)
      assoc.model_class.where(assoc.foreign_key => primary_key_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end

end

class SQLObject
  extend Associatable
end
