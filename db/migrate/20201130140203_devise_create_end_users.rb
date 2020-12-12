# frozen_string_literal: true

class DeviseCreateEndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :end_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :name, null: false
      t.string :address
      t.boolean :is_deleted, null: false, default: false
      t.integer :experience, null: false, default: 0
      t.json :images
      t.integer :sex, null: false, default: 0
      t.date :date_of_birth
      t.text :introduction
      t.float :rate

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :end_users, :email,                unique: true
    add_index :end_users, :reset_password_token, unique: true
    # add_index :end_users, :confirmation_token,   unique: true
    # add_index :end_users, :unlock_token,         unique: true
  end
end
