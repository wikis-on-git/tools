set -e

while IFS= read -r -d $'\0' folder; do
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

    git config --local remote.origin.namespaces '(Main) Talk Wikipedia Category Help Template'
    git config --local remote.origin.fetchstrategy by_rev
    
    # manual states to use `git pull --rebase` - but as we use a bare git, it makes no sense to pull here.
    git fetch origin 2>&1 | tee -a "../fetch_$(basename $folder)_update.log"

    git repack -F -d -A -n --window=500 --depth=2000 --write-bitmap-index --write-midx
    git prune

    git push github
    git push github refs/notes/*:refs/notes/*
    git push github refs/mediawiki/*:refs/mediawiki/*

    popd
    mv "$folder" 'pinned+github+updated/'
  else
    popd
  fi
done < <(find 'pinned+github' -maxdepth 1 -type d -print0)
