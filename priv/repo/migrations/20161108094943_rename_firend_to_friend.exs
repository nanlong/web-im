defmodule Zheye.Repo.Migrations.RenameFirendToFriend do
  use Ecto.Migration

  def change do
    rename table(:web_chat_firend_requests), to: table(:web_chat_friend_requests)
    rename table(:web_chat_firends), to: table(:web_chat_friends)
  end
end
