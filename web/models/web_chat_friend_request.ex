defmodule Zheye.WebChatFriendRequest do
  use Zheye.Web, :model

  alias Zheye.{Repo}

  schema "web_chat_friend_requests" do
    field :domain, :string
    field :from_user_id, :string
    field :to_user_id, :string
    field :is_confirmed, :boolean, default: false

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

  def create(params) do
    case Repo.get_by(__MODULE__, params) do
      nil -> %__MODULE__{}
      struct -> struct
    end
    |> changeset(params)
    |> Repo.insert_or_update
  end
end
