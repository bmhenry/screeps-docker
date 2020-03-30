# `screeps` in Docker

This is the default `screeps` server, running in Docker. It most likely shouldn't be used for high-volume instances, as it uses the default JSON database backend.


## Usage

Data is preserved between runs using volumes. If these volumes are not provided to the container, all data will be lost when the container stop. It's recommended to use `docker-compose` with the included file.

1. Copy `example.screepsrc` to `.screepsrc`, and edit as necessary (hostname, steam api key, etc.)
2. Make an empty `data` directory (making it yourself ensures you'll have permissions to access it, otherwise it'll be created automatically as whatever user you're running as (`root`, if you're using sudo!))
3. Do an initial run to create the image, world, & other assets: `docker-compose up --build`
4. Press `Ctrl+C` to stop the server once it's running
5. Server data will be in the `data` directory.
6. Run the server again, this time in the background if you wish: `docker-compose up -d`


## Mods
`screepsmod-auth` and `screepsmod-admin-utils` will be installed for you, but you'll need to activate them. Add them to `data/mods.json`:

```json
{
  "mods": [
  	...
  	"../node_modules/screepsmod-auth/index.js",
  	"../node_modules/screepsmod-admin-utils/index.js",
  	...
  ],
  ...
}
```

Any additional mods should be placed in the `data/mods` directory, and then configured in `mods.json`:

```json
{
	"mods": [
		...
		"mods/mod-name.js",
		...
	],
	...
}
```