defmodule Support.User do
  use Support.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(name email password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, :register, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:name, min: 1, message: "can't be blank.")
    |> validate_length(:email, min: 1, message: "can't be blank.")
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password, message: "must match")
  end

  def encrypted_password(changeset) do
    if password = get_change(changeset, :password) do
      put_change(changeset, :encrypted_password, hash_password(password))
    else
      changeset
    end
  end

  def hash_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def check_password(password, crypted) do
    Comeonin.Bcrypt.checkpw(password, crypted)
  end
end
