class ItemsController < ApplicationController
    before_action :authenticate_account!, except: [ :index, :show ]
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_account!
    load_and_authorize_resource
    
    def index
        if account_signed_in?
            @items = Item.all
        else
            redirect_to new_account_session_path
        end
    end

    def new
        @item = Item.new
    end

    def show
    end

    def edit
        if account_signed_in?
            unless @item.account_id == current_account.id
                redirect_to new_account_session_path
            end 
        else
            redirect_to new_account_session_path
        end
    end

    def update
        if @item.update(item_params)
            redirect_to items_path
        else
            render :edit
        end
    end

    def destroy
        @item.destroy
        redirect_to root_path
    end

    def create
        if account_signed_in?
            @item = Item.new item_params
            @item.account_id = current_account.id
            if @item.save
                redirect_to items_path
            else
                render :new
            end
        else
            redirect_to new_account_session_path
        end
    end

    private

    def set_item
        if account_signed_in?
            @item = Item.find(params[:id])
        else
            redirect_to new_account_session_path
        end
    end

    def item_params
        params.require(:item).permit(:name, :price, :description)
    end

end