const {expect} = require('chai');
const {it, describe} = require('mocha');

const {npm, pnpm, yarn} = require('../src');

//
// Uncomment for Mocha
//
describe('npm', function () {
  it('npm([], {dryRun: true}) "npm install"', function () {
    expect(npm([], {dryRun: true})).to.equal('npm install');
  });
});

//
// Uncomment for Jest
//
// describe('hello', function () {
//   it('hello("World") to return "Hello World!"', function () {
//     expect(hello('World')).toEqual('Hello World!');
//   });
// });
