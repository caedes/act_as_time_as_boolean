module ActAsTimeAsBoolean

  def self.included(base)
    base.define_singleton_method(:time_as_boolean) do |field, options={}|
      field = field.to_sym

      self.send :define_method, field do
        !send(:"#{field}_at").nil?
      end

      self.send :alias_method, :"#{field}?", :"#{field}"

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

      if options[:opposite]
        self.send :define_method, :"#{options[:opposite]}" do
          send(:"#{field}_at").nil?
        end

        self.send :alias_method, :"#{options[:opposite]}?", :"#{options[:opposite]}"
      end
    end
  end
end
