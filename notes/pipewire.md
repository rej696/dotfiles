
## Power management of radio devices
https://linrunner.de/tlp/settings/rdw.html

## Setting default profile for audio device
- https://unix.stackexchange.com/questions/753211/how-to-set-audio-device-profile-and-route-with-pipewire-directly

```
pw-cli ls Device
pw-cli e <card-id> EnumProfile
pw-cli s <card-id> Profile '{ index: <profile-index>, save: true }'
```



