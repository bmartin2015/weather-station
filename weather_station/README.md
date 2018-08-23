# WeatherStation

**TODO: Add description**

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

## Info about rpi3 (which is what I'm using) + DS18B20 one-wire temp sensor

  * w1 directory: `/sys/bus/w1/devices`
  * This will contain directorsy for each connected snsor ex: `28-xxxxxxxxxxxx`
  * the file we need to read is `28-xxxxxxxxxxxx/w1_slave`

Format for file:
```
af 01 4b 46 7f ff 01 10 bc : crc=bc YES  
af 01 4b 46 7f ff 01 10 bc t=26937
```
The tempature is `t=*****`


