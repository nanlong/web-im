defmodule Zheye.WebChatDialogView do
  use Zheye.Web, :view

  alias Zheye.{Repo, WebChatUser}

  def render("entries.json", %{entries: entries}) do
    %{data: render_many(entries, __MODULE__, "entry.json", as: :entry)}
  end

  def render("entry.json", %{entry: entry}) do
    user = WebChatUser |> Repo.get_by(origin_domain: entry.domain, origin_id: entry.from_id)

    %{
      id: entry.id,
      from_id: entry.from_id,
      to_id: entry.to_id,
      content: entry.content,
      inserted_at: entry.inserted_at,
      user: render(Zheye.WebChatUserView, "entry.json", entry: user)
    }
  end
end
