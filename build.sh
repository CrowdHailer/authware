#!/bin/sh
echo "*** Running main project tests"
bundle exec rake test

cd gems/typtanic
echo "*** Running typtanic tests"
bundle exec rake test
cd ../../

# cd gems/sequel-stash
# echo "*** Running sequel-stash tests"
# bundle exec rake test
# cd ../../
