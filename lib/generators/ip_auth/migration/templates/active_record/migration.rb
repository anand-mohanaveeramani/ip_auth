class IpAuthMigration < ActiveRecord::Migration
  AUTHORIZABLE_OBJ_INDEX_NAME = "index_ip_configs_on_ip_authorizable"

  def self.up
    create_table :ip_configs do |t|
      t.references :ip_authorizable, polymorphic: true
      t.text :setting

      t.datetime :created_at
    end

    add_index :ip_configs, [:ip_authorizable_id, :ip_authorizable_type], name: AUTHORIZABLE_OBJ_INDEX_NAME
  end

  def self.down
    remove_index :ip_configs, name: AUTHORIZABLE_OBJ_INDEX_NAME
    drop_table :ip_configs
  end
end
