class RemoveHostFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :host, :string
  end
end
