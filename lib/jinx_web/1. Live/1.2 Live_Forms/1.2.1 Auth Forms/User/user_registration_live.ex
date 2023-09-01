defmodule JinxWeb.UserRegistrationLive do
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
            <label><%= "Register" %></label>
          </div>
          
            <.simple_form
              for={@form}
              id="auth-form"
              phx-submit="save"
              phx-change="validate"
              phx-trigger-action={@trigger_submit}
              action={~p"/users/log_in?_action=registered"}
              method="post">

            <div class="auth-main">
              <div class="auth-input-container">
                <.input class="v-input" field={@form[:username]} type="text" placeholder="Username" required />
              </div>

              <div class="auth-input-container">
                <.input class="v-input" field={@form[:email]} type="email" placeholder="Email" required />
              </div>
                    
              <div class="auth-input-container">
                <.input class="v-input" field={@form[:password]} type="password" placeholder="Password" required />
              </div>

              <div class="auth-submit">   
                <.button class="auth-btn" phx-disable-with="Creating account...">Create account</.button>
              </div>

              <div class="auth-bottom">
                <.link class="auth-link" href={~p"/users/log_in"}>
                  <%= "Log In" %>
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
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(:current_user, %User{id: 0, primary_theme: "Dark", secondary_theme: "Jinx"})
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        Accounts.create_user_settings(user)
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
