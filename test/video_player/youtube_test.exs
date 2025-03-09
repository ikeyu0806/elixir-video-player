defmodule VideoPlayer.YoutubeTest do
  use VideoPlayer.DataCase

  alias VideoPlayer.Youtube

  describe "channels" do
    alias VideoPlayer.Youtube.Channel

    import VideoPlayer.YoutubeFixtures

    @invalid_attrs %{channel_id: nil}

    test "list_channels/0 returns all channels" do
      channel = channel_fixture()
      assert Youtube.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Youtube.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      valid_attrs = %{channel_id: "some channel_id"}

      assert {:ok, %Channel{} = channel} = Youtube.create_channel(valid_attrs)
      assert channel.channel_id == "some channel_id"
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Youtube.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()
      update_attrs = %{channel_id: "some updated channel_id"}

      assert {:ok, %Channel{} = channel} = Youtube.update_channel(channel, update_attrs)
      assert channel.channel_id == "some updated channel_id"
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Youtube.update_channel(channel, @invalid_attrs)
      assert channel == Youtube.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Youtube.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Youtube.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Youtube.change_channel(channel)
    end
  end
end
