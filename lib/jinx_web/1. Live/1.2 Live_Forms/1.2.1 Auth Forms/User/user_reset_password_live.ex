defmodule JinxWeb.UserResetPasswordLive do
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
              <label><%= "Sign Up" %></label>
            </div>

              <.simple_form
                for={@form}
                id="reset_password_form"
                phx-submit="reset_password"
                phx-change="validate">

                <.error :if={@form.errors != []}>
                  Oops, something went wrong! Please check the errors below.
                </.error>
                  
                <div class="auth-input-container">
                  <.input class="v-input" field={@form[:password]} type="password" label="New password" required />
                </div>

                <div class="auth-input-container">
                  <.input class="v-input" field={@form[:password_confirmation]} type="password" label="Confirm new password" required/>
                </div>
                  
                <div class="layout-auth-links">
                  <.button class="layout-auth-btn" phx-disable-with="Resetting..." class="w-full">Reset Password</.button>
                </div>
              </.simple_form>
            </div>
          </div>
    
      </main>
    """
  end

  def mount(params, _session, socket) do
    socket = assign_user_and_token(socket, params)

    form_source =
      case socket.assigns do
        %{user: user} ->
          Accounts.change_user_password(user)

        _ ->
          %{}
      end

    socket = socket 
      |> assign(:current_user, %User{primary_theme: "Dark", secondary_theme: "Jinx"})

    {:ok, assign_form(socket, form_source), temporary_assigns: [form: nil]}
  end

  # Do not log in the user after reset password to avoid a
  # leaked token giving the user access to the account.
  def handle_event("reset_password", %{"user" => user_params}, socket) do
    case Accounts.reset_user_password(socket.assigns.user, user_params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Password reset successfully.")
         |> redirect(to: ~p"/users/log_in")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, Map.put(changeset, :action, :insert))}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_password(socket.assigns.user, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_user_and_token(socket, %{"token" => token}) do
    if user = Accounts.get_user_by_reset_password_token(token) do
      assign(socket, user: user, token: token)
    else
      socket
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> redirect(to: ~p"/")
    end
  end

  defp assign_form(socket, %{} = source) do
    assign(socket, :form, to_form(source, as: "user"))
  end
end
