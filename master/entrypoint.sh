#!/bin/sh

# Grab the arguments and store them as variables
# If a variable and an argument were passed for the same setting
# The argument wins
while :
do
    case "$1" in
      -a | --auth-service)
	  AUTH_SERVICE="$2"  
	  shift 2
	  ;;
      -u | --username)
	  USERNAME="$2"  
	  shift 2
	  ;;
      -p | --password)
	  PASSWORD="$2" 
	  shift 2
	  ;;
      -l | --location)
	  LOCATION="$2"
	  shift 2
	  ;;
      -st | --step-limit)
	  STEP_LIMIT="$2"
	  shift 2
	  ;;
      -i | --ignore)
	  IGNORE="$2"
	  shift 2
	  ;;
      -o | --only)
	  ONLY="$2"
	  shift 2
	  ;;
      -l | --locale)
	  LOCALE="$2"
	  shift 2
	  ;;
      -ar | --auto_refresh)
	  AUTO_REFRESH="$2"
	  shift 2
	  ;;
      -k | --google-maps-key)
	  GMAPS_KEY="$2"
	  shift 2
	  ;;
      -dp | --display-pokestops)
	  DISPLAY_POKESTOPS="TRUE"
	  shift 1
	  ;;
      -dl | --display-lured)
	  DISPLAY_LURED="TRUE"
	  shift 1
	  ;;
      -dg | --display-gyms)
	  DISPLAY_GYMS="TRUE"
	  shift 1
	  ;;
      -ns | --no-server)
	  NO_SERVER="TRUE"
	  shift 1
	  ;;
      -C | --cors)
	  CORS="TRUE"
	  shift 1
	  ;;
      --) # End of all options
	  shift
	  break
      ;;
      -*)
	  echo "Error: Unknown option: $1" >&2
	  exit 1
	  ;;
      *)  # No more options
	  break
	  ;;
    esac
done

# Set defaults for unset arguments 
if [[ -z "$LOCALE" ]]; then
   LOCALE="en"
 fi

if [[ -z "$STEP_LIMIT" ]]; then
   STEP_LIMIT=5
fi

# Store all arguments in a variable so we can extend it with optional ones
# We pass location and api key separately because sh kept expanding even when wrapped in quotes
ARGUMENTS="--auth-service $AUTH_SERVICE --username $USERNAME --password $PASSWORD --st $STEP_LIMIT --locale $LOCALE"

# Add optional arguments
if [[ -n "$IGNORE" ]]; then
   ARGUMENTS="$ARGUMENTS --ignore $IGNORE"
fi

if [[ -n "$ONLY" ]]; then
   ARGUMENTS="$ARGUMENTS --only $ONLY"
fi

if [[ -n "$AUTO_REFRESH" ]]; then
   ARGUMENTS="$ARGUMENTS --auto_refresh $AUTO_REFRESH"
fi

if [[ -n "$DISPLAY_POKESTOPS" ]]; then
   ARGUMENTS="$ARGUMENTS --display-pokestops"
fi

if [[ -n "$DISPLAY_LURED" ]]; then
   ARGUMENTS="$ARGUMENTS --display-lured"
fi

if [[ -n "$DISPLAY_GYMS" ]]; then
   ARGUMENTS="$ARGUMENTS --display-gyms"
fi

if [[ -n "$NO_SERVER" ]]; then
   ARGUMENTS="$ARGUMENTS --no-server"
fi

if [[ -n "$CORS" ]]; then
   ARGUMENTS="$ARGUMENTS --cors"
fi

# If the repo has already been created, pull the latest changes
# Otherwise create and clone the repo
if [ -d ".git" ]; then
    git pull origin develop
    pip install -r requirements.txt
    npm update
    grunt jshint sass cssmin uglify
    python runserver.py --host 0.0.0.0 $ARGUMENTS --location "$LOCATION" --google-maps-key "$GMAPS_KEY"

else
    git init
    git remote add origin https://github.com/AHAAAAAAA/PokemonGo-Map.git
    git pull origin develop
    pip install -r requirements.txt
    npm install
    grunt jshint sass cssmin uglify
    python runserver.py --host 0.0.0.0 $ARGUMENTS --location "$LOCATION" --google-maps-key "$GMAPS_KEY"
fi


