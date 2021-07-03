class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.new
    @pet.name = params[:pet_name]
    @pet.owner_id = params[:owner_id]
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
    else
      @owner = Owner.find_by_name(params[:owner][:name])
    end
    @pet.update(name: params[:pet_name], owner_id: @owner.id)
    redirect to "pets/#{@pet.id}"
  end
end