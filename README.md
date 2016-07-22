# Docker Images for pokemongo-map

Further details on PokemonGo-Map can be found here:

https://github.com/AHAAAAAAA/PokemonGo-Map

## Purpose:

This will pull the latest code from the repository on start. Any restarts of the container will cause it to pull the latest changes. There are two images available for use:

* ashex/pokemongo-map:develop - Pulls the develop branch
* ashex/pokemongo-map:master - Pulls from the master branch

Latest points to the master branch. For the latest features use the develop tag.


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


This list contains all flags for both master and develop, make sure you're aware what flags are supported on each as the tool will fail to run if you add an extra flag.

### Example
`docker run -d -P --name pokemongo-map ashex/pokemongo-map:develop -a -e "AUTH_SERVICE=ptc" -e "USERNAME=UserName" -e "PASSWORD=Password" -E "LOCATION=Seattle, WA" -e "STEP_LIMIT=5" -e "GMAPS_KEY=SUPERSECRET"`


For the master branch you can change the API keys in credentials.json by passing an environmental variable with the value, it must start with POKEMON_ in order to be applied. 

### Example:

`docker run -d -P -e "POKEMON_gmaps_key=SUPERSECRET" --name pokemongo-map ashex/pokemongo-map -a ptc -u UserName -p Password -l "Seattle, WA" -st 5`


**A rewrite is in progress, if you wish to try out the new code use the develop tag**

