require 'rails_helper'

feature 'employee edit client' do
  scenario 'successffully' do
    load_profile_mock
    stub_request(:post, "http://payment.com.br/api/v1/payments/ban?cpf=12345678900").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Content-Length'=>'0',
       	  'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: "", headers: {})

    plan = create(:plan)
    gym = create(:gym)
    client = create(:client, name: 'Gabi', plan: plan, cpf: '12345678900', gym: gym)
    employee = create(:employee)
    other_plan = create(:plan, name: 'Flex')
    other_gym = create(:gym)

    login_as employee

    visit root_path
    click_on 'Listas'
    click_on 'Lista de Alunos'
    click_on 'Gabi'
    click_on 'Editar'

    select other_plan.name, from: 'Plano'
    select other_gym.name, from: 'Academia'

    click_on 'Atualizar Matrícula'

    expect(page).to have_css('p', text: 'Gabi')
    expect(page).to have_css('p', text: '12345678900')
    expect(page).to have_css('p', text: 'vini@gmail.com')
    expect(page).to have_css('p', text: other_plan.name)
    expect(page).to have_css('p', text: other_gym.name)
    expect(page).to have_content('Atualizado com sucesso!')
  end

  scenario 'and must fill al fields' do
    load_profile_mock
    client = create(:client, name: 'Gabi', cpf: '12345678900')
    employee = create(:employee)

    login_as employee

    visit root_path
    click_on 'Listas'
    click_on 'Lista de Alunos'
    click_on 'Gabi'
    click_on 'Editar'

    fill_in 'Nome', with: ''

    click_on 'Atualizar Matrícula'

    expect(page).to have_content('Nome completo não pode ficar em branco')
  end

  scenario 'and view client list' do
    load_profile_mock
    client = create(:client, name: 'Gabi', cpf: '12345678900')
    employee = create(:employee)

    login_as employee

    visit root_path
    click_on 'Listas'
    click_on 'Lista de Alunos'

    expect(page).to have_content('Gabi')
    expect(page).to have_content('October 2019')
  end
end