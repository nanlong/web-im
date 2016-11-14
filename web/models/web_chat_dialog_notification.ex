defmodule Zheye.WebChatDialogNotification do
  use Zheye.Web, :model

  schema "web_chat_dialog_notifications" do
    field :domain, :string
    field :from_user_id, :string
    field :to_user_id, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:domain, :from_user_id, :to_user_id])
    |> validate_required([:domain, :from_user_id, :to_user_id])
  end
end
