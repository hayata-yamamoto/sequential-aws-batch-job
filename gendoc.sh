#!/bin/bash

(cd ./modules
for d in `find . -type d -regex '\./[^.]*$'`
do (cd $d

    terraform-docs md ./ | cat -s > README.md

) done
)


(cd ./aws
for d in `find . -type d -regex '\./[^.]*$'`
do (cd $d

    terraform-docs md ./ | cat -s > Docs.md

) done
)
