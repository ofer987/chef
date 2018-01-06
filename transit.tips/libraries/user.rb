#
# Chef Documentation
# https://docs.chef.io/libraries.html
#
module TransitTips
  module UserHelpers
    class User
      attr_reader :name, :home_dir

      def initialize(name, home_dir)
        self.name = name or raise 'name cannot be nil'
        self.home_dir = home_dir or raise 'home_dir cannot be nil'
      end

      def create!
        user name do
          home home_dir
          shell '/bin/bash'
          action :create
        end
      end

      def create_home!
        return unless Dir.exist?(home_dir)

        directory home_dir do
          recursive true
          mode 0755
          owner name
          group name

          action :create
        end
      end

      private

      attr_writer :name, :home_dir
    end

    def chef
      User.new('chef', '/home/chef').tap do |user|
        user.create!
        user.create_home!
      end
    end

    def nginx
      username = node['nginx']['user']

      # assume that the user has already been created
      # by the nginx cookbook
      User.new(username, Dir.home(username))
    end
  end
end
