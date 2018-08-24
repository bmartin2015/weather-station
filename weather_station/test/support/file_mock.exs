defmodule WeatherStation.Test.FileMock do
  def ls(dir) do
    {:ok, ["28-123456adfe"]}
  end

  def dir?(value) do
    true
  end
end
