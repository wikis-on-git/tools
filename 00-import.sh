#set -e

# source ./small_wikis.sh
source ./large_wikis.sh

for wiki in "${wikis[@]}"; do
  git clone --mirror "mediawiki::https://${wiki}.wikipedia.org/w/" "/tmp/$wiki" && mv "/tmp/$wiki" ../00-completed/
done
