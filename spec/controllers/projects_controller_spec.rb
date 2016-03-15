require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  render_views

  describe 'GET index' do
    it 'assigns all projects as @projects' do
      project = create(:project)
      process :index, method: :get
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe 'GET edit' do
    context 'When having project' do
      it 'assigns the requested project as @project' do
        project = create(:project)
        process :edit, method: :get, params: { id: project.to_param }
        expect(assigns(:project)).to eq(project)
      end
    end

    context 'When not having project' do
      it 'assigns the requested project as @project' do
        expect{
          process :edit, method: :get, params: { id: 999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
        # expect(response.status).to eq(404)
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:project) { create(:project) }

      def action
        process :update, method: :put, params: { id: project.to_param, project: { email: 'test@example.com' } }
      end

      it 'updates the requested project' do
        action
        project.reload
        expect(project.email).to eq 'test@example.com'
      end

      it 'assigns the requested project as @project' do
        action
        expect(assigns(:project)).to eq(project)
      end

      it 'redirects to the project' do
        action
        expect(response).to redirect_to( edit_project_path(project))
      end
    end
  end

end
