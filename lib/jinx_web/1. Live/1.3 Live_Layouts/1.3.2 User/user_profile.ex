defmodule JinxWeb.UserProfileComponent do
  use JinxWeb, :live_component    

  def render(assigns) do  
    ~H"""
      <div class="profile-container">   
        <div class="profile-top">
          <div class="profile-banner">
            <%= if @user.banner === [] do %>
              <div class="no-banner"/>
            <% else %>
              <img src={@user.banner}/>
            <% end %>
          </div>

          <div class="profile-avatar">
            <%= if @user.avatar === [] do %>
              <div class="no-avatar"/>
            <% else %>
              <img src={@user.avatar}/>
            <% end %>
          </div>
        </div>

        <div class="profile-main">
          <div class="profile-follow-container">
            <div class="profile-follow-btn-container">
              <.button type="button" class="profile-follow-btn" phx-click="follow user" phx-value-id={@user.id}>Follow</.button>
              <.button type="button" class="profile-options-btn" phx-click={JS.show(show_options)}>
                <svg viewBox="0 0 300 300" fill="none" stroke-width="40" stroke="currentColor"> 
                  <path d="M0,80L150,220L300,80" />
                </svg>
              </.button>
            </div>

            <div class="profile-options none">
              <.link class="profile-option" phx-click="follow user" phx-value-id={@user.id}>
                <%= "Follow" %>
              </.link>

              <.link class="profile-option" phx-click="friend request" phx-value-id={@user.id}>
                <%= "Friend Request" %>
              </.link>

              <.link class="profile-option" phx-click="placeholder" phx-value-id={@user.id}>
                <%= "PM" %>
              </.link>

              <.link class="profile-option" phx-click="block user" phx-value-id={@user.id}>
                <%= "Block User" %>
              </.link>

              <.link class="profile-option" phx-click="report user" phx-value-id={@user.id}>
                <%= "Report User" %>
              </.link>
            </div>
          </div>

          <div class="profile-names">
            <div class="profile-display-name">
              <%= @user.display_name %>
            </div>

            <div class="profile-username">
              <%= "@#{@user.username}" %>
            </div>
          </div>

          <div class="profile-about-container">
            <div class="profile-about">
              <%= @user.about %>
            </div>
          </div>

          <div class="profile-count-container">
            <div class="profile-count">
              <div class="profile-count-value">
                <%= @user.vote_count %>
              </div>

              <div class="profile-count-label">
                <%= "Votes" %>
              </div>
            </div>

            <div class="profile-count">
              <div class="profile-count-value">
                <%= @user.post_count %>
              </div>

              <div class="profile-count-label">
                <%= "Posts" %>
              </div>
            </div>

            <div class="profile-count">
              <div class="profile-count-value">
                <%= @user.vote_count %>
              </div>

              <div class="profile-count-label">
                <%= "Comments" %>
              </div>
            </div>
          </div>

          <div class="profile-count-container">
            <div class="profile-count">
              <div class="profile-count-value">
                <%= @user.follower_count %>
              </div>

              <div class="profile-count-label">
                <%= "Followers" %>
              </div>
            </div>

            <div class="profile-count">
              <div class="profile-count-value">
                <%= @user.following_count %>
              </div>

              <div class="profile-count-label">
                <%= "Following" %>
              </div>
            </div>

            <div class="profile-count">
              <div class="profile-count-value">
                <%= @user.friend_count %>
              </div>

              <div class="profile-count-label">
                <%= "Friends" %>
              </div>
            </div>
          </div>         

          <div class="profile-created">
            <%= "Created #{@user.inserted_at}" %>
          </div>
        </div> 
      </div>                     
    """
  end

  def show_options(js \\ %JS{}) do
    js
    |> JS.show(to: ".profile-options", display: "flex")
    |> JS.hide(to: ".profile-options")
  end
end