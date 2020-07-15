#!/bin/bash

if [[ -z $(urlwatch) ]]; then

  echo $(date -u) "Nothing changed." >> ~/covid-hyogo/updater.log

else

  echo $(date -u)  "Something changed." >> ~/covid-hyogo/updater.log 

  # Update Google Spreadsheet
  python3 ./src/updater/updateGoogleSheet.py >> ~/covid-hyogo/updater.log

  # Update local json data
  yarn scrape >> ~/covid-hyogo/updater.log

  # Commit and push
  git checkout master
  git add . >> ~/covid-hyogo/updater.log
  git commit -m "Update data $(date -u)." >> ~/covid-hyogo/updater.log
  git push origin HEAD  => ~/covid-hyogo/updater.log

fi
