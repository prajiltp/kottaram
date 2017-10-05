class GroupPolicy < ApplicationPolicy
  def completed?
  	# The other group members should do this
    !@user.part_of?(record) && @user.active
  end

  def skipped?
  	# The other group members should do this
    !@user.part_of?(record) && @user.active
  end
end
