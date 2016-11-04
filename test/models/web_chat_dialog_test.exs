defmodule Zheye.WebChatDialogTest do
  use Zheye.ModelCase

  alias Zheye.WebChatDialog

  @valid_attrs %{content: "some content", domain: "some content", from_id: "some content", to_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WebChatDialog.changeset(%WebChatDialog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WebChatDialog.changeset(%WebChatDialog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
