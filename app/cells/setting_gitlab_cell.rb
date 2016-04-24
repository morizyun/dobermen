class SettingGitlabCell < Cell::ViewModel
  include ::Cell::Haml
  include ActionView::Helpers::TranslationHelper

  property :base_url

  def table_tr
    render
  end

end
