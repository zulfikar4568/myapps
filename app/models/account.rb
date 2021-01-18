class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :role, optional: true
  has_many :items, dependent: :destroy
  
  validates_presence_of :first_name, :last_name, :username
  before_save :assign_role
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def assign_role
    self.role = Role.find_by name: 'Regular' if role.nil?
  end

  def admin?
    role.name == 'Admin'
  end

  def seller?
    role.name == 'Seller'
  end

  def regular?
    role.name == 'Regular'
  end
  
end
