defmodule JinxWeb.UserLoginLive do
  use JinxWeb, :live_view

  def render(assigns) do
    ~H"""
    <main class="layout-page-container">
      <div class="layout-top-nav-container">
        <.live_component
          module={JinxWeb.TopNavComponent}
          id={"top-nav-component"}
          action={@live_action}
          current_user={@current_user}
        />
      </div>
        
      <div class="layout-auth-container">
        <div class="auth-container">
          <div class="auth-top">
            <label><%= "Log In" %></label>
          </div>
            
          <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
            <div class="auth-main">
              <div class="auth-input-container">
                <.input class="v-input" field={@form[:email]} type="email" placeholder="Email" required />
              </div>

              <div class="auth-input-container">  
                <.input class="v-input" field={@form[:password]} type="password" placeholder="Password" required />
              </div>

              <div class="auth-submit">               
                <.button class="auth-btn" phx-disable-with="Signing in...">
                  <%= "Log in" %>
                </.button>
              </div>

              <div class="auth-bottom">
                <.link class="auth-link" href={~p"/users/register"}>
                  <%= "Register" %>
                </.link>
                
                <div><%= "|" %></div>

                <.link class="auth-link" href={~p"/users/reset_password"}>
                  <%= "Forgot your password?" %>
                </.link>
              </div>
            </div>
          </.simple_form>
        </div>
      </div>
    </main>
    """
  end

  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
