#!/bin/bash
set +e

echo "Hello this is minimum backup"
bsource1="/srv/gitlab/config/gitlab-secrets.json"
bsource2="/srv/gitlab/config/gitlab.rb"
count=0
gcount=0

bak() {

b1="$@"

tdir="zipdir"
t1=`date '+%Y%m%d'`

if [[ ! -d $HOME/$tdir ]]
then
        mkdir $HOME/$tdir
fi

if [[ ! -d $HOME/$tdir/$t1 ]]
then
        mkdir $HOME/$tdir/$t1
fi

for b in "$@"
do

cp -r $b  $HOME/$tdir/$t1/

done

cd $HOME/$tdir/$t1
#tar zcvf $HOME/$tdir/$t1.tar.gz .
tar jcvf $HOME/$tdir/$t1.tar.bz2 .

}


bak $bsource1 $bsource2

echo "Total Parent and Sub Directory count is $count"
echo "Total GITs present in them gcount is $gcount"

#gitlab-rake gitlab:import:repos["/var/opt/gitlab/git-data/repository-import"]
