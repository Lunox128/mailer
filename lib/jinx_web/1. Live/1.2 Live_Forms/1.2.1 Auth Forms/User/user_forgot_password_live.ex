defmodule JinxWeb.UserForgotPasswordLive do
  use JinxWeb, :live_view

  alias Jinx.Accounts
  alias Jinx.Accounts.User

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
              <label><%= "Forgotten Password?" %></label>
            </div>
              
            <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
              <div class="auth-main">
                <div class="auth-input-container">  
                  <.input class="v-input" field={@form[:email]} type="email" placeholder="Email" required />
                </div>
                  
                <div class="auth-submit">
                  <.button class="auth-btn" phx-disable-with="Sending..." >
                    <%= "Send" %>
                  </.button>
                </div>

                <div class="auth-bottom">
                  <.link class="auth-link" href={~p"/users/register"}>
                    <%= "Register" %>
                  </.link>
                
                  <div><%= "|" %></div>
              
                  <.link class="auth-link" href={~p"/users/log_in"}>
                    <%= "Log In" %>
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
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions to reset your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
