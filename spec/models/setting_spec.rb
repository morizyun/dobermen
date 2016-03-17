require 'rails_helper'

RSpec.describe Setting, :type => :model do
  # ------------------------------------------------------------------
  # Attributes
  # ------------------------------------------------------------------
  describe '.attributes' do
    it 'has encrypted ssh_key' do
      setting = create(:setting, ssh_key: 'sample')
      ssh_key = ActiveRecord::Base.connection.execute("SELECT ssh_key from settings where id = #{setting.id} limit 1;").values[0][0]
      decrypted_ssh_key = Encryption::Type.new.cast(ssh_key)
      expect(decrypted_ssh_key).to eq 'sample'
    end
  end
end
