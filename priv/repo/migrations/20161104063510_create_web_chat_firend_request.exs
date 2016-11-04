defmodule Zheye.Repo.Migrations.CreateWebChatFirendRequest do
  use Ecto.Migration

  def change do
    create table(:web_chat_firend_requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :domain, :string, null: false
      add :from_user_id, :string, null: false
      add :to_user_id, :string, null: false
      add :is_confirmed, :boolean, default: false, null: false

      timestamps()
    end

    create index(:web_chat_firend_requests, [:domain])
    create index(:web_chat_firend_requests, [:from_user_id])
    create index(:web_chat_firend_requests, [:to_user_id])
    create unique_index(:web_chat_firend_requests, [:domain, :from_user_id, :to_user_id], name: :web_chat_firend_requests_unique)

  end
end
