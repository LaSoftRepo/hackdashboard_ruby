class StandUpSerializer < ActiveModel::Serializer
  attributes :id, :update_text, :noted_at, :milestone_id, :user

  def user
    object.user.full_name
  end

  def noted_at
    object.noted_at.strftime('%F')
  end
end
