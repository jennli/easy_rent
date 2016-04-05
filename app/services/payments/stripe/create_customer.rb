class Payments::Stripe::CreateCustomer

  include Virtus.model

  attribute :user, User
  attribute :stripe_token, String

  # use the stripe customer information to store in the user record
  def call
    call_stripe_customer_create && save_user_data
  end

  private

  def call_stripe_customer_create
    begin
      stripe_customer
    rescue => e
      # You may want to email admin with the error `e`
      false
    end
  end

  def stripe_customer
    @stripe_customer ||=  Stripe::Customer.create(
    description: "Customer for #{user.email}",
    source:      stripe_token
    )
  end

  def save_user_data
    user.stripe_customer_id       = stripe_customer.id
    user.stripe_card_type         = stripe_customer.sources.data[0].brand
    user.stripe_last_4            = stripe_customer.sources.data[0].last4
    user.stripe_card_expiry_month = stripe_customer.sources.data[0].exp_month
    user.stripe_card_expiry_year  = stripe_customer.sources.data[0].exp_year
    user.save
  end

end
