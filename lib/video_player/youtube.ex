# lib/hello_world/youtube.ex
defmodule VideoPlayer.Youtube do
  alias VideoPlayer.Repo
  alias VideoPlayer.Channel

  @api_url "https://www.googleapis.com/youtube/v3/search"

  def get_channel_videos(channel_id) do
    api_key = System.get_env("GOOGLE_API_KEY")
    IO.puts("api_key: #{api_key}")
    url = "#{@api_url}?key=#{api_key}&channelId=#{channel_id}&part=snippet&type=video&maxResults=5"

    case HTTPoison.get(url, [], follow_redirect: true) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case parse_response(body) do
          {:ok, videos} when is_list(videos) ->
            {:ok, videos}

          {:error, msg} ->
            {:error, msg}

          _unexpected_response ->
            {:error, "Unexpected response format"}
        end

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:error, extract_error_message(body)}

      {:error, _reason} ->
        {:error, "Failed to fetch data from YouTube API"}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "YouTube API returned status code #{code}"}

      {:error, reason} ->
        {:error, "Failed to fetch data from YouTube API: #{inspect(reason)}"}
    end
  end


  defp extract_error_message(body) do
    case Jason.decode(body) do
      {:ok, %{"error" => %{"message" => message}}} -> message
      _ -> "Unknown error from YouTube API"
    end
  end

  defp parse_response(response_body) do
    case Jason.decode(response_body) do
      {:ok, %{"items" => items}} ->
        Enum.map(items, fn item ->
          %{
            video_id: item["id"]["videoId"],
            title: item["snippet"]["title"],
            video_url: "https://www.youtube.com/watch?v=#{item["id"]["videoId"]}",
            thumbnail_url: item["snippet"]["thumbnails"]["default"]["url"]
          }
        end)

      {:error, _} ->
        []
    end
  end

  alias VideoPlayer.Youtube.Channel

  @doc """
  Returns the list of channels.

  ## Examples

      iex> list_channels()
      [%Channel{}, ...]

  """
  def list_channels do
    Repo.all(Channel)
  end

  @doc """
  Gets a single channel.

  Raises `Ecto.NoResultsError` if the Channel does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channel{}

      iex> get_channel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channel!(id), do: Repo.get!(Channel, id)

  @doc """
  Creates a channel.

  ## Examples

      iex> create_channel(%{field: value})
      {:ok, %Channel{}}

      iex> create_channel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a channel.

  ## Examples

      iex> update_channel(channel, %{field: new_value})
      {:ok, %Channel{}}

      iex> update_channel(channel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_channel(%Channel{} = channel, attrs) do
    channel
    |> Channel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a channel.

  ## Examples

      iex> delete_channel(channel)
      {:ok, %Channel{}}

      iex> delete_channel(channel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channel(%Channel{} = channel) do
    Repo.delete(channel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channel changes.

  ## Examples

      iex> change_channel(channel)
      %Ecto.Changeset{data: %Channel{}}

  """
  def change_channel(%Channel{} = channel, attrs \\ %{}) do
    Channel.changeset(channel, attrs)
  end
end
