
require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "phnny@bitmakerlabs.com", "Rocksr"))
@@rolodex.add_contact(Contact.new("hello", "Bao", "jonny@bitmakerlabs.com", "Rocksta"))
@@rolodex.add_contact(Contact.new("Jo", "Bvo", "johnn@bitmakerlabs.com", "Rocksar"))
@@rolodex.add_contact(Contact.new("Joh", "Ravo", "johny@bitmakerlabs.com", "Rokstar"))
@@rolodex.add_contact(Contact.new("John", "Bvo", "jhnny@bitmakerlabs.com", "Rckstar"))
@@rolodex.add_contact(Contact.new("Johnn", "Brvo", "jhnny@bitmakerlabs.com", "Rkstar"))
@@rolodex.add_contact(Contact.new("Jhnny", "Bra", "jnny@bitmakerlabs.com", "Rtar"))
@@rolodex.add_contact(Contact.new("Ohnny", "Brav", "jnny@bitrlabs.com", "Rr"))


get '/' do 
	erb :index
end

get '/contacts' do
	erb :contact
end

get '/contacts/new' do
	erb :new_contact
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

# get "/contacts/1000" do
# 	@contacts = @@rolodex.find(params[:id].to_i)
# 	erb :show_contact
# end

get "/contacts/search" do
  erb :search_contact
end

post "/contacts/do_search" do
	puts params
	@contact = @@rolodex.contacts.find{|contact| contact.first_name == params[:first_name] && contact.last_name == params[:last_name]}	
	erb :show_contact
end

get "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# get "/contacts/:id/edit" do
#   erb :edit_contact
# end

# get "/contacts/edit" do
#   erb :edit_contact
# end

# post "/contacts/do_search" do
# 	puts params
# 	@contact = @@rolodex.contacts.find{|contact| contact.first_name == params[:first_name] && contact.last_name == params[:last_name]}	
# 	erb :edit_contact_show
# end


# get "/contacts/:id/edit" do
#   @contact = @@rolodex.find_contact(params[:id].to_i)
#   if @contact
#     erb :edit_contact
#   else
#     raise Sinatra::NotFound
#   end
# end

put "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
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

 
