# lighthouse – first meaningful paint time script

this script helps to test _n_ url's at once to log the first meaningful paint time.

## how to?

**node v6+ is required to run lighthouse. install via homebrew or your package manager.**

- install lighthouse via npm or yarn
`npm install -g lighthouse` | `yarn global add lighthouse`

- clone this repo locally

- run script with n url's as parameters: `./lighthouse_script.sh url_1 url_2 …` e.g. `./lighthouse_script.sh https://www.google.de https://github.com`
- you will be informed when everything is finished and can check the "results.txt" for the results

### mobile tests @android

- follow [instructions](https://github.com/GoogleChrome/lighthouse#testing-on-a-mobile-device) and set up your device
- run the script as instructed above 