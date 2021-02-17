class ChangeDataMatomeToSummaries < ActiveRecord::Migration[6.0]
  def change
    change_column :summaries, :matome, :text
  end
end
