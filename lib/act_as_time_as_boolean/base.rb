module ActAsTimeAsBoolean

  def self.included(base)
    base.define_singleton_method(:time_as_boolean) do |field, options={}|
      ActAsTimeAsBoolean.time_as_boolean_method field, options
    end
  end

protected

  def self.time_as_boolean_method(field, options)
    field = field.to_sym

    ActAsTimeAsBoolean.field_getter_method field
    ActAsTimeAsBoolean.field_setter_method field

    if options[:opposite]
      ActAsTimeAsBoolean.opposite_getter_method field, options[:opposite]
    end
  end

  def self.field_getter_method(field)
    self.send :define_method, field do
      !send(:"#{field}_at").nil?
    end

    self.send :alias_method, :"#{field}?", :"#{field}"
  end

  def self.field_setter_method(field)
    self.send :define_method, :"#{field}=" do |value|
      if (value && value != 'false' && value != '0' && !self.send(field)) || (!value && self.send(field))
        if value && value != 'false' && value != '0'
          send :"#{field}_at=", Time.now
          true
        else
          send :"#{field}_at=", nil
        end
      end
    end
  end

  def self.opposite_getter_method(field, opposite)
    self.send :define_method, :"#{opposite}" do
      send(:"#{field}_at").nil?
    end

    self.send :alias_method, :"#{opposite}?", :"#{opposite}"
  end
end
