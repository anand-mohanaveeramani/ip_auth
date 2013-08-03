class IpAuthMigration < ActiveRecord::Migration
  AUTHENTICATABLE_OBJ_INDEX_NAME = "index_ip_configs_on_ip_authenticatable"

  def self.up
    create_table :ip_configs do |t|
      t.references :ip_authenticatable, polymorphic: true
      t.text :setting

      t.datetime :created_at
    end

    add_index :ip_configs, [:ip_authenticatable_id, :ip_authenticatable_type], name: AUTHENTICATABLE_OBJ_INDEX_NAME
  end

  def self.down
    remove_index :ip_configs, name: AUTHENTICATABLE_OBJ_INDEX_NAME
    drop_table :ip_configs
  end
end
