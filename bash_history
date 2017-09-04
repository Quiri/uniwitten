mkdir uniwitten
ls
cd uniwitten/
clear
ls
R
tmux
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
R
sqlite3 ~/Downloads/chinook.db
sudo apt-get install sqlite
cd ~/Downloads/
unzip chinook.zip 
sqlite3 chinook.db
sudo apt-get update
sudo apt-get install r-base
R
sqlite3 chinook.db
ls
git init
git status
git add tidy1.Rhistory
git status
git commit -m "first Rhistory added"
vim tidy1.Rhistory 
git status
git add tidy1.Rhistory 
vim README
git status
git add README 
git status
git commit -m "cleaned history, added README"
git log
git diff 000d 4b71
git remote add origin git@github.com:Quiri/uniwitten.git
git push
git push origin master
cd ..
git clone git@github.com:Quiri/uniwitten.git uw2
cd uw2
ls
cd ../uniwitten/
cp ../takomat/datascience/chinook.R .
ls
git add chinook.R 
git commit -m "chinook sample analysis"
git push
git push --set-upstream origin master
ssh-keygen 
cd ~/.ssh/
cat id_rsa
cat id_rsa.pub
