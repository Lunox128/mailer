defmodule Jinx.Notification_Settings.Notification_Setting do
  use Ecto.Schema
  import Ecto.Changeset

  alias Jinx.Accounts.User

  schema "notification_settings" do

    #General
    field :notifications, :boolean, default: true

    #User
    field :mentions, :boolean, default: true  # User gets mentioned in a post or comment
    field :new_follower, :boolean, default: true  # User gets a new follower
    field :friend_requests, :boolean, default: true  # User gets a new follower

    #Post
    field :new_post, :boolean, default: true # Friends/Follow creates new post
    field :post_upvotes, :boolean, default: true # Post the user makes gets an upvote
    field :comment_upvotes, :boolean, default: true  # Comment the user makes gets an upvote
    field :post_comments, :boolean, default: true  # Post the user makes gets a comment
    field :comment_replies, :boolean, default: true  # Comment the user makes gets a reply

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(notification__setting, attrs) do
    notification__setting
      |> cast(attrs, 
        [
          :user_id,

          :notifications,

          :new_post,
          :mentions,
          :new_follower,
          :friend_requests,

          :post_upvotes,
          :comment_upvotes,
          :post_comments,
          :comment_replies
        ]
      )
  end
end