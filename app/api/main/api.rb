require 'grape'

module Main
  class API < Grape::API
    version 'v1', using: :header, vendor: 'some_vendor'
    format :json

    resource :upload do
      post do
        # takes the :avatar value and assigns it to a variable
        avatar = params[:avatar]
        
        # the avatar parameter needs to be converted to a
        # hash that paperclip understands as:
        attachment = {
          :filename => avatar[:filename],
          :type => avatar[:type],
          :headers => avatar[:head],
          :tempfile => avatar[:tempfile]
        }

        # creates a new User object
        photo = Photo.new

        # This is the kind of File object Grape understands so let's
        # pass the hash to it
        #photo.avatar = ActionDispatch::Http::UploadedFile.new(attachment)

        # easy
        #photo.avatar_path = attachment[:filename]

        # even easier
        #photo.name = "dummy name"


        raw_parameters = {
          :avatar => ActionDispatch::Http::UploadedFile.new(attachment),
          :name => "picture",
          :avatar_path => attachment[:filename]
        }

        parameters = ActionController::Parameters.new(raw_parameters)
        photo = Photo.create(parameters.permit(:avatar, :name, :avatar_path))

      end
    end

  end
end
