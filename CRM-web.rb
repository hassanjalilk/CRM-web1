
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

Contact.create(
  first_name: "Johnny",
  last_name: "Bravo",
  email: "jbravo@bitmakerlabs.com",
  note: "Rockstar"
)

get '/' do 
	erb :index
end

get '/contacts' do
  @contacts = Contact.all
	erb :contact
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
    )
  redirect to ('/contacts')
end

get "/contacts/1000" do
	@contact = Contact.get(1000)
	erb :show_contact
end

get "/contacts/search" do
  erb :search_contact
end

post "/contacts/search" do
  @contacts = Contact.all(:first_name => params[:first_name], :last_name => params[:last_name])
  erb :contact
end



get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
	@contact = Contact.get(params[:id].to_i)
  erb :edit_contact
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
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

get "/contacts/:id/delete" do
  @contact = Contact.get(params[:id].to_i)
    @contact.destroy
    redirect to("/contacts")
end
 
