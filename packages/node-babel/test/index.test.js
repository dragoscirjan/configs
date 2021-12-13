import {expect} from 'chai';
import {describe, it} from 'mocha';

import {hello} from '../src';

//
// Uncomment for Mocha
//
describe('hello', function () {
  it('hello("World") to return "Hello World!"', function () {
    expect(hello('World')).to.equal('Hello World!');
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
