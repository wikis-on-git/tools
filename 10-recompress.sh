set -e

cd ..

while IFS= read -r -d $'\0' folder; do
  [ "$folder" = '00-completed' ] && continue
  echo "processing '$folder'"

  pushd "$folder"
  if [ -f ./HEAD ]; then
    # select compression ratio
    git config --local core.compression 7
    git config --local pack.depth 2000
    git config --local pack.window 500
    git config --local repack.writeBitmaps true
    git config --local pack.writeBitmapHashCache true
    git config --local pack.deltaCacheLimit 4000
    git config --local pack.threads 3
    git config --local pack.writeReverseIndex true

    git repack -F -d -A -n --window=500 --depth=2000 --write-bitmap-index --write-midx
    git prune
    popd
    mv "$folder" '10-recompressed/'
  else
    popd
  fi

  # run only one folder
#  break
done < <(find '00-completed' -maxdepth 1 -type d -print0)
