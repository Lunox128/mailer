defmodule Jinx.Messenger_Settings.Messenger_Setting do
  use Ecto.Schema
  import Ecto.Changeset

  alias Jinx.Accounts.User

  schema "messenger_settings" do
    field :messenger_availability, :string, default: "Available"
    field :messenger_privacy, :string, default: "Everyone"
    field :messenger_requests, :boolean, default: true
    field :messenger_style, :integer

    field :font_size, :integer, default: 1
    field :timestamps, :boolean

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(messenger__setting, attrs) do
    messenger__setting
    |> cast(attrs, [:messenger_availability, :messenger_privacy, :font_size, :timestamps, :messenger_requests, :messenger_style])
    |> validate_required([])
  end
end
