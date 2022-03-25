#!/bin/bash
set +e

echo "Hello"
#source="/home/scripts/sdir/*"
#dest="/root/scripts/ddir"
#source="/var/opt/gitlab/importrepo/@hashed/"
#dest="/var/opt/gitlab/git-data/repository-import"
dest="/srv/gitlab/data/git-data/repository-import"
count=0
gcount=0

func() {

t1="$@"
#echo "t1 is $t1"

for k in "$@"
do
  echo "now k is $k"
  if [[ -d "$k" ]] && [[ ! "$k" =~ ".git" ]] && [[ !  -z `(ls -A "$k")` ]]
  then
    #echo "Before recursion $count and k is $k"
    ((count=count+1))
    func $k/*
  elif [[ "$k" =~ ".git" ]]
  then
   ((gcount=gcount+1))
   # echo "Inside else $dest"
    cp -r $k $dest
  else
    echo "Not else"
  fi
done

}

#func /home/scripts/sdir/*
func /srv/gitlab/data/importrepo/@hashed/*
echo "Total Parent and Sub Directory count is $count"
echo "Total GITs present in them gcount is $gcount"

#chown -R git:git /home/scripts/ddir
#chown -R git:git /var/opt/gitlab/git-data/repository-import
#gitlab-rake gitlab:import:repos["/var/opt/gitlab/git-data/repository-import"]
