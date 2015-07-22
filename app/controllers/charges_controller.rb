class ChargesController < ApplicationController

  def new
    @amount = 15_00
    if current_user.customer_id.nil?
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BigMoney Membership - #{current_user.email}",
        amount: @amount
    }
    else
      @stripe_btn_data = {
          key: "#{ Rails.configuration.stripe[:publishable_key] }",
          description: "BigMoney Membership - #{current_user.email}",
          amount: @amount
      }
    end
  end

  def create
    @amount = 15_00

    if current_user.customer_id.nil?
      # Creates a Stripe Customer object, for associating
      # with the charge
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
        current_user.customer_id = customer.id
    end

    if current_user.standard? && current_user.customer_id.nil?
      # Where the real magic happens
        charge = Stripe::Charge.create(
            customer: customer.id, # Note -- this is NOT the user_id in your app
            amount: @amount,
            description: "BigMoney Membership - #{current_user.email}",
            currency: 'usd'
        )

        current_user.update_attribute(:role, 'premium')
    else
      charge = Stripe::Charge.create(
          customer: current_user.customer_id, # Note -- this is NOT the user_id in your app
          amount: @amount,
          description: "BigMoney Membership - #{current_user.email}",
          currency: 'usd'
      )

      current_user.update_attribute(:role, 'premium')
    end


    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user) # or wherever

      # Stripe will send back CardErrors, with friendly messages
      # when something goes wrong.
      # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def delete

  end


  def downgrade
    customer = Stripe::Customer.retrieve(current_user.customer_id)

    charges_id = customer.charges.data.first.id
    #customer.charges.retrieve(charges_id).delete
    current_user.update_attributes(role: 'standard')
    current_user.make_wikis_public
    redirect_to edit_user_registration_path
  end
end
