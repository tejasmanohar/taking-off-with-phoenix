defmodule Support.RegistrationController do
  use Support.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
end
