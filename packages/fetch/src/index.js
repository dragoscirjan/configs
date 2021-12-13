const fetch = (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args));

const json = (res) => res.json();

const text = (res) => res.text();

const status = (min, max) => (res) => {
  if ((typeof max === 'number' && res.status < min) || res.status > max) {
    throw new Error(`Invalid status ${res.status}; required between ${min} and ${max}`);
  }
  if (res.status !== min) {
    throw new Error(`Invalid status ${res.status}; expected ${min}`);
  }
  return res;
};

module.exports = {
  fetch,
  json,
  status,
  text,
};
