class ChangeContentClomnTextToMediumText < ActiveRecord::Migration
  def change
    change_column(:pages, :content, :text, :limit => 16777215)
  end
end
