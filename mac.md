# Connecting to mac os localhost 

Go to system preferences > Sharing and configure the computer name.

Then, you can access your macbooks localhost using `<name>.local`.

Note that if you are running apps on docker, you need to expose the app under host `0.0.0.0` in order for it to work.
