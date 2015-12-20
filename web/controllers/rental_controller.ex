defmodule SuperRentalsBackend.RentalController do
  use SuperRentalsBackend.Web, :controller

  alias SuperRentalsBackend.Rental

  plug :scrub_params, "rental" when action in [:create, :update]

  def index(conn, _params) do
    rentals = Repo.all(Rental)
    render(conn, "index.json", rentals: rentals)
  end

  def create(conn, %{"rental" => rental_params}) do
    changeset = Rental.changeset(%Rental{}, rental_params)

    case Repo.insert(changeset) do
      {:ok, rental} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", rental_path(conn, :show, rental))
        |> render("show.json", rental: rental)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SuperRentalsBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rental = Repo.get!(Rental, id)
    render(conn, "show.json", rental: rental)
  end

  def update(conn, %{"id" => id, "rental" => rental_params}) do
    rental = Repo.get!(Rental, id)
    changeset = Rental.changeset(rental, rental_params)

    case Repo.update(changeset) do
      {:ok, rental} ->
        render(conn, "show.json", rental: rental)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SuperRentalsBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rental = Repo.get!(Rental, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(rental)

    send_resp(conn, :no_content, "")
  end
end
