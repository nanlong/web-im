defmodule Zheye.WebChatFirendRequestTest do
  use Zheye.ModelCase

  alias Zheye.WebChatFirendRequest

  @valid_attrs %{domain: "some content", from_user_id: "some content", is_confirmed: true, to_user_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WebChatFirendRequest.changeset(%WebChatFirendRequest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WebChatFirendRequest.changeset(%WebChatFirendRequest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
