# Drone Gotify Plugin
A very simple [Drone](https://www.drone.io) plugin to send a notification to [Gotify](https://gotify.net).

## Usage
```yaml
---
kind: pipeline
type: kubernetes
name: Patching

steps:
- name: Some Script
  image: some/plugin
- name: Gotify Notification
  image:  imoshtokill/drone-gotify-plugin
  settings:
    token:
      from_secret: gotify_token
    gotify_url: 'https://gotify.myawesomedomain.com'
    title: >
      {{#success build.status}}
        Drone Job {{build.number}} Successful
      {{else}}
        Drone Job {{build.number}} FAILED
      {{/success}}
    priority: 9
    message: >
      {{#success build.status}}
        build {{build.number}} succeeded on {{repo.name}}. Good job {{build.author}}  {{build.link}}
      {{else}}
        build {{build.number}} failed on {{repo.name}}. Fix me please {{build.author}}  {{build.link}}
      {{/success}}
  when:
    status: [ success, failure ]
```
