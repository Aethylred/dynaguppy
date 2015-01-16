#!/bin/sh
# This script will test to see if a Puppetfile has been updated
# in the last git commit. If so, it will run librarian-puppet.
# This scrip will retry librarian-puppet a number of times until 
# it completes successfully.
# 
# This script should be run in a puppet environment directory

echo 'Checking Puppetfile status'
if git show --pretty --no-color --name-only | grep Puppetfile > /dev/null 2>&1 ; then
  echo 'Puppetfile updated in last commit'
  if test -d 'library' ; then
    echo 'Dynaguppy module library exists'
    logger -isd -p syslog.info -t DYNAGUPPY 'Attempting to update Dynaguppy Puppet module library'
    until output=$(librarian-puppet update 2>&1) ; do
      # If error was captured some fixes could go here...
      if echo $output | grep 'Could not resolve the dependencies.' ; then
        logger -isd -p syslog.error -t DYNAGUPPY 'Updating Dynaguppy Puppet module library failed, could not resolve the dependencies. Exiting.'
        break
      fi
      logger -isd -p syslog.warning -t DYNAGUPPY 'Updating Dynaguppy Puppet module library failed, retrying'
    done
    logger -isd -p syslog.info -t DYNAGUPPY 'Dynaguppy Puppet module library update completed'
  else
    echo 'Dynaguppy module library missing'
    logger -isd -p syslog.info -t DYNAGUPPY 'Attempting to initialise Dynaguppy Puppet module library'
    until output=$(librarian-puppet install --clean 2>&1) ; do
      # If error was captured some fixes could go here...
      if echo $output | grep 'Could not resolve the dependencies.' ; then
        logger -isd -p syslog.error -t DYNAGUPPY 'Initialising Dynaguppy Puppet module library failed, could not resolve the dependencies. Exiting.'
        break
      fi
      logger -isd -p syslog.warning -t DYNAGUPPY 'Initialising Dynaguppy Puppet module library failed, retrying'
    done
    logger -isd -p syslog.info -t DYNAGUPPY 'Dynaguppy Puppet module library initialisation completed'
  fi
else
  logger -isd -p syslog.info -t DYNAGUPPY 'Puppetfile not updated in last commit, skipping librarian-puppet'
fi

exit $?