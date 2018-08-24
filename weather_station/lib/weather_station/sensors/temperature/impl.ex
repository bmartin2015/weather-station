defmodule WeatherStation.Sensors.Temperature.Impl do
  @moduledoc false

  @sensor_base_dir "/sys/bus/w1/devices/"


  @type id :: String.t()

  @spec read(id) :: float
  def read(id) do
    sensor_path = "#{@sensor_base_dir}#{id}/w1_slave"
    |> as_binary()
    |> parse_temp()
  end

  defp as_binary(path) do
    path
    |> File.read!()
  end

  defp parse_temp(data) do
    {temp, _} = 
      Regex.run(~r/t=(\d+)/, data)
      |> List.last()
      |> Float.parse

      temp / 1000
  end
end
