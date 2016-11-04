defmodule Zheye.WebChatUser do
  use Zheye.Web, :model

  alias Zheye.Repo

  schema "web_chat_users" do
    field :origin_domain, :string
    field :origin_id, :string
    field :name, :string
    field :name_pinyin, :string
    field :avatar, :string
    field :bio, :string
    field :online_at, Timex.Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:origin_domain, :origin_id, :name], [:name_pinyin, :avatar, :bio])
    |> validate_required([:origin_domain, :origin_id, :name])
    |> put_pinyin(:name, :name_pinyin)
    |> put_now(:online_at)
  end

  def get(params) do
    case Repo.get_by(__MODULE__, origin_domain: Map.get(params, "origin_domain"), origin_id: Map.get(params, "origin_id")) do
      nil -> %__MODULE__{}
      user -> user
    end
    |> __MODULE__.changeset(params)
    |> Repo.insert_or_update
  end

  defp put_pinyin(%Ecto.Changeset{valid?: true} = changeset, from, to) do
    pinyin = changeset |> get_field(from) |> Pinyin.permlink
    changeset |> put_change(to, pinyin)
  end

  defp put_pinyin(%Ecto.Changeset{valid?: false} = changeset, _, _) do
    changeset
  end

  defp put_now(%Ecto.Changeset{valid?: true} = changeset, field) do
    changeset |> put_change(field, Timex.now)
  end

  defp put_now(%Ecto.Changeset{valid?: false} = changeset, _) do
    changeset
  end
end
