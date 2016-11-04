defmodule Zheye.Repo.Migrations.CreateWebChatDialog do
  use Ecto.Migration

  def change do
    create table(:web_chat_dialogs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :domain, :string
      add :from_id, :string
      add :to_id, :string
      add :content, :text

      timestamps()
    end

    create index(:web_chat_dialogs, [:domain])
    create index(:web_chat_dialogs, [:from_id])
    create index(:web_chat_dialogs, [:to_id])

  end
end
