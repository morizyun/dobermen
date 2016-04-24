class ProjectCell < Cell::ViewModel
  include ::Cell::Haml
  include ActionView::Helpers::TranslationHelper

  property :web_url_with_domain
  property :path_with_namespace
  property :last_activity_at
  property :ruby_version
  property :rails_version
  property :error_message
  property :brakeman_json

  def table_tr
    render
  end

  def warn_table
    render
  end

  private

  def message
    error_message.present? ? error_message : brakeman_json.try(:summary)
  end

  def warn_class(warn)
    if warn.confidence_high?
      'bg-danger'
    elsif warn.confidence_medium?
      'bg-warning'
    else
      ''
    end
  end

end
