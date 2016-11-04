defmodule Zheye.WebChatUserTest do
  use Zheye.ModelCase

  alias Zheye.WebChatUser

  @valid_attrs %{avatar: "some content", bio: "some content", name: "some content", online: true, origin_domain: "some content", origin_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WebChatUser.changeset(%WebChatUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WebChatUser.changeset(%WebChatUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
