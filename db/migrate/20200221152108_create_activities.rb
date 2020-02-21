class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :subject, type: :uuid, polymorphic: true
      t.references :record, type: :uuid, polymorphic: true
      t.string :type, null: false
      t.string :action, null: false
      t.jsonb :modifications, null: false, default: {}
      t.text :content

      t.timestamps
    end

    add_index :activities, :type
    add_index :activities, :action
  end
end
