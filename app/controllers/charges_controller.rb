class ChargesController < ApplicationController
  def new
    if params[:type] == "individual"
      @amount = 60
    else
      @amount = 120
    end
  end

  def create
    # Amount in cents
    if params[:type] == "individual"
      @amount = 60
    else
      @amount = 120
    end


    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount * 100,
      :description => 'Rails Stripe customer',
      :currency    => 'cad'
    )
    CheckoutMailer.checkout(customer).deliver
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
