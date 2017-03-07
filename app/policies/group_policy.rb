class GroupPolicy < ApplicationPolicy
  def completed?
  	# The other group members should do this
    !@user.part_of?(record)
  end

  def skipped?
  	# The other group members should do this
    !@user.part_of?(record)
  end
end
