class IpAuthMigration < ActiveRecord::Migration
  AUTHENTICATABLE_OBJ_INDEX_NAME = "index_ip_settings_on_ip_authenticatable"

  def self.up
    create_table :ip_settings do |t|
      t.references :ip_authenticatable, polymorphic: true
      t.text :info

      t.datetime :created_at
    end

    add_index :ip_settings, [:ip_authenticatable_id, :ip_authenticatable_type], name: AUTHENTICATABLE_OBJ_INDEX_NAME
  end

  def self.down
    remove_index :ip_settings, name: AUTHENTICATABLE_OBJ_INDEX_NAME
    drop_table :ip_settings
  end
end
