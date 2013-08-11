ActiveRecord::Schema.define :version => 0 do
  create_table "ip_configs", force: true do |t|
    t.integer  "ip_authenticatable_id"
    t.string   "ip_authenticatable_type"
    t.text     "setting"
    t.datetime "created_at"
  end

  add_index "ip_configs", ["ip_authenticatable_id", "ip_authenticatable_type"], name: "index_ip_configs_on_ip_authenticatable", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "root"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.belongs_to :organization
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin", default: false
  end
end
