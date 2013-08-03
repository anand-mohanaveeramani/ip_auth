require 'spec_helper'
require 'ammeter/init'
require 'active_record'
require 'generators/ip_auth/migration/migration_generator'
require 'generators/ip_auth/migration/templates/active_record/migration'

describe IpAuth::MigrationGenerator do
  destination File.expand_path("../../../../../tmp", __FILE__)

  before do
    prepare_destination
    Rails::Generators.options[:rails][:orm] = :active_record
    run_generator
  end

  describe 'db/migrate/acts_as_taggable_on_migration.rb' do
    subject { file('db/migrate/ip_auth_migration.rb') }
    it { should be_a_migration }
  end

end