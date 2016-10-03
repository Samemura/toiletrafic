module ActiveRecord
  module RailsAdminEnum
    def enum(definitions)
      super
      definitions.each do |name, values|
        define_method("#{ name }_enum") { self.class.send(name.to_s.pluralize).to_a }
        define_method("#{ name }=") do |value|
          if value.kind_of?(String) and value.to_i.to_s == value
            super value.to_i
          else
            super value
          end
        end
      end
    end
  end
end
ActiveRecord::Base.send(:extend, ActiveRecord::RailsAdminEnum)

RailsAdmin.config do |config|
  config.main_app_name = 'Toiletraffic'

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  # == PaperTrail ==
  PAPER_TRAIL_AUDIT_MODELS = [:Booth]
  PAPER_TRAIL_AUDIT_MODELS.each do |m|
    config.audit_with :paper_trail, m, 'PaperTrail::Version' # PaperTrail >= 3.0.0
  end

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete

    # With an audit adapter, you can add:
    history_index do
      only PAPER_TRAIL_AUDIT_MODELS
    end
    history_show do
      only PAPER_TRAIL_AUDIT_MODELS
    end
  end
end
