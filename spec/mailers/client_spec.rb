require "rails_helper"

RSpec.describe ClientMailer, type: :mailer do
  describe 'send emails' do
    it 'welcoming the client' do
      client = create(:client, email: 'client@teste.com')

      mail = ClientMailer.send_welcome(client.id)

      expect(mail.to).to include client.email
      expect(mail.body).to have_content("#{client.name} boas vindas à EspertoFit.")

    end

    it 'notify client of lack of profile' do
      client = create(:client, email: 'client@teste.com')

      mail = ClientMailer.notify_client(client.id)

      expect(mail.to).to include client.email
      expect(mail.body).to have_content("#{client.name} notamos que seu profile ainda não foi preenchido.")
    end
  end
end
