class User < ActiveRecord::Base
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_default_role

  private
   def set_default_role
     self.role ||= Role.find_by_name('registered')
   end

end
