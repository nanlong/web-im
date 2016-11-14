defmodule Zheye.Repo.Migrations.CreateWebChatDialogNotification do
  use Ecto.Migration

  def change do
    create table(:web_chat_dialog_notifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :domain, :string, null: false
      add :from_user_id, :string, null: false
      add :to_user_id, :string, null: false

      timestamps()
    end

    create index(:web_chat_dialog_notifications, [:domain])
    create index(:web_chat_dialog_notifications, [:from_user_id])
    create index(:web_chat_dialog_notifications, [:to_user_id])

  end
end
