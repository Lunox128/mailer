defmodule JinxWeb.HomeLive.Index do
  use JinxWeb, :live_view
  
  alias Jinx.{Accounts}
  alias Jinx.Accounts.User


  @default_user %User{id: 0, username: "Anonymous"}

  def mount(_params, session, socket) do
    current_user = get_current_user(session)
    user = Map.get(socket, :user, @default_user)

    socket = socket
      |> assign(:user, user)
      |> assign(:current_user, current_user)
    {:ok, socket}
  end

  def get_current_user(session) do
    case session do
      %{"user_token" => user_token} ->
        Accounts.get_user_by_session_token(user_token)
      %{} ->
        %User{id: 0, username: "Anonymous"}
    end
  end

  def handle_params(params, _, socket) do
    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)     
    }
  end
  
  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Index")
  end

  def handle_event("killswitch", _, socket) do
      Accounts.delete_all_users   
    {:noreply, socket}
  end
end