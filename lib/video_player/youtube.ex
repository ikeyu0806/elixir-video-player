# lib/hello_world/youtube.ex
defmodule VideoPlayer.Youtube do
  @api_url "https://www.googleapis.com/youtube/v3/search"
  @api_key System.get_env("GOOGLE_API_KEY")

  def get_channel_videos(channel_id) do
    url = "#{@api_url}?key=#{@api_key}&channelId=#{channel_id}&part=snippet&type=video&maxResults=5"

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
            title: item["snippet"]["title"],
            video_url: "https://www.youtube.com/watch?v=#{item["id"]["videoId"]}",
            thumbnail: item["snippet"]["thumbnails"]["high"]["url"]
          }
        end)

      {:error, _} ->
        []
    end
  end
end
