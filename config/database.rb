require 'sequel'
require 'mysql'

class Database

	@instance = nil

	def getInstance
		( @instance.nil? ) ? self.new : @instance
	end


	def close
		@db.disconnect
	end

	private
	def initialize(db_name, db_user, db_password)
		@db = Sequel.mysql(db_name, host: 'localhost',
			user: db_user, password: db_password)
	end
end
