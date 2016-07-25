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
      -nk | --no-pokestops)
	  NO_POKESTOPS="TRUE"
	  shift 1
	  ;;
      -np | --no-pokemon)
	  NO_POKEMON="TRUE"
	  shift 1
	  ;;
      -ng | --no-gyms)
	  NO_GYMS="TRUE"
	  shift 1
	  ;;
      -ns | --no-server)
	  NO_SERVER="TRUE"
	  shift 1
	  ;;
      -C | --cors)
	  CORS="TRUE"
	  shift 1
      -t | --threads)
	  THREADS="$2"
	  shift 2
	  ;;
      --) # End of all options
	  shift
	  break
      ;;
      -fl | --fixed-location)
	  FIXED_LOCATION="TRUE"
	  shift 1
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

if [[ -n "$NO_POKESTOPS" ]]; then
   ARGUMENTS="$ARGUMENTS --no-pokestops"
fi

if [[ -n "$NO_POKEMON" ]]; then
   ARGUMENTS="$ARGUMENTS --no-pokemon"
fi

if [[ -n "$NO_GYMS" ]]; then
   ARGUMENTS="$ARGUMENTS --no-gyms"
fi

if [[ -n "$NO_SERVER" ]]; then
   ARGUMENTS="$ARGUMENTS --no-server"
fi

if [[ -n "$CORS" ]]; then
   ARGUMENTS="$ARGUMENTS --cors"
fi

if [[ -n "$THREADS" ]]; then
   ARGUMENTS="$ARGUMENTS --threads $THREADS"
fi

if [[ -n "$FIXED_LOCATION" ]]; then
   ARGUMENTS="$ARGUMENTS --fixed-location"
fi

# If the repo has already been created, pull the latest changes
# Otherwise create and clone the repo
if [ -d ".git" ]; then
    #grunt modifies css files
    git reset --hard origin/develop
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


