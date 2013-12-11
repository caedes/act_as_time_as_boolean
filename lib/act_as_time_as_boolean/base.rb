module ActAsTimeAsBoolean
  def self.included(base)
    base.define_singleton_method(:time_as_boolean) do |field, options = {}|
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
    send :define_method, field do
      !send(:"#{field}_at").nil?
    end

    send :alias_method, :"#{field}?", :"#{field}"
  end

  def self.field_setter_method(field)
    send :define_method, :"#{field}=" do |value|
      value = value && value.to_s != '0'
      if value && !send(field)
        send :"#{field}_at=", Time.now
        true
      elsif !value && send(field)
        send :"#{field}_at=", nil
      end
    end
  end

  def self.opposite_getter_method(field, opposite)
    send :define_method, :"#{opposite}" do
      send(:"#{field}_at").nil?
    end

    send :alias_method, :"#{opposite}?", :"#{opposite}"
  end
end
