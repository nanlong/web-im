defmodule Zheye.WebChatFriend do
  use Zheye.Web, :model

  alias Zheye.{Repo}

  schema "web_chat_friends" do
    field :domain, :string
    field :left_user_id, :string
    field :right_user_id, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:domain, :left_user_id, :right_user_id])
    |> validate_required([:domain, :left_user_id, :right_user_id])
  end

  def is_friend?(domain, user_one, user_two) do
    [left_user_id, right_user_id] = [user_one.origin_id, user_two.origin_id] |> Enum.sort
    case Repo.get_by(__MODULE__, domain: domain, left_user_id: left_user_id, right_user_id: right_user_id) do
      nil -> false
      _ -> true
    end
  end
end
