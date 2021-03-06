class ChargesController < ApplicationController

  def new
    @roadshow = Roadshow.find(params[:id].to_i)
  end

  def create
    @roadshow = Roadshow.find(params[:id].to_i)

    # Amount in cents
    @amount = 50


    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'eur'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
