defmodule Zheye.WebChatDialogNotificationView do
  use Zheye.Web, :view

  alias Zheye.{Repo, WebChatUser}

  def render("entries.json", %{entries: entries}) do
    %{data: render_many(entries, __MODULE__, "entry.json", as: :entry)}
  end

  def render("entry.json", %{entry: entry}) do
    user = WebChatUser |> Repo.get_by(origin_domain: entry.domain, origin_id: entry.from_user_id)

    %{
      user: render(Zheye.WebChatUserView, "entry.json", entry: user)
    }
  end
end
