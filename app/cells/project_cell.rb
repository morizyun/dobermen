class ProjectCell < Cell::ViewModel
  include ::Cell::Haml
  include ActionView::Helpers::TranslationHelper

  property :web_url
  property :path_with_namespace
  property :last_activity_at
  property :ruby_version
  property :rails_version
  property :error_message
  property :brakeman_json

  def table_tr
    render
  end

  private

  def message
    if error_message.present?
      error_message
    else
      "security_warnings => #{brakeman_json.warnings}" if brakeman_json.has_warnings?
    end
  end

end
