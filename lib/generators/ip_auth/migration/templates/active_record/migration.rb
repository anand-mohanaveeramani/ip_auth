class IpAuthMigration < ActiveRecord::Migration
  def self.up
    create_table :ip_settings do |t|
      t.references :ip_authenticatable, polymorphic: true
      t.text :info

      t.datetime :created_at
    end

    add_index :ip_settings, [:ip_authenticatable_id, :ip_authenticatable_type], name: "index_ip_settings_on_ip_authenticatable"
  end

  def self.down
    drop_table :ip_settings
  end
end
