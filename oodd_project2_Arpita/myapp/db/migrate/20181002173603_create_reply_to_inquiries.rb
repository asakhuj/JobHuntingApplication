class CreateReplyToInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :reply_to_inquiries do |t|
      t.column :reply, :text, :null => false , :presence => true
      t.belongs_to :inquiry, foreign_key: true
      t.timestamps
    end
  end
end
