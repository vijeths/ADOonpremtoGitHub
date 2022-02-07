#!/bin/bash
if [[ ! -f $1 ]]; then echo "$1 file not found"; exit 99; fi

#read -p 'GitHub Username (not email): ' GH_USERNAME
#read -sp 'GitHub Password: ' GH_PASSWORD
#read -p 'BitBucket Username (not email): ' ADO_USERNAME
#read -sp 'BitBucket Password: ' ADO_PASSWORD

(cat "$1" ; echo) | tail -n +2 | tr -d '\r' | while IFS=, read -r ado_repo ado_org gh_repo gh_org description archive private
do
  if [ -z "$ado_repo" ]; then continue; fi # skip empty lines
  echo
  
  echo "###### Processing $ado_repo -> $gh_org/$gh_repo. Cloning from Bitbucket..."
  #next_url="https://api.bitbucket.org/2.0/repositories?role=member"
  #test=$(curl -s --user $ADO_USERNAME:$ADO_PASSWORD "$next_url")
  #echo "$test"
  git clone --mirror https://vijeth565:kvaac3kw36q4hzzueqgsunzywl4yb6d4ifnwr7eozpkqu7mb5pva@dev.azure.com/$ado_org/Infy/_git/$ado_repo
  cd $ado_repo.git
  echo

  echo "=== $ado_repo cloned, now creating $gh_org/$gh_repo on GitHub with description [$description]..."
  PRIVATE_FLAG="true"
  if [ "$private" = "no" ]; then 
    echo "PUBLIC!"
    PRIVATE_FLAG="false"
  fi
  curl -u vijeths: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 https://api.github.com/orgs/$gh_org/repos -d "{\"name\": \"$gh_repo\", \"private\": $PRIVATE_FLAG, \"description\": \"$description\"}"
  echo

  echo "=== pushing $gh_org/$gh_repo to GitHub..."
  git push --mirror https://vijeths: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@github.com/$gh_org/$gh_repo
  echo

  if [ "$archive" = "yes" ]; then
    echo "=== archiving repository $gh_org/$gh_repo on GitHub..."
    curl -X PATCH -u vijeths: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 https://api.github.com/repos/$gh_org/$gh_repo -d "{\"archived\": true}"
  fi

  cd ..  
done
