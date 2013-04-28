# CHANGELOG

26/4/2013
- Rails4 app setup
- 



# RESOURCES
rsync -auv deployer@pelicana.es:apps/LaPelicana/shared/system/* public/system/

If you need to keep local changes in file which tracked by #git, just do:
git update-index --skip-worktree config/database.yml

Move branch # http://stackoverflow.com/questions/1394797/move-existing-uncommited-work-to-a-new-branch-in-git
git checkout -b <new-branch>

