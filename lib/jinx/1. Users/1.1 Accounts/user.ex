defmodule Jinx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Jinx.Posts.Post
  alias Jinx.Notifications.Notification
  alias Jinx.User_Notifications.User_Notification
  alias Jinx.Notification_Settings.Notification_Setting
  alias Jinx.Messenger_Settings.Messenger_Setting

  schema "users" do

    # Account Settings
    field :username, :string
    field :display_name, :string
    field :role, :string, default: "User"
    field :account_status, :string, default: "Active"
    field :exp, :integer, default: 0
    field :rank, :integer, default: 0
    field :target_room, :integer, default: 1
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true

    # Account Metrics
    field :view_count, :integer, default: 0
    field :message_count, :integer, default: 0
    field :notification_count, :integer, default: 0
    field :vote_count, :integer, default: 0
    field :post_count, :integer, default: 0
    field :friend_count, :integer, default: 0
    field :follower_count, :integer, default: 0
    field :following_count, :integer, default: 0
    field :repost_count, :integer, default: 0
    field :engagement_count, :integer, default: 0
    field :engagement_average, :integer, default: 0

    # Profile Settings
    field :about, :string, default: "Nothing to see here yet ¯\_(ツ)_/¯"
    field :avatar, {:array, :string}, default: []
    field :banner, {:array, :string}, default: []
    field :wallpaper, {:array, :string}, default: []
    field :primary_theme, :string, default: "Dark"
    field :secondary_theme, :string, default: "Jinx"
    field :sort, :string, default: "Popular"
    field :disable_banners, :boolean, default: false
    field :nsfw, :boolean, default: false

    field :confirmed_at, :naive_datetime

    has_many :posts, Post
    has_many :notifications, Notification
    has_many :user_notifications, User_Notification

    has_one :notification_setting, Notification_Setting
    has_one :messenger_setting, Messenger_Setting

    timestamps()
  end

  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password, :username])
    |> validate_email(opts)
    |> validate_password(opts)
  end

  defp validate_email(changeset, opts) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> maybe_validate_unique_email(opts)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 1, max: 72)
    # Examples of additional password validation:
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # Hashing could be done with `Ecto.Changeset.prepare_changes/2`, but that
      # would keep the database transaction open longer and hurt performance.
      |> put_change(:hashed_password, Pbkdf2.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  defp maybe_validate_unique_email(changeset, opts) do
    if Keyword.get(opts, :validate_email, true) do
      changeset
      |> unsafe_validate_unique(:email, Jinx.Repo)
      |> unique_constraint(:email)
    else
      changeset
    end
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email])
    |> validate_email(opts)
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A user changeset for changing the password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password(opts)
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Pbkdf2.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%Jinx.Accounts.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Pbkdf2.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Pbkdf2.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end
end
