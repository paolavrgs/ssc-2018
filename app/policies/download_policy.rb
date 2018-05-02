# Policy for Download model
class DownloadPolicy < ControllerPolicy
  attr_reader :user, :objects

  def initialize(user, objects)
    @user = user
    @objects = objects
  end
end
