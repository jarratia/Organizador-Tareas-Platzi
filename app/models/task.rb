# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  #Validate ever has participants
  validates :participating_users, presence: true

  #Validate presence
  validates :name, :description, presence: true

  #validate uniqueness
  validates :name, uniqueness: {case_insensitive: false}

  #validate personalizado
  validate :due_date_validity

  #validate information anidate
  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    #return if due date is blank
    return if due_date.blank?

    #Si due date es mayor al día de hoy, está correcto
    return if due_date > Date.today

    #Errors
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end
end
