class ClientMailer < ApplicationMailer
  def send_welcome(client_id)
    @client = Client.find(client_id)

    mail(to: @client.email, subject: "#{@client.name} boas vindas à EspertoFit")
  end

  def notify_client(client_id)
    @client = Client.find(client_id)

    mail(to: @client.email, subject: "#{@client.name} preencha seu Profile")
  end
end
