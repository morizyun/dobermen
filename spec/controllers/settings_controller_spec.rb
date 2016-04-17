require 'rails_helper'

RSpec.describe SettingsController, :type => :controller do
  describe 'GET setting_show_path' do
    context 'When there is setting record' do
      it 'assigns the requested setting as @setting' do
        setting = create(:setting, id: 1)
        process :show, method: :get
        expect(assigns(:setting)).to eq(setting)
      end
    end

    context 'When there is not setting record' do
      it 'assigns the requested setting as @setting' do
        process :show, method: :get
        expect(assigns(:setting).id).to eq(1)
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { email: 'new_email@example.com' } }

      it 'updates the requested setting' do
        setting = create(:setting, id: 1, email: 'exist_email@example.com')
        process :update, method: :put, params: { setting: new_attributes }
        setting.reload
        expect(assigns(:setting).email).to eq('new_email@example.com')
      end

      it 'redirects to the setting' do
        create(:setting, id: 1, email: 'exist_email@example.com')
        process :update, method: :put, params: { setting: new_attributes }
        expect(response).to redirect_to(setting_show_path)
      end
    end
  end
end
