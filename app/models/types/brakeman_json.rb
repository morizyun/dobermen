class BrakemanJson
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

  class Warn
    def initialize(json)
      @json = json
    end

    def type
      @json[:warning_type]
    end

    def message
      @json[:message]
    end

    def path
      "#{@json[:file]}#L#{@json[:line]}"
    end

    # Reference URL
    def reference_url
      @json[:link]
    end

    # High or Medium or etc
    def confidence
      @json[:confidence]
    end

    # High => true, else => false
    def confidence_high?
      @json[:confidence] == 'High'
    end

    # Medium => true, else => false
    def confidence_medium?
      @json[:confidence] == 'Medium'
    end
  end

  def initialize(hash)
    @json = hash.try(:deep_symbolize_keys) || {}
  end

  def summary
    if has_warning?
      "security_warnings => #{warnings.count}"
    else
      'No security issue!'
    end
  end

  def has_warning?
    warnings.count.to_i > 0
  end

  def warnings
    @warn ||= _warnings
  end

  def ruby_version
    @json[:scan_info][:ruby_version]
  end

  def rails_version
    @json[:scan_info][:rails_version]
  end

  def to_h
    @json
  end

  private

  def _warnings
    Array(@json[:warnings]).map { |warn| Warn.new(warn) }.presence || []
  end

end


