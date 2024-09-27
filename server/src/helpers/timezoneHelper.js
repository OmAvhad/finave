const moment = require('moment-timezone');

const DEFAULT_TIMEZONE = 'Asia/Kolkata';  // Change to your desired timezone

function toTimeZone(date, timezone = DEFAULT_TIMEZONE) {
    return moment(date).tz(timezone).format();
}

function getCurrentTimeInTimeZone(timezone = DEFAULT_TIMEZONE) {
    return moment().tz(timezone).format();
}

function toUTC(date) {
    return moment(date).utc().toDate();
}

module.exports = {
    toTimeZone,
    getCurrentTimeInTimeZone,
    toUTC,
};
