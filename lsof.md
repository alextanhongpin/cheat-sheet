failed to listen: listen tcp :9090: bind: address already in use

lsof -ti:5901 to find whatever is using port 5901.

Pass the whole thing to kill -9 to kill whatever was using port 5901.

lsof  -ti:9090 | xargs kill -9
