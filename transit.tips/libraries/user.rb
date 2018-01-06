#
# Chef Documentation
# https://docs.chef.io/libraries.html
#
module TransitTips
  module UserHelpers
    class User
      attr_reader :name, :home

      def initialize(name, home)
        self.name = name or raise 'name cannot be nil'
        self.home = home or raise 'home cannot be nil'
      end

      def create!
        user name do
          home home
          shell '/bin/bash'
          action :create
        end
      end

      def create_home!
        return unless Dir.exist?(home)

        directory home do
          recursive true
          mode 0755
          owner name
          group name

          action :create
        end
      end

      def transit_tips_path
        File.join(home, node['transit.tips']['dir'])
      end

      private

      attr_writer :name, :home
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
