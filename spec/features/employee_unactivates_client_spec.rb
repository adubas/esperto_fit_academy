require 'rails_helper'

feature 'Employee unactivate client' do
  xscenario 'successfully' do
    # arrange
    employee = create(:employee)
    client = create(:client)

    # act
    login_as employee
    visit root_path
    click_on 'Listas'
    click_on 'Lista de Alunos'
    click_on client.name 
    click_on 'SUSPENDER ALUNO'

    # assert
    expect(current_path).to eq client_path(client.id) 
    expect(page).to have_content('CPF suspenso com sucesso!')
    expect(page).to have_content('Status: suspended')
  end

  xscenario 'and link must not show when client is alredy suspended' do
    # arrange
    client = create(:client, status: 2)
    employee = create(:employee)

    # act
    login_as employee
    visit root_path
    click_on 'Listas'
    click_on 'Lista de Alunos'
    click_on client.name

    # assert 
    expect(current_path).to eq client_path(client.id) 
    expect(page).to have_content('Status: suspended')
    expect(page).not_to have_content('SUSPENDER ALUNO') 
  end

  scenario 'and link must be protected to visitors' do
    # arrange
    client = create(:client, status: 0)

    # act
    visit suspend_client_path(client)

    #assert 
    expect(current_path).to eq new_employee_session_path
  end

  scenario 'and client must exist' do
    #arrange
    employee = create(:employee)

    #act
    login_as employee
    visit suspend_client_path(1)

    #assert
    expect(current_path).to eq clients_path
    expect(page).to have_content('Não existe esse aluno!')
  end
end