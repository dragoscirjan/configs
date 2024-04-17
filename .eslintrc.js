// .eslintrc.js

module.exports = {
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": 2020,
    "sourceType": "module"
  },
  "env": {
    "browser": true,
    "es6": true,
    "node": true,
    "mocha": true
  },
  "extends": [
    "plugin:@typescript-eslint/recommended",
    "plugin:sonar/recommended",
    "plugin:sonarjs/recommended",
    "prettier",
    "plugin:jest/recommended"
  ],
  "plugins": [
    "@typescript-eslint",
    "prettier",
    "sonar",
    "sonarjs"
  ],
  "root": true,
  "rules": {
    "@typescript-eslint/object-curly-spacing": "off",
    "@typescript-eslint/space-infix-ops": "off",
    "consistent-return": 2,
    "max-len": [
      "error",
      120
    ],
    "max-lines-per-function": [
      "error",
      20
    ],
    "max-params": [
      "error",
      3
    ],
    "no-else-return": 1,
    "sonar/no-invalid-await": 0,
    "space-unary-ops": 2,
    "curly": [
      "error",
      "all"
    ],
    "indent": [
      1,
      2
    ],
    "semi": [
      1,
      "always"
    ]
  }
};