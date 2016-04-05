class AddAasmStateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :aasm_state, :string
    add_index :reservations, :aasm_state
  end
end
