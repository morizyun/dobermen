class Encryption
  class Type < ActiveRecord::Type::Value
    # ------------------------------------------------------------------
    # Constants
    # ------------------------------------------------------------------
    CIPHER = 'aes-256-cbc'.freeze

    # ------------------------------------------------------------------
    # Public Instance Methods
    # ------------------------------------------------------------------
    def type
      :string
    end

    def cast(value)
      if String === value
        _decrypt?(value) ? _decrypt(value) : value
      else
        super
      end
    end

    def serialize(value)
      case value
        when String
          _decrypt?(value) ? value : _encrypt(value)
        else
          super
      end
    end

    private
    # ------------------------------------------------------------------
    # Private Instance Methods
    # ------------------------------------------------------------------
    def _decrypt(value)
      crypt = ActiveSupport::MessageEncryptor.new(ENV['SECURE_SALT'], ::Encryption::Type::CIPHER)
      crypt.decrypt_and_verify(value)
    rescue
      nil
    end

    def _encrypt(value)
      crypt = ActiveSupport::MessageEncryptor.new(ENV['SECURE_SALT'], ::Encryption::Type::CIPHER)
      crypt.encrypt_and_sign(value)
    rescue
      nil
    end

    def _decrypt?(value)
      _decrypt(value).present?
    end
  end
end
