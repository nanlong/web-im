defmodule Zheye.WebChatDialogNotificationTest do
  use Zheye.ModelCase

  alias Zheye.WebChatDialogNotification

  @valid_attrs %{from_user_id: "some content", to_user_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WebChatDialogNotification.changeset(%WebChatDialogNotification{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WebChatDialogNotification.changeset(%WebChatDialogNotification{}, @invalid_attrs)
    refute changeset.valid?
  end
end
