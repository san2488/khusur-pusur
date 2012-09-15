class CreateUserSessions < ActiveRecord::Migration
  def self.up
    create_table :user_sessions do |t|
      t.belongs_to :user
      t.string :ip_address, :path
      t.timestamps
    end
  end

  def self.down
    drop_table :user_sessions
  end
end
