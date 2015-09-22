defmodule Support.RegistrationController do
  use Support.Web, :controller

  alias Support.User

  def new(conn, _params) do
    changeset = User.changeset(%User{}, :register)
    render conn, "new.html", changeset: changeset
  end
end
