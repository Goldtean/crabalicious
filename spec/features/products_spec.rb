require 'rails_helper'
require_relative '../support/auth_helper'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

RSpec.feature "Guests", type: :feature, js: true do
  context 'a guest user' do |variable|
    it 'can see the title page' do
      visit root_path
      expect(page).to have_content("Ye Olde Shoppe Products")
    end
  end
end

RSpec.feature "Admins", type: :feature, js: true do
  context 'an administrator' do
      it 'requires auth' do
        visit admin_path
      end
  end
end