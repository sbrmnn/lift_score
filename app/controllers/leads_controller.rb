class LeadsController < ApplicationController

  def index
  end

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      redirect_to '/leads'
    else
      flash[:error] = @lead.errors
      redirect_to '/#freeConsultation'
    end
  end

  private

  def lead_params
      params.require(:lead).permit(:name, :email, :phone_number)
  end

end
