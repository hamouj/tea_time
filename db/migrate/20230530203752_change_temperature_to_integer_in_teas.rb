class ChangeTemperatureToIntegerInTeas < ActiveRecord::Migration[7.0]
  def change
    change_column :teas, :temperature, :integer
  end
end
