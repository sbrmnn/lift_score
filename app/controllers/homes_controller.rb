class HomesController < ApplicationController
 def new
   @lead = Lead.new
 end
end
