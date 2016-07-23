# Docker Images for pokemongo-map

Further details on PokemonGo-Map can be found here:

https://github.com/AHAAAAAAA/PokemonGo-Map

## Purpose:

This will pull the latest code from the repository on start. Any restarts of the container will cause it to pull the latest changes. There are two images available for use:

* ashex/pokemongo-map:develop - Pulls the develop branch
* ashex/pokemongo-map:master - Pulls from the master branch
* ashex/pokemongo-map:latest - Most recent release

For the latest *features* use the develop tag. 

Currently the project isn't making tagged releases, rather merging to master (most recent being 2.0). There will be a tagged image for each pseudo-release (most recent being 2.0), latest pointing to the most recent however they're still pushing small changes to master, as such master will sometimes have fixes missing from latest. 

Latest is a built static image while master/develop are dynamic, pulling in changes from the repository.


## Usage:

### Passing settings

You can either pass settings via arguments that the tool supports or with Environmental variables. Below is a list of avaialable settings and their variables:


| Flag  | Variable  |
|---|---|
| --auth-service  | AUTH_SERVICE  |
| --username  | USERNAME  |
| --password  | PASSWORD  |
| --location  | LOCATION  |
| --step-limit  | STEP_LIMIT  |
| --ignore  | IGNORE  |
| --only  | ONLY  |
| --locale  | LOCALE  |
| --auto_refresh  | AUTO_REFRESH  |
| --google-maps-key  | GMAPS_KEY  |
| --display-pokestops  | DISPLAY_POKESTOPS  |
| --display-lured  | DISPLAY_LURED  |
| --display-gyms  | DISPLAY_GYMS  |
| --no-server  | NO_SERVER  |
| --cors  | CORS  |

This list contains all flags for both master and develop, make sure you're aware what flags are supported on branch (since develop tends to get new flags regularly) as the tool will fail to run if you add an unsupported flag.


### Example
`docker run -d -P --name pokemongo-map ashex/pokemongo-map -a -e "AUTH_SERVICE=ptc" -e "USERNAME=UserName" -e "PASSWORD=Password" -E "LOCATION=Seattle, WA" -e "STEP_LIMIT=5" -e "GMAPS_KEY=SUPERSECRET"`



