const {expect} = require('chai');
const {it, describe} = require('mocha');

const base = require('../src/base');

//
// Uncomment for Mocha
//
describe('base', function () {
  it('base(ls, [-la, .], {dryRun: true}) to return "ls -la ."', async function () {
    const result = await base('ls', ['-la', '.'], {dryRun: true});
    expect(result).to.equal('ls -la .');
  });
});
