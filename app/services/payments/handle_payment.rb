class Payments::HandlePayment

  include Virtus.model

  attribute :user, User
  attribute :stripe_token, String
  attribute :reservation, Reservation

  def call
    create_customer && charge_customer && update_reservation
  end

  private

  def create_customer
    customer_service = Payments::Stripe::CreateCustomer.new(user: user,
    stripe_token: stripe_token)
    customer_service.call
  end

  def charge_customer
    service = Payments::Stripe::ChargeCustomer.new(user: user, description: description, amount: amount)
    @charge_id = service.charge_id if service.call
  end

  def description
    "Charge for reservation id: #{reservation.id}"
  end

  def amount
    reservation.total_price * 100
  end

  def update_reservation
    reservation.stripe_txn_id = @charge_id
    reservation.total_paid = amount/100
    reservation.save
  end

end
