class AddIndexUserIdAndCreatedAtToPages < ActiveRecord::Migration
  def change
    add_index :pages, [:user_id, :created_at]
  end
end
