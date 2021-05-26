class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments do |t|
      t.binary :data,         :null => false
      t.string :filename
      t.string :mime_type
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
