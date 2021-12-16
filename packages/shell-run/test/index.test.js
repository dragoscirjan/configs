const {expect} = require('chai');
const {it, describe} = require('mocha');

const sr = require('../src');

describe('shell-run', function () {
  it('(ls, [-la, .], {dryRun: true}) to return command', async function () {
    const result = await sr('ls', ['-la', '.'], {dryRun: true});
    expect(result).to.equal('ls -la .');
  });

  it('(ls, [-la, .], {dryRun: true, sudo: true, sudoPwd: "test"}) to return a string', async function () {
    const result = await sr('ls', ['-la', '.'], {dryRun: true, sudo: true, sudoPwd: 'test'});
    expect(result).to.equal('sh -c echo "test" | sudo -S bash -c "ls -la ."');
  });

  it('(ls, [-la, .], {catchOutput: true}) to return a string', async function () {
    const {code, stderr, stdout} = await sr('ls', ['-la', '.'], {catchOutput: true});
    expect(code).to.equal(0);
    expect(stderr).to.equal('');
    expect(stdout.includes('.editorconfig')).to.equal(true);
  });
});
