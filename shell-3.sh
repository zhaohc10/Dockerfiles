# to see which process is listening on which port.
lsof -i :8000
sudo netstat -peant | grep ":8000 "
