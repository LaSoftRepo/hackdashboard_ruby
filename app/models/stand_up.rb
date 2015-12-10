class StandUp < ActiveRecord::Base
  belongs_to :user
  belongs_to :milestone
  belongs_to :stand_up_summary

  validates :update_text, presence: true, length: { in: 2..1000 }
  validates :noted_at, presence: true
  validates :user, presence: true
  validates :milestone, presence: true

  before_save :calculate_milestone_cost

  def calculate_milestone_cost
    cost = self.milestone.cost + (self.user.cost_per_month*8)/168
    self.milestone.update(cost: cost)
  end

end