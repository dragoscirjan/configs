const {expect} = require('chai');
const {it, describe} = require('mocha');

const {apt} = require('../../src');

//
// Uncomment for Mocha
//
describe('apt', function () {
  it('([firefox], {dryRun: true, pwd: "test"}) to return "apt install -y firefox"', async function () {
    const result = await apt(['firefox'], {dryRun: true, sudoPwd: 'test'});
    expect(result).to.equal('sh -c echo "test" | sudo -S bash -c "apt install -y -f firefox"');
  });

  it('([firefox, opera], {dryRun: true, pwd: "test"}) to return "apt install -y firefox"', async function () {
    const result = await apt(['firefox', 'opera'], {dryRun: true, sudoPwd: 'test'});
    expect(result).to.equal('sh -c echo "test" | sudo -S bash -c "apt install -y -f firefox opera"');
  });
});
