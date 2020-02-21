# frozen_string_literal: true

class AddImageToProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :products do |t|
      t.attachment :image
    end
  end
end
