# Drone Gotify Plugin
A very simple [Drone](https://www.drone.io) plugin to send a notification to [Gotify](https://gotify.net).

## Notes
I recommend having different steps for success/failure, as the plugin does not seem to be aware of the previous step, so DRONE_BUILD_STATUS seems to always be "success"?

## Usage
```yaml
---
kind: pipeline
type: kubernetes
name: Patching

steps:
- name: Some Script
  image: some/plugin
- name: Gotify Success Notification
  image:  imoshtokill/drone-gotify-plugin:v1
  settings:
    token:
      from_secret: gotify_token
    gotify_url: 'https://gotify.myawesomedomain.com'
    # title is optional, defaults to:
    # ${DRONE_REPO_NAME}:${DRONE_BUILD_NUMBER} ${DRONE_BUILD_STATUS}
    title: Some title here
    # priority is optional, defaults to 5
    priority: 9
    # message is optional, defaults to:
    #Build ${DRONE_BUILD_NUMBER} of ${DRONE_REPO}: (${DRONE_COMMIT_MESSAGE}): ${DRONE_BUILD_LINK}
    message: Some message
  when:
    status: [ success ]
- name: Gotify Failure Notification
  image:  imoshtokill/drone-gotify-plugin:v1
  settings:
    token:
      from_secret: gotify_token
    gotify_url: 'https://gotify.myawesomedomain.com'
    # title is optional, defaults to:
    # ${DRONE_REPO_NAME}:${DRONE_BUILD_NUMBER} ${DRONE_BUILD_STATUS}
    title: Ruh Row!
    # priority is optional, defaults to 5
    priority: 9
    # message is optional, defaults to:
    #Build ${DRONE_BUILD_NUMBER} of ${DRONE_REPO}: (${DRONE_COMMIT_MESSAGE}): ${DRONE_BUILD_LINK}
    message: We messed up!
  when:
    status: [ failure ]
```
