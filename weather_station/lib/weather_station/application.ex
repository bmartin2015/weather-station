defmodule WeatherStation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @target Mix.Project.config()[:target]

  @sensor_base_dir "/sys/bus/w1/devices/"
  @sensor_id "NEEDED"
  @sensor_path "#{@sensor_base_dir}#{@sensor_id}/w1_slave"

  use Application

  def start(_type, _args) do

    #read_temp()
    get_sensors()


    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeatherStation.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  # List all child processes to be supervised
  def children("host") do
    [
      # Starts a worker by calling: WeatherStation.Worker.start_link(arg)
      # {WeatherStation.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Starts a worker by calling: WeatherStation.Worker.start_link(arg)
      # {WeatherStation.Worker, arg},
    ]
  end

  def read_temp do
    Logger.debug("Reading sensor: #{@sensor_path}")
    sensor_data =
      @sensor_path
      |> File.read!
    {temp, _} = Regex.run(~r/t=(\d+)/, sensor_data)
    |> List.last
    |> Float.parse

    celsius = (temp / 1000)
    fahrenheit = ((celsius * 9)/5)+32
    Logger.debug "#{fahrenheit} *F"
    :timer.sleep(1000)
    read_temp
  end

  def get_sensors do
    Logger.debug("Listing sensors:")
    {:ok, ls} = File.ls(@sensor_base_dir)
    sensors = Enum.filter(ls, fn x -> 
      File.dir?(x)
    end)
    Enum.each(sensors, fn(sensor) -> 
      Logger.debug("#sensor")
    end)
    Logger.debug("finished")
  end
end
