class PenaltyPolicy < ApplicationPolicy
  def destroy?
  	# Non assignee
    (@user != record.user) && @user.active
  end

  def approve?
  	# Non creator can approve
    record.unconfirmed? && ((@user != record.creator) || (@user == record.user)) && @user.active
  end

  def update?
    record.unconfirmed && @user.active
  end
end
