defmodule Zheye.Repo.Migrations.CreateWebChatFirend do
  use Ecto.Migration

  def change do
    create table(:web_chat_firends, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :domain, :string
      add :left_user_id, :string
      add :right_user_id, :string

      timestamps()
    end

    create index(:web_chat_firends, [:domain])
    create index(:web_chat_firends, [:left_user_id])
    create index(:web_chat_firends, [:right_user_id])
    create unique_index(:web_chat_firends, [:domain, :left_user_id, :right_user_id], name: :web_chat_firends_unique)
  end
end
