# tools

Crude set of scripts to create, process and update the git's from wikipedia. The toolset expects to be placed in a project subfolder and have the following folders placed next to it:

``
./00-completed
./10-recompressed
./20-imported2github
./30-updated
``

Toolset needs the dependencies for mediawiki support of git:

- perl-mediawiki-api: git mediawiki support
- perl-datetime-format-iso8601: git mediawiki support
- perl-lwp-protocol-https: git mediawiki https support
