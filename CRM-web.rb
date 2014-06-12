
require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

get '/' do 
	erb :index
end

get '/contacts' do
	erb :contact
end

get '/contacts/new' do
	erb :new_contact
end

get '/contacts' do
	puts params
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/')
end

get "/contacts/1000" do
	@contact = @@rolodex.find(1000)
	erb :show_contact
end






# require 'sinatra'
# require_relative 'contact'

# get '/' do
# 	@crm_app_name = "My CRM"
# 	erb :index
# end

# #view all contacts
# get "/contacts" do
#   @contacts = []
#   @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
#   @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
#   @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")

#   erb :contacts
# end

 
