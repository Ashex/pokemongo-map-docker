# Docker Images for pokemongo-map

Further details on PokemonGo-Map can be found here:

https://github.com/AHAAAAAAA/PokemonGo-Map

## Purpose:

This will pull the latest code from the repository on start. Any restarts of the container will cause it to pull the latest changes. The following images available for use:

* ashex/pokemongo-map:develop - Pulls the develop branch
* ashex/pokemongo-map:master - Pulls from the master branch
* ashex/pokemongo-map:latest - Most recent release

For the latest *features* use the develop tag. 


The project is making tagged releases (most recent being v2.0.0) however small changes continue to be merged into master . Because of this while latest is the most recent release sometimes master will have fixes missing from latest. 

Latest is a built static image while master/develop are dynamic, pulling in changes from the repository.


## Usage:

### Passing settings

#### Master branch

You can either pass settings via arguments that the tool supports or with Environmental variables. Below is a list of avaialable settings and their variables:


| Flag  | Variable  |
|---|---|
| --auth-service  | AUTH_SERVICE  |
| --username  | USERNAME  |
| --password  | PASSWORD  |
| --location  | LOCATION  |
| --step-limit  | STEP_LIMIT  |
| --locale  | LOCALE  |
| --google-maps-key  | GMAPS_KEY  |
| --no-pokestops  | NO_POKESTOPS  |
| --no-pokemon  | NO_POKEMON  |
| --no-gyms  | NO_GYMS  |
| --no-server  | NO_SERVER  |
| --cors  | CORS  |
| --threads | THREADS |
| --fixed-location | FIXED_LOCATION |
| --scan-delay | SCAN_DELAY |
| --db | DATABASE |


```bash
  docker run -d -P \
    --name pokemongo-map \
    -e "AUTH_SERVICE=ptc" \
    -e "USERNAME=UserName" \
    -e "PASSWORD=Password" \
    -e "LOCATION=Seattle, WA" \
    -e "STEP_LIMIT=5" \
    -e "GMAPS_KEY=SUPERSECRET" \
    ashex/pokemongo-map
```

or

```bash
  docker run -d -P \
    --name pokemongo-map \
    --auth-service ptc \
    --username UserName \
    --password Password \
    --location "Seattle, WA" \
    --step-limit "5" \
    --google-maps-key "SUPERSECRET" \
    ashex/pokemongo-map
```

#### Develop branch

The project recently made the switch from `argparse` to `configargparse` which allows applying settings through a config.ini file. This removes the need to maintain a list of flags in the entrypoint script for handling variables. You can now pass settings with any argument the tool supports. If you prefer to use environment variables you need to prepend the variable with `POKEMON_`. For example: 

```bash
docker run -d -P \
   --name pokemongo-map \
   -e "POKEMON_AUTH_SERVICE=ptc" \
   -e "POKEMON_USERNAME=UserName" \
   -e "POKEMON_PASSWORD=Password" \
   -e "POKEMON_LOCATION=Seattle, WA" \
   -e "POKEMON_STEP_LIMIT=5" \
   -e "POKEMON_GMAPS_KEY=SUPERSECRET" \
   ashex/pokemongo-map
```



