set -e

cd ..

while IFS= read -r -d $'\0' folder; do
  [ "$folder" = '10-recompressed' ] && continue
  echo "processing '$folder'"

  (
    set -e
    cd "$folder"
    if [ -f ./HEAD ]; then
      git remote add github "git@github.com:wikis-on-git/$(basename $folder).wikipedia.org.git" 2>&1 >/dev/null
      git push github 2>&1 >/dev/null
      cd ../..
      mv "$folder" '20-imported2github/'
    fi
  )&

  echo "start sleeping for 10 seconds..."
  sleep 10

  # run only one folder
  #break
done < <(find '10-recompressed' -maxdepth 1 -type d -print0)

echo "waiting for jobs to be finished..."

for job in `jobs -p`
do
echo $job
    wait $job
done
