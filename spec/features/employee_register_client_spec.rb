require 'rails_helper'

feature 'clients register on gym ' do
  scenario 'successfully' do
    load_profile_mock
    employee = create(:employee)
    create(:gym)
    other_gym = create(:gym)
    plan = create(:plan)
    create(:plan, name: 'Basic')

    login_as employee

    visit root_path
    click_on 'Cadastros'
    click_on 'Cadastrar Aluno'

    fill_in 'Nome', with: 'Vinícius'
    fill_in 'CPF', with: '12345678900'
    fill_in 'E-mail', with: 'vini@gmail.com'
    select plan.name, from: 'Plano'
    select other_gym.name, from: 'Academia'

    click_on 'Criar Matrícula'

    expect(page).to have_css('p', text: 'Vinícius')
    expect(page).to have_css('p', text: '12345678900')
    expect(page).to have_css('p', text: 'vini@gmail.com')
    expect(page).to have_css('p', text: plan.name)
    expect(page).to have_css('p', text: other_gym.name)
    expect(page).to have_content('Matriculado com sucesso!')
  end

  scenario 'and cpf must be unique' do
    employee = create(:employee)
    gym = create(:gym)
    other_gym = create(:gym)
    plan = create(:plan)
    other_plan = create(:plan, name: 'Basic')
    create(:client, cpf: '385.093.321-08', gym: gym, plan: plan)

    login_as employee

    visit root_path
    click_on 'Cadastros'
    click_on 'Cadastrar Aluno'

    fill_in 'Nome', with: 'Vinícius'
    fill_in 'CPF', with: '385.093.321-08'
    fill_in 'E-mail', with: 'vini@gmail.com'
    select other_plan.name, from: 'Plano'
    select other_gym.name, from: 'Academia'
    click_on 'Criar Matrícula'

    expect(page).to have_content('CPF já está em uso')
  end

  scenario 'and must fill all fields' do
    employee = create(:employee)
    create(:gym)
    other_gym = create(:gym)
    create(:plan)
    other_plan = create(:plan, name: 'Basic')

    login_as employee

    visit root_path
    click_on 'Cadastros'
    click_on 'Cadastrar Aluno'

    fill_in 'Nome', with: 'Vinícius'
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: 'vini@gmail.com'
    select other_plan.name, from: 'Plano'
    select other_gym.name, from: 'Academia'
    click_on 'Criar Matrícula'

    expect(page).to have_content('CPF não pode ficar em branco')
  end
end
