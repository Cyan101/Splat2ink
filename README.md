# Splat2ink
![Splat2Ink App](https://raw.githubusercontent.com/Cyan101/Splat2ink/master/splat2ink_preview.png)
## The goal
[Splat2.ink](https://splat2.ink) will be a backend and frontend for displaying information from the splatnet2 app, such as map rotations, ranked modes and the splatnet2 store.

Hopefully I can get this to the point where it has a nice website as well as an Android/iOS app.

## Info

Config is written in yaml, by default the port is `8080` and the default IP is `localhost`

## Use
Run the directory_setup.sh file and then bin/key_gen.rb
Install/Setup Docker
```
docker build -t my-ruby-app .
docker run -i -d -p 80:80 --name splat2ink-server my-ruby-app
```


## Tasks

- [x] Create a splatnet2 cookie to access the app
- [x] Create a backend/API for most of the splatnet2 information (and ensure it caches everything)
- [ ] Create a frontend website for this backend/api
- [~] Create an app in [flutter.io](https://flutter.io/) that uses this backend
- [x] Add a sidebar to the app to pick swap between game modes, salmon run and splatnet shop
- [ ] Add a button to the top-right to see upcoming maps/modes
- [ ] Add encoding + application type to return headers

## Personal to-do
- [ ] Setup the frontend on a server (and setup https)
- [ ] Write good code and put stuff into classes
- [ ] Move the splat2_data http req's into a function

### Sidenotes:
* Thanks to @ZekeSnider and @FrozenPandaman for their repo's and help.
* This tool makes a request to a non-nintendo server to generate a HMAC key, if you'd rather not do this you can use this [tutorial](https://github.com/Cyan101/Splat2ink/wiki/Using-mitmproxy-to-generate-a-splatnet2-cookie) to capture it from your phone.
