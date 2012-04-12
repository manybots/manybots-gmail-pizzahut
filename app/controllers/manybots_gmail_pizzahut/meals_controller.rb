module ManybotsGmailPizzahut
  class MealsController < ApplicationController
    before_filter :authenticate_user!
    
    def show
      @meal = ManybotsGmailPizzahut::Meal.find_by_id_and_user_id(params[:id], current_user.id)
      
    end
  end
end
