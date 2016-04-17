require 'rails_helper'

RSpec.describe SettingGitlabsController, :type => :controller do
  let(:valid_attributes) { attributes_for(:setting_gitlab) }
  let(:invalid_attributes) { attributes_for(:setting_gitlab).merge(base_url: nil) }
  let(:valid_session) { {} }

  describe 'GET index' do
    it 'assigns all setting_gitlabs as @setting_gitlabs' do
      setting_gitlab = SettingGitlab.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:setting_gitlabs)).to eq([setting_gitlab])
    end
  end

  describe 'GET new' do
    it 'assigns a new setting_gitlab as @setting_gitlab' do
      get :new, {}, valid_session
      expect(assigns(:setting_gitlab)).to be_a_new(SettingGitlab)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested setting_gitlab as @setting_gitlab' do
      setting_gitlab = SettingGitlab.create! valid_attributes
      get :edit, {:id => setting_gitlab.to_param}, valid_session
      expect(assigns(:setting_gitlab)).to eq(setting_gitlab)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new SettingGitlab' do
        expect {
          post :create, {:setting_gitlab => valid_attributes}, valid_session
        }.to change(SettingGitlab, :count).by(1)
      end

      it 'assigns a newly created setting_gitlab as @setting_gitlab' do
        post :create, {:setting_gitlab => valid_attributes}, valid_session
        expect(assigns(:setting_gitlab)).to be_a(SettingGitlab)
        expect(assigns(:setting_gitlab)).to be_persisted
      end

      it 'redirects to the created setting_gitlab' do
        post :create, {:setting_gitlab => valid_attributes}, valid_session
        expect(response).to redirect_to(setting_gitlabs_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved setting_gitlab as @setting_gitlab' do
        post :create, {:setting_gitlab => invalid_attributes}, valid_session
        expect(assigns(:setting_gitlab)).to be_a_new(SettingGitlab)
      end

      it "re-renders the 'new' template" do
        post :create, {:setting_gitlab => invalid_attributes}, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested setting_gitlab' do
        setting_gitlab = SettingGitlab.create! valid_attributes
        put :update, {:id => setting_gitlab.to_param, :setting_gitlab => new_attributes}, valid_session
        setting_gitlab.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested setting_gitlab as @setting_gitlab' do
        setting_gitlab = SettingGitlab.create! valid_attributes
        put :update, {:id => setting_gitlab.to_param, :setting_gitlab => valid_attributes}, valid_session
        expect(assigns(:setting_gitlab)).to eq(setting_gitlab)
      end

      it 'redirects to the setting_gitlab' do
        setting_gitlab = SettingGitlab.create! valid_attributes
        put :update, {:id => setting_gitlab.to_param, :setting_gitlab => valid_attributes}, valid_session
        expect(response).to redirect_to(setting_gitlabs_url)
      end
    end

    describe 'with invalid params' do
      it 'assigns the setting_gitlab as @setting_gitlab' do
        setting_gitlab = SettingGitlab.create! valid_attributes
        put :update, {:id => setting_gitlab.to_param, :setting_gitlab => invalid_attributes}, valid_session
        expect(assigns(:setting_gitlab)).to eq(setting_gitlab)
      end

      it "re-renders the 'edit' template" do
        setting_gitlab = SettingGitlab.create! valid_attributes
        put :update, {:id => setting_gitlab.to_param, :setting_gitlab => invalid_attributes}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested setting_gitlab' do
      setting_gitlab = SettingGitlab.create! valid_attributes
      expect {
        delete :destroy, {:id => setting_gitlab.to_param}, valid_session
      }.to change(SettingGitlab, :count).by(-1)
    end

    it 'redirects to the setting_gitlabs list' do
      setting_gitlab = SettingGitlab.create! valid_attributes
      delete :destroy, {:id => setting_gitlab.to_param}, valid_session
      expect(response).to redirect_to(setting_gitlabs_url)
    end
  end

end
