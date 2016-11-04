defmodule Zheye.WebChatFirendTest do
  use Zheye.ModelCase

  alias Zheye.WebChatFirend

  @valid_attrs %{domain: "some content", left_user_id: "some content", right_user_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WebChatFirend.changeset(%WebChatFirend{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WebChatFirend.changeset(%WebChatFirend{}, @invalid_attrs)
    refute changeset.valid?
  end
end
