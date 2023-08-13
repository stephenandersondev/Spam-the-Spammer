#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'securerandom'

email_address = ARGV[0]

if email_address.nil?
  puts "Email address required."
  exit
end

puts "Preparing to spam #{email_address}"

driver = Selenium::WebDriver.for :chrome

# Login page
driver.navigate.to 'https://preferences.salemwebnetwork.com/default.aspx?timeout=true'
driver.find_element(link_text: 'Create an account.').click

# Create account
uuid = SecureRandom.uuid.gsub('-', '_')
user_name = email_address.split('@').first + uuid
password = 'flood'

driver.find_element(id: 'txtUsername').send_keys user_name
driver.find_element(id: 'txtPassword').send_keys password
driver.find_element(id: 'txtPasswordConfirm').send_keys password
driver.find_element(id: 'MainContent_txtEmail').send_keys email_address
driver.find_element(id: 'btnSubmit').click

# Sign them up for all mailing lists
driver.find_element(class: 'more-interests').click
driver.find_elements(class: 'interestCheckbox').each(&:click)
driver.find_element(id: 'btnSubmit').click
sleep 5

puts "#{email_address} successfully signed up to be spammed"