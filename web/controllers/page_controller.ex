defmodule Zheye.PageController do
  use Zheye.Web, :controller

  def index(conn, %{"origin_id" => origin_id, "name" => name, "avatar" => avatar, "bio" => bio}) do
    conn
    |> assign(:origin_id, origin_id)
    |> assign(:name, name)
    |> assign(:avatar, avatar)
    |> assign(:bio, bio)
    |> render("index.html")
  end

  def index(conn, %{"id" => "2"}) do
    params = %{
      "origin_id" => "2",
      "name" => "小强",
      "avatar" => "https://avatars.githubusercontent.com/u/19494388?v=3&s=200",
      "bio" => "小强不会死"
    }
    index(conn, params)
  end

  def index(conn, _params) do
    params = %{
      "origin_id" => "100000123",
      "name" => "者也",
      "avatar" => "https://oalksmbwn.qnssl.com/8e05b0b3f276e7d3c32696e237d59146.jpeg?imageView2/1/w/200/h/200",
      "bio" => "在深邃的编码世界，做一枚轻盈的纸"
    }
    index(conn, params)
  end


end
