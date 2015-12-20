defmodule SuperRentalsBackend.RentalView do
  use SuperRentalsBackend.Web, :view

  attributes [:title, :owner, :city, :type, :bedrooms, :image]

  def render("index.json", %{rentals: rentals}) do
    %{data: render_many(rentals, SuperRentalsBackend.RentalView, "rental.json")}
  end

  def render("show.json", %{rental: rental}) do
    %{data: render_one(rental, SuperRentalsBackend.RentalView, "rental.json")}
  end

  def render("rental.json", %{rental: rental}) do
    %{id: rental.id,
      title: rental.title,
      owner: rental.owner,
      city: rental.city,
      type: rental.type,
      bedrooms: rental.bedrooms,
      image: rental.image}
  end
end
