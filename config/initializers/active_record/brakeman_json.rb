class BrakemanJson
  def initialize(hash)
    @json = hash.try(:symbolize_keys) || {}
  end

  def warnings
    @json[:security_warnings]
  end

  def has_warnings?
    warnings.present?
  end

  def to_h
    @json
  end

  # For casting Project.brakeman_json
  class Type < ActiveRecord::Type::Value
    def type
      :json
    end

    def cast(value)
      if String === value
        decoded = ::ActiveSupport::JSON.decode(value) rescue nil
        ::BrakemanJson.new(decoded)
      else
        super
      end
    end

    def serialize(value)
      case value
        when Hash
          ::ActiveSupport::JSON.encode(value)
        when ::BrakemanJson
          ::ActiveSupport::JSON.encode(value.to_h)
        else
          super
      end
    end
  end
end

# Adding BrakemanJson::Type to ActiveRecord::Type
ActiveRecord::Type.register(:brakeman_json, BrakemanJson::Type)

