# defmodule KausiApiWeb.Auth.Uploader do
#     use Arc.Definition

    
#   # The storage configuration specifies how uploaded files are stored.
#   # In this example, we use the :local storage backend, which stores files
#   # on the local filesystem.
#   @storage_config Application.get_env(:KausiApi, :storage) || %{storage: :local, path: "images"}

#   # The uploader configuration specifies how uploaded files are processed.
#   # In this example, we use the Arc.Store.Stream uploader, which streams the
#   # file to storage as it is being uploaded.
#   KausiApiWeb.Auth.Uploader.Arc.Store.Stream

#   # Define the field in the schema that will store the uploaded file.
#   # In this example, we define a field named "file".
#   # This field is defined as an :upload type, which is provided by the Arc library.
#   image :image, uploader: KausiApiWeb.Auth.Uploader

#   # Configure the uploader with the storage backend and options.
#   @impl true
#   def config do
#     @storage_config
#   end
# end