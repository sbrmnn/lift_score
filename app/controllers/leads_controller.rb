class LeadsController < ApplicationController

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @lead
    else
      flash[:error] = @lead.errors
      flash.keep(:error)
      redirect_to '/#freeConsultation'
    end
  end

  private

  def lead_params
      params.require(:lead).permit(:name, :email, :phone_number)
  end

end
