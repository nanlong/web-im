defmodule Zheye.WebChatUserView do
  use Zheye.Web, :view

  alias Zheye.{WebChatFriend}

  def render("entries.json", %{entries: entries}) do
    %{data: render_many(entries, __MODULE__, "entry.json", as: :entry)}
  end

  def render("entry.json", %{entry: entry, current_user: current_user}) do
    %{
      id: entry.origin_id,
      domain: entry.origin_domain,
      name: entry.name,
      name_pinyin: entry.name_pinyin,
      avatar: entry.avatar,
      bio: entry.bio,
      is_friend: WebChatFriend.is_friend?(current_user.origin_domain, current_user, entry)
    }
  end

  def render("entry.json", %{entry: entry}) do
    %{
      id: entry.origin_id,
      domain: entry.origin_domain,
      name: entry.name,
      name_pinyin: entry.name_pinyin,
      avatar: entry.avatar,
      bio: entry.bio,
    }
  end


end
