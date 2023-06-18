defmodule KausiApiWeb.DetailControllerTest do
  use KausiApiWeb.ConnCase

  import KausiApi.DetailsFixtures

  alias KausiApi.Details.Detail

  @create_attrs %{
    category: "some category",
    contact: "some contact",
    description: "some description",
    image: "some image",
    location: "some location",
    price: 120.5,
    title: "some title"
  }
  @update_attrs %{
    category: "some updated category",
    contact: "some updated contact",
    description: "some updated description",
    image: "some updated image",
    location: "some updated location",
    price: 456.7,
    title: "some updated title"
  }
  @invalid_attrs %{category: nil, contact: nil, description: nil, image: nil, location: nil, price: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all details", %{conn: conn} do
      conn = get(conn, ~p"/api/details")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create detail" do
    test "renders detail when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/details", detail: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/details/#{id}")

      assert %{
               "id" => ^id,
               "category" => "some category",
               "contact" => "some contact",
               "description" => "some description",
               "image" => "some image",
               "location" => "some location",
               "price" => 120.5,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/details", detail: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update detail" do
    setup [:create_detail]

    test "renders detail when data is valid", %{conn: conn, detail: %Detail{id: id} = detail} do
      conn = put(conn, ~p"/api/details/#{detail}", detail: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/details/#{id}")

      assert %{
               "id" => ^id,
               "category" => "some updated category",
               "contact" => "some updated contact",
               "description" => "some updated description",
               "image" => "some updated image",
               "location" => "some updated location",
               "price" => 456.7,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, detail: detail} do
      conn = put(conn, ~p"/api/details/#{detail}", detail: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete detail" do
    setup [:create_detail]

    test "deletes chosen detail", %{conn: conn, detail: detail} do
      conn = delete(conn, ~p"/api/details/#{detail}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/details/#{detail}")
      end
    end
  end

  defp create_detail(_) do
    detail = detail_fixture()
    %{detail: detail}
  end
end
