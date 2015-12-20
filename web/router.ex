defmodule SuperRentalsBackend.Router do
  use SuperRentalsBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", SuperRentalsBackend do
    pipe_through :api # Use the default api stack

    resources "/rentals", RentalController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SuperRentalsBackend do
  #   pipe_through :api
  # end
end
