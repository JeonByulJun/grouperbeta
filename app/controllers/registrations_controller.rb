class RegistrationsController < Devise::RegistrationsController
  def new
    @email=params[:email]
    @auth=params[:auth]
    if true
      super
    else
      redirect_to :root
    end
  end

  def create
    super
  end

  def update
    super
  end
end