# Policy for Message model
class MessagePolicy < ControllerPolicy
  attr_reader :user, :objects

  def initialize(user, objects)
    @user = user
    @objects = objects
  end

  def new?
    true
  end

  def create?
    true
  end
end
