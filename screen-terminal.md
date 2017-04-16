
## Create a new screen
screen

## Create a new screen with the name "Service"
screen -S Service

## Detach a screen
Ctrl + a + d (MacOS)

## List all screens
screen -ls

## Close the screen with the name "Service"
screen -X -S Service quit

## Close a screen with the id 38894

```
There is a screen on:
	38894.ttys000.Alexs-MacBook-Pro	(Detached)
1 Socket in /var/folders/7m/74_ct3hx33d878n626w1wxyc0000gn/T/.screen.

screen -S 38894 -X quit

screen -ls 
No Sockets found in /var/folders/7m/74_ct3hx33d878n626w1wxyc0000gn/T/.screen.
```

