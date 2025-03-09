# lib/hello_world/youtube.ex
defmodule VideoPlayer.Youtube do
  @api_url "https://www.googleapis.com/youtube/v3/search"

  def get_channel_videos(channel_id) do
    api_key = System.get_env("GOOGLE_API_KEY")
    IO.puts("api_key: #{api_key}")
    url = "#{@api_url}?key=#{api_key}&channelId=#{channel_id}&part=snippet&type=video&maxResults=5"

    case HTTPoison.get(url) do
      {:ok, response} ->
        IO.puts("response: #{inspect(response)}")
        {:ok, parse_response(response.body)}

      {:error, _reason} ->
        {:error, "Failed to fetch data from YouTube API"}
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
end
