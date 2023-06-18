defmodule KausiApi.DetailsTest do
  use KausiApi.DataCase

  alias KausiApi.Details

  describe "details" do
    alias KausiApi.Details.Detail

    import KausiApi.DetailsFixtures

    @invalid_attrs %{category: nil, contact: nil, description: nil, image: nil, location: nil, price: nil, title: nil}

    test "list_details/0 returns all details" do
      detail = detail_fixture()
      assert Details.list_details() == [detail]
    end

    test "get_detail!/1 returns the detail with given id" do
      detail = detail_fixture()
      assert Details.get_detail!(detail.id) == detail
    end

    test "create_detail/1 with valid data creates a detail" do
      valid_attrs = %{category: "some category", contact: "some contact", description: "some description", image: "some image", location: "some location", price: 120.5, title: "some title"}

      assert {:ok, %Detail{} = detail} = Details.create_detail(valid_attrs)
      assert detail.category == "some category"
      assert detail.contact == "some contact"
      assert detail.description == "some description"
      assert detail.image == "some image"
      assert detail.location == "some location"
      assert detail.price == 120.5
      assert detail.title == "some title"
    end

    test "create_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Details.create_detail(@invalid_attrs)
    end

    test "update_detail/2 with valid data updates the detail" do
      detail = detail_fixture()
      update_attrs = %{category: "some updated category", contact: "some updated contact", description: "some updated description", image: "some updated image", location: "some updated location", price: 456.7, title: "some updated title"}

      assert {:ok, %Detail{} = detail} = Details.update_detail(detail, update_attrs)
      assert detail.category == "some updated category"
      assert detail.contact == "some updated contact"
      assert detail.description == "some updated description"
      assert detail.image == "some updated image"
      assert detail.location == "some updated location"
      assert detail.price == 456.7
      assert detail.title == "some updated title"
    end

    test "update_detail/2 with invalid data returns error changeset" do
      detail = detail_fixture()
      assert {:error, %Ecto.Changeset{}} = Details.update_detail(detail, @invalid_attrs)
      assert detail == Details.get_detail!(detail.id)
    end

    test "delete_detail/1 deletes the detail" do
      detail = detail_fixture()
      assert {:ok, %Detail{}} = Details.delete_detail(detail)
      assert_raise Ecto.NoResultsError, fn -> Details.get_detail!(detail.id) end
    end

    test "change_detail/1 returns a detail changeset" do
      detail = detail_fixture()
      assert %Ecto.Changeset{} = Details.change_detail(detail)
    end
  end
end
