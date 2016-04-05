class AddTotalPaidToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :total_paid, :integer
  end
end
