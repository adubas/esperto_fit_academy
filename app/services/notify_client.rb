class NotifyClient < ApplicationService
  def initialize(client)
    @client = client
  end

  def call
    check_profile
    notify_api
  end

  def check_profile
    ClientMailer.notify_client(@client.id).deliver_now unless @client.profile
  end

  def notify_api
    Faraday.post("http://payment.com.br/api/v1/payments/ban?cpf=#{@client.cpf}")
  end
end