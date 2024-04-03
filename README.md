# FiveM Panic Button Resource

This resource adds a panic button functionality to your FiveM server. When a player presses the panic button, the resource collects detailed location information and sends it to the Community CAD API.

## Features

- Collects detailed location information, including street name, crossing road name, zone name, and postal code.
- Sends location information to the Community CAD API when the panic button is pressed.
- Configurable options to enable or disable each piece of location information.
- Debug mode for printing debug information.
- Error handling for API requests.

## Configuration

The resource has two configuration files: `config.lua` for client-side options and `server_config.lua` for server-side options.

### `config.lua`

- `StreetName`: Enable or disable the street name. Set to `true` to enable, `false` to disable.
- `CrossingRoadName`: Enable or disable the crossing road name. Set to `true` to enable, `false` to disable.
- `ZoneName`: Enable or disable the zone name. Set to `true` to enable, `false` to disable.
- `PostalName`: Enable or disable the postal code. Set to `true` to enable, `false` to disable.

### `server_config.lua`

- `Api`: The API key for the Community CAD API.
- `ApiUrl`: The URL of the Community CAD API.
- `Debug`: Enable or disable debug mode. Set to `true` to enable, `false` to disable.

## Dependencies

- `nearest-postal`: This resource is used to get the nearest postal code. It must be installed on your server for the postal code feature to work.

## Usage

To use the panic button, type `/panic` in the chat. The resource will collect the enabled location information and send it to the Community CAD API.
