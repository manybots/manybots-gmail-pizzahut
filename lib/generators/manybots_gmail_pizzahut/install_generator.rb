require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/migration'

module ManybotsGmailPizzahut
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path("../../templates", __FILE__)
      
      class_option :routes, :desc => "Generate routes", :type => :boolean, :default => true
      class_option :migrations, :desc => "Generate migrations", :type => :boolean, :default => true
      
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
      
      desc 'Mounts Manybots Gmail Pizzahut at "/manybots-gmail-pizzahut"'
      def add_manybots_gmail_pizzahut_routes
        route 'mount ManybotsGmailPizzahut::Engine => "/manybots-gmail-pizzahut"' if options.routes?
      end
      
      desc "Copies Manybots Gmail Pizzahut migrations"
      def create_model_file
        migration_template "create_manybots_gmail_pizzahut_meals.rb", "db/migrate/create_manybots_gmail_pizzahut_meals.manybots_gmail_pizzahut.rb"
      end
      
      desc "Creates a ManybotsGmail initializer"
      def copy_initializer
        template "manybots-gmail-pizzahut.rb", "config/initializers/manybots-gmail-pizzahut.rb"
      end
      
      def show_readme
        readme "README" if behavior == :invoke
      end
      
    end
  end
end
