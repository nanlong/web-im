defmodule Zheye.WebChatFriendRequestView do
  use Zheye.Web, :view

  alias Zheye.{Repo, WebChatUser}

  def render("entries.json", %{entries: entries}) do
    %{data: render_many(entries, __MODULE__, "entry.json", as: :entry)}
  end

  def render("entry.json", %{entry: entry}) do
    from_user = WebChatUser |> Repo.get_by(origin_domain: entry.domain, origin_id: entry.from_user_id)

    %{
      id: entry.id,
      from_id: entry.from_user_id,
      to_id: entry.to_user_id,
      is_confirmed: entry.is_confirmed,
      inserted_at: entry.inserted_at,
      user: %{
        id: "notification:friend",
        domain: entry.domain,
        name: "好友请求",
        name_pinyin: "hao-you-qing-qiu",
        avatar: "https://www.phoenix-china.org/favicon.ico",
        bio: "好友请求",
      },
      from_user: render(Zheye.WebChatUserView, "entry.json", entry: from_user)
    }
  end
end
