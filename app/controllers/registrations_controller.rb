class RegistrationsController < Devise::RegistrationsController
  layout "registrations"
  layout "application", only: [:edit, :update]
  def new
    pull_lead
    super
  end

  def create
    build_resource(sign_up_params)
    pull_lead
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      resource.quits.create(length: Quit::Lengths::DEFAULT, start_date: Date.today, substance: params[:group], investment: params[:investment])
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private

    def after_update_path_for(resource)
      edit_registration_path(resource)
    end

    def pull_lead
      @lead = Lead.new(amount: params[:amount], group: params[:group], roll_call: params[:roll_call])
    end

  def update_resource(resource, params)
    resource.update_attributes(params)
  end

end
