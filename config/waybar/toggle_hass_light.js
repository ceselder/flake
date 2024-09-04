const HomeAssistant = require('homeassistant');
const hass = new HomeAssistant({
    host: 'https://homeassistant.celestje.ovh',
    port: 443,
    token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhNzc3YTY1OGEyNzg0ZjgxODc2MjVmZjFkYmZkNzcyYiIsImlhdCI6MTY2NDUzOTIwOSwiZXhwIjoxOTc5ODk5MjA5fQ.yG4AN4N0j7vLzIuNOqU_VD-sjush6ogDM4TrawcvJ-s',
    ignoreCert: false
});

hass.services.call('toggle', 'light', process.argv[2]);