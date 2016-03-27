class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :url
      t.string :host
      t.text :contents

      t.timestamps
    end
  end
end
