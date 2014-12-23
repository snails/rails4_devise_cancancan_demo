class User < ActiveRecord::Base
  before_save { self.username = username.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validate :username, uniqueness: { case_sensitive: :false },
    length: { minimum: 6, maximum: 20 },
    exclusion: { in: %w(admin, ftp, www, administrator, noreply) }

  attr_accessor :login

  has_many :posts
  has_many :comments

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def has_role?(role)
    case role
    when :admin then admin?
    else false
    end
  end

  def admin?
    Setting.admin_emails.include?(self.email)
  end

end
