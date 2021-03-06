class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    # @customers = Customer.page(params[:page]).per(10)
    @q = Customer.ransack(params[:q])
    @customers = @q.result.page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @custoemr
    else
      render :edit
    end

  end

  def show
    @comment = Comment.new
    # @comments = Comment.where(customer_id: params[:id].to_i)
    @comments = @customer.comments
  end

  def destroy
    @customer.destroy
    redirect_to customers_url
  end

  private

  def customer_params
    params.require(:customer).permit(
      :family_name,
      :ginven_name,
      :email
    )
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end
