defmodule JinxWeb.UserMenuComponent do
  use JinxWeb, :live_component    
        
  alias Phoenix.LiveView.JS
    
  def render(assigns) do  
    ~H"""
      <div class="um-outer-container">
          <div class="um-inner-container">
            <section class="um-top">
              <div class="um-banner">
                <%= if @current_user.banner === [] do %>
                  <div class="no-banner">
                    <.link class="um-avatar"navigate={~p"/settings/profile"}>
                      <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                      </svg>
                    </.link>
                  </div>
                <% else %>
                  <img src={@current_user.banner}/>
                <% end %>

                <.link class="um-avatar"navigate={~p"/settings/profile"}>
                  <%= if @current_user.avatar === [] do %>
                    <div class="no-avatar">
                      <div class="initial">
                        <%= String.first(@current_user.username) %>
                      </div>
                    </div>
                  <% else %>
                    <img src={@current_user.avatar}/>
                  <% end %>
                </.link>
              </div>
              <div class="um-username-container">
                <div class="um-username">
                  <%= @current_user.username %>
                </div>
              </div>
            </section>

            <section class="um-main">
              <div class="um-section">
                <.link class="um-link" navigate={~p"/"} >
                  <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                  </svg>
                  <label>Home</label>
                </.link>

                <.link class="um-link" navigate={~p"/user/#{@current_user.username}"} >
                  <svg class="timeline-svg" viewBox="0 0 512 512" shape-rendering="geometricPrecision" text-rendering="geometricPrecision">
                    <path d="M40,40v160h160l50-80-50-80h-160Z" /><path d="M40,40v160h160l50-80-50-80h-160Z" transform="translate(0 270)" /><path d="M40,40v160h160l50-80-50-80h-160Z" transform="matrix(-1 0 0 1 506 136)" />
                  </svg>

                <label>My Timeline</label>
                </.link>

                <.link class="um-link" navigate={~p"/user/#{@current_user.username}/submit"} >
                  <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m3.75 9v6m3-3H9m1.5-12H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                  </svg>
                <label>New Post</label>
                </.link>                        
              </div>
              <div class="um-section">
                <.link class="um-link" navigate={~p"/settings/account"}>
                  <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                  <label>Account Settings</label>
                </.link>
                <.link class="um-link" navigate={~p"/settings/profile"}>
                  <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9.53 16.122a3 3 0 00-5.78 1.128 2.25 2.25 0 01-2.4 2.245 4.5 4.5 0 008.4-2.245c0-.399-.078-.78-.22-1.128zm0 0a15.998 15.998 0 003.388-1.62m-5.043-.025a15.994 15.994 0 011.622-3.395m3.42 3.42a15.995 15.995 0 004.764-4.648l3.876-5.814a1.151 1.151 0 00-1.597-1.597L14.146 6.32a15.996 15.996 0 00-4.649 4.763m3.42 3.42a6.776 6.776 0 00-3.42-3.42" />
                  </svg>
                  <label>Profile Settings</label>
                </.link>
              </div>

              <div class="um-section" id ="um-section-bottom">
                <.link class="um-link" href={~p"/users/log_out"} method="delete">
                  <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5.636 5.636a9 9 0 1012.728 0M12 3v9" />
                  </svg>
                  <label>Log Out</label>
                </.link> 
              </div>  
            </section>

            
          </div>
      </div>
    """
  end
end