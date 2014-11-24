require 'active_support/concern'

module ActAsTimeAsBoolean
  extend ActiveSupport::Concern

  module ClassMethods
    def time_as_boolean(field, options = {})
      define_method field do
        !send(:"#{field}_at").nil?
      end
      send :alias_method, :"#{field}?", :"#{field}"

      define_method :"#{field}=" do |value|
        value = value && value.to_s != '0'
        if value && !send(field)
          send :"#{field}_at=", Time.now
          true
        elsif !value && send(field)
          send :"#{field}_at=", nil
        end
      end

      define_method :"#{field}!" do
        send :"before_#{field}" if respond_to? :"before_#{field}"
        send :"#{field}=", true
        save!
        send :"after_#{field}" if respond_to? :"after_#{field}"
      end

      scope field, -> {
        where "#{table_name}.#{field}_at IS NOT NULL AND #{table_name}.#{field}_at <= ?", Time.current
      }

      if options[:opposite]
        opposite = options[:opposite]
        define_method :"#{opposite}" do
          send(:"#{field}_at").nil?
        end
        send :alias_method, :"#{opposite}?", :"#{opposite}"

        define_method :"#{opposite}!" do
          send :"before_#{opposite}" if respond_to? :"before_#{opposite}"
          send :"#{field}=", false
          save!
          send :"after_#{opposite}" if respond_to? :"after_#{opposite}"
        end

        scope opposite, -> {
          where "#{table_name}.#{field}_at IS NULL OR #{table_name}.#{field}_at > ?", Time.current
        }
      end
    end
  end
end
