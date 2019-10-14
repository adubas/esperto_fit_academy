class Employee < ApplicationRecord

  belongs_to :gym

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :registerable,


  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  validates :name, :status, :gym, :email,  presence: { message: 'deve ser preenchido!' }
  validates :email, uniqueness: { message: 'Email deve ser unico!' }
  
  before_validation :corporative_email_constraint

  enum status: {unactive: 0, active: 1}

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active_for_authentication? ? super : :account_inactive
  end

  def translate_status
    I18n.t "activerecord.attributes.employee.statuses.#{status}"
  end

  def gym?(gym)
    self.gym == gym
  end



  private

  def corporative_email_constraint
    corporative_email = /\A([^@\s]+)@espertofit\.com\.br\z/i
    errors.add(:email, "deve ser corporativo!") unless email =~ corporative_email
  end


end
