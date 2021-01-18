class PublicController < ApplicationController
    def index
        if account_signed_in?
        end
        @items = Item.all
    end

    def profile
        @profile = Account.find_by_username params[:username]
    end
end