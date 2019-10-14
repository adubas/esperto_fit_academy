class ClientDecorator < Draper::Decorator
  delegate_all
  
  def joined_at
    created_at.strftime("%B %Y")
  end
end