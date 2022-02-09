#!/bin/bash
#if [[ ! -f $1 ]]; then echo "$1 file not found"; exit 99; fi

#read -p 'GitHub Username (not email): ' GH_USERNAME
#read -sp 'GitHub Password: ' GH_PASSWORD
#read -p 'BitBucket Username (not email): ' ADO_USERNAME
#read -sp 'BitBucket Password: ' ADO_PASSWORD

#(cat "$1" ; echo) | tail -n +2 | tr -d '\r' | while IFS=, read -r ado_repo ado_org gh_repo gh_org description archive private
#do
  #if [ -z "$ado_repo" ]; then continue; fi # skip empty lines
  
  #$ado_repo = repoA
  #$ado_org = vijeth565
  #$gh_repo = ghA
  #$gh_org = vijeths
  
  echo
  
  #echo "###### Processing $ado_repo -> $gh_org/$gh_repo. Cloning from ADO..."

  git clone --mirror https://vijeth565:kvaac3kw36q4hzzueqgsunzywl4yb6d4ifnwr7eozpkqu7mb5pva@dev.azure.com/vijeth565/Infy/_git/repoA
  cd repoA.git
  echo

  #echo "=== $ado_repo cloned, now creating $gh_org/$gh_repo on GitHub with description [$description]..."
  PRIVATE_FLAG="true"
  if [ "$private" = "no" ]; then 
    echo "PUBLIC!"
    PRIVATE_FLAG="false"
  fi
  #curl -u vijeths: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 https://api.github.com/orgs/$gh_org/repos -d "{\"name\": \"$gh_repo\", \"private\": $PRIVATE_FLAG, \"description\": \"$description\"}"
  #curl -u ${{ secrets.GITHUB_TOKEN }}:'https://api.github.com/orgs/$gh_org/repos -d "{\"name\": \"$gh_repo\", \"private\": $PRIVATE_FLAG, \"description\": \"$description\"}"'
  #curl -H 'Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}' --location --request 'https://api.github.com/orgs/$gh_org/repos'
  #curl -u ${{ secrets.GITHUB_TOKEN }} : "https://vijeths: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@github.com/vijeths/ghA.git"
  #curl -u vijeths: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 --location --request GET 'https://api.github.com/orgs/$gh_org/repos -d "{\"name\": \"$gh_repo\", \"private\": $PRIVATE_FLAG, \"description\": \"$description\"}"'
  echo

  echo "=== pushing $gh_org/$gh_repo to GitHub..."
  git push --mirror https://vijeths:tn+*VjZWM23@github.com/vijeths/ghA.git
  echo

  #if [ "$archive" = "yes" ]; then
   # echo "=== archiving repository $gh_org/$gh_repo on GitHub..."
    #curl -X PATCH -u vijeths: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 https://api.github.com/repos/$gh_org/$gh_repo -d "{\"archived\": true}"
  #fi

  cd ..  
#done
