defmodule JinxWeb.TopNavComponent do
  use JinxWeb, :live_component    
      
  alias Phoenix.LiveView.JS
  
    def render(assigns) do  
      ~H"""
        <div class="top-nav-container" >          
          <div class="top-nav-left" />

          <div class="top-nav-center" />

          <div class="top-nav-right">
            
            <%= if @current_user === nil || @current_user.id === 0 do %>
              <div class="top-nav-auth-container">  
                <.link class="top-nav-auth-btn" id="top-nav-register" href={~p"/users/register"}>Register</.link>
                <.link class="top-nav-auth-btn" href={~p"/users/log_in"}>Log in</.link>
              </div>
            <% else %>  
              <.button class="top-nav-right-menu-button" type="button" phx-click="killswitch">
                Reset
              </.button>
            
              <div class="top-nav-right-menu">
                <div class="top-nav-right-menu-options">
                

                  <.button class="top-nav-right-menu-button" type="button" phx-click={JS.show(show_messenger)}>
                    <svg viewBox="0 0 300 300" fill="none" stroke-width="13" stroke="currentColor"> 
                      <path d="M40,90c0-40,20-40,60-40h100c30,0,50,0,50,40v25c-4-3-13-5-20-5c0,.123628-80-.123628-80,0-19.1875,0-30,10-30,30v40c0,9,1,13,5,20c0,0-5,0-5,0-6,0-20,10-60,50c20-40,40-50,20-50s-40,0-40-40v-70Z" />
                      <path d="M130,150c0-20,10-30,30-30h80c20,0,30,10,30,30v40c0,20-10,30.28025-30,30.28025s-10,4,0,30c-30-30-34-30-50-30h-30C140,220.28025,130,210,130,190v-40Z" transform="translate(-10-10.28025)" />
                    </svg>
                  </.button>

                  <.button class="top-nav-right-menu-button" type="button" phx-click={JS.show(show_notifications)}>
                    <svg viewBox="0 0 300 300" fill="none" stroke-width="13" stroke="currentColor"> 
                      <path d="M129.645478,50c9.645478-20,30-20,40,0c79.645478,10,20,110,70,130l20,30c-30,10-60,10-80,10c0,50-60,50-60,0-20,0-50,0-80-10l20-30c50-20-10.354522-120,70-130Z" transform="translate(.354522 3.749878)" />
                    </svg>  
                  </.button>

                  <.link class="top-nav-right-menu-button" type="button" navigate={~p"/user/#{@current_user.username}/submit"}>
                    <svg viewBox="0 0 300 300" fill="none" stroke-width="13" stroke="currentColor"> 
                      <path d="M40,150C40,90,90,40,150,40v0c60,0,110,50,110,110v0c0,60-50,110-110,110v0C90,260,40,210,40,150v0Z" />
                      <path d="M150,100v100" />
                      <path d="M100,150h100" />
                    </svg>
                  </.link>
                </div>

                <.button class="top-nav-avatar" type="button" phx-click={JS.show(toggle_user_menu)}>
                  <%= if @current_user.avatar === [] do %>
                    <div class="no-wallpaper" />
                  <% else %>
                    <img src={@current_user.avatar}/>
                  <% end %>
                </.button>
              </div>
            
            <% end %>
          </div>
        </div>                     
      """
    end

    def toggle_user_menu(js \\ %JS{}) do
      js
      |> JS.show(to: ".layout-user-menu", display: "flex")
      |> JS.hide(to: ".layout-user-menu")
    end 

    def toggle_notifications(js \\ %JS{}) do
      js
      |> JS.show(to: ".n-outer-container", display: "flex")
      |> JS.hide(to: ".n-outer-container")
    end 

    def show_leftnav(js \\ %JS{}) do
      js
      |> JS.show(to: "#tn-hide-leftnav", display: "flex")
      |> JS.hide(to: "#tn-show-leftnav")
      |> JS.remove_class("ln-closed", to: ".b-container-left-nav")
      |> JS.remove_class("ln-closed", to: ".ln-container")
      |> JS.remove_class("v-margin-0", to: ".v-container")  
    end 

    def hide_leftnav(js \\ %JS{}) do
      js
      |> JS.show(to: "#tn-show-leftnav", display: "flex")
      |> JS.hide(to: "#tn-hide-leftnav")
      |> JS.add_class("ln-closed", to: ".b-container-left-nav")
      |> JS.add_class("ln-closed", to: ".ln-container")
      |> JS.add_class("v-margin-0", to: ".v-container")
    end

    def show_notifications(js \\ %JS{}) do
      js
      |> JS.show(to: "#layout-right-notifications", display: "flex")
      |> JS.show(to: "#notifications-close-btn", display: "flex")
      |> JS.hide(to: "#messenger-collapse-menu-btn-2") 
      |> JS.hide(to: "#messenger-collapse-messenger-btn")
      |> JS.remove_class("layout-margin-right-auto", to: ".layout-timeline-container")
      |> JS.hide(to: "#layout-right-notifications")
      |> JS.hide(to: "#layout-right-messenger")
      |> JS.add_class("layout-margin-right-auto", to: ".layout-timeline-container")
    end 

    def show_messenger(js \\ %JS{}) do
      js
      |> JS.show(to: "#layout-right-messenger", display: "flex")
      |> JS.show(to: "#messenger-close-btn", display: "flex")
      |> JS.hide(to: "#messenger-collapse-menu-btn-2") 
      |> JS.hide(to: "#messenger-collapse-messenger-btn")
      |> JS.remove_class("layout-margin-right-auto", to: ".layout-timeline-container")
      |> JS.hide(to: "#layout-right-messenger")
      |> JS.hide(to: "#layout-right-notifications")
      |> JS.add_class("layout-margin-right-auto", to: ".layout-timeline-container")
    end 
end
  


