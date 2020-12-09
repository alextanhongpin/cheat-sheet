# Shortcuts for Pages, MacOS

https://www.danrodney.com/mac/

- Page break: fn + command + return key (enter)


# Show all hidden files in folder

Useful for removing cached files when MacOS ran out of storage.
```bash
$ defaults write com.apple.finder AppleShowAllFiles TRUE
$ defaults write com.apple.finder AppleShowAllFiles FALSE
```


## Notifications from command line

Useful for scripts generating notification after a task has been completed (scraping etc)

```bash
## Display hello world
osascript -e 'display notification "hello world!"'


## Display notification with title
osascript -e 'display notification "hello world!" with title "This is the title"'

## Display notification with subtitle

osascript -e 'display notification "hello world!" with title "Greeting" subtitle "More text"'

## Display notification and make sound

You can see the list of sounds in system preferences sound.

osascript -e 'display notification "hello world!" with title "Greeting" subtitle "More text" sound name “Glass”’
```
