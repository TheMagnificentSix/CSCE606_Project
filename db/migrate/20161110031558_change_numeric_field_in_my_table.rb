class ChangeNumericFieldInMyTable < ActiveRecord::Migration
  def self.up
   change_column :finances, :amount, :decimal, :precision =>15, :scale => 2
  end
end
