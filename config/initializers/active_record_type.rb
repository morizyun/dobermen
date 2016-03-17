# Adding BrakemanJson::Type to ActiveRecord::Type
ActiveRecord::Type.register(:brakeman_json, BrakemanJson::Type)

ActiveRecord::Type.register(:encryption, Encryption::Type)