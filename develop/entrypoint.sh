#!/bin/sh

# Grab the variables starting with POKEMON_
# and create the config.ini with them
create_config_ini () 
{
# Change the API keys in credentials.json 
# If a variable with the value is provided
    for VAR in `env`
    do
      case "$VAR" in
          POKEMON_* )
          #This was going to be a single sed but I couldn't figure out how to do lowercase conversion
        key_name=`echo "$VAR" | sed -e "s/^POKEMON_\(.*\)\=.*/\1/" -e 's/_/-/g' | tr '[:upper:]' '[:lower:]'` 
        echo "Setting value of" $key_name
        key_value=`echo "$VAR" | sed -e "s/.*=\(.*\)/\1/"`
        echo "$key_name: $key_value" >> config/config.ini
        ;;
        esac
    done
}

# Generate config.ini on first run only
if [ ! -d "config" ]; then
    mkdir config
    create_config_ini
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
    python runserver.py --host 0.0.0.0

else
    git init
    git remote add origin https://github.com/AHAAAAAAA/PokemonGo-Map.git
    git pull origin develop
    pip install -r requirements.txt
    npm install
    grunt jshint sass cssmin uglify
    python runserver.py --host 0.0.0.0
fi


