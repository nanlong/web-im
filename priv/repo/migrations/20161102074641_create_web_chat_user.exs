defmodule Zheye.Repo.Migrations.CreateWebChatUser do
  use Ecto.Migration

  def change do
    create table(:web_chat_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :origin_domain, :string
      add :origin_id, :string
      add :name, :string
      add :name_pinyin, :string
      add :avatar, :string
      add :bio, :text
      add :online_at, :timestamp
      timestamps()
    end

    create index(:web_chat_users, [:name])
    create index(:web_chat_users, [:name_pinyin])
    create unique_index(:web_chat_users, [:origin_domain, :origin_id], name: :web_chat_users_origin_unique)

  end
end
