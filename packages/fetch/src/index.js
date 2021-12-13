if (typeof fetch === 'undefined') {
  const fetch = require('node-fetch');
}

const json = (response) => response.json();

const text = (response) => response.text();

const status = (min, max) => (response) => {
  if (typeof max === 'number') {
    if (response.status < min || response.status > max) {
      throw new Error(`Invalid status ${response.status}; required between ${min} and ${max}`);
    }
  }
  if (response.status !== min) {
    throw new Error(`Invalid status ${response.status}; expected ${min}`);
  }
};

module.exports = {fetch, json, status, text};
