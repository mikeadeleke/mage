require 'digest'
class User < ActiveRecord::Base
	attr_accessible :username, :email, :password, :password_confirmation, :bio
	has_secure_password

	has_many :resources

	# searchable do
	# 	text :username, :default_boost => 2
	# 	text :bio
	# end

	validates :username, uniqueness: { case_sensitive: false }, length: { :in => 3..20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
	validates_format_of :username, :with => /^[A-Za-z\d_]+$/

	# before_save :encrypt_password
	before_save { |user| user.username = username.downcase }
	before_save :create_remember_token

	def has_password?(submitted_password)
		encrypted_password = encrypt(submitted_password)
	end

	# def authenticate(email, submitted_password)
	#     user = User.find_by_email(email)
	#     if user.nil?
	#       nil
	#     elsif user.has_password?(submitted_password)
	#       user
	#     end
	# end

	def self.home_list
		uncached do
			limit(6)
		end
	end

	private

		def encrypt_password
			self.salt = make_salt unless has_password?(password)
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end