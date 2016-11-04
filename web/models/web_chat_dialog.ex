defmodule Zheye.WebChatDialog do
  use Zheye.Web, :model

  schema "web_chat_dialogs" do
    field :domain, :string
    field :from_id, :string
    field :to_id, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:domain, :from_id, :to_id, :content])
    |> validate_required([:domain, :from_id, :to_id, :content])
  end
end
