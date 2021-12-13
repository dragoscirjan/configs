const {expect} = require('chai');
const {it, describe} = require('mocha');

const {npm, pnpm, yarn} = require('../src');

describe('npm', function () {
  it('([], {dryRun: true}) to return: npm install', async function () {
    const result = await npm([], {dryRun: true});
    expect(result).to.equal('npm install');
  });

  it('(["uuid@latest"], {dryRun: true}) to return: npm install uuid@latest', async function () {
    const result = await npm(['uuid@latest'], {dryRun: true});
    expect(result).to.equal('npm install uuid@latest');
  });

  it('(["uuid@latest"], {dryRun: true, args: ["-S"]}) to return: npm install -S uuid@latest', async function () {
    const result = await npm(['uuid@latest'], {dryRun: true, args: ['-S']});
    expect(result).to.equal('npm install -S uuid@latest');
  });

  it('(["uuid"], {dryRun: true}) to return: npm install uuid@^?(d+.?)+', async function () {
    const result = await npm(['uuid'], {dryRun: true});
    expect(result).to.match(/npm install uuid@\^?(\d+\.?)+/);
  });
});

describe('pnpm', function () {
  it('([], {dryRun: true}) to return: pnpm install', async function () {
    const result = await pnpm([], {dryRun: true});
    expect(result).to.equal('pnpm install');
  });

  it('(["uuid@latest"], {dryRun: true}) to return: pnpm add uuid@latest', async function () {
    const result = await pnpm(['uuid@latest'], {dryRun: true});
    expect(result).to.equal('pnpm add uuid@latest');
  });

  it('(["uuid@latest"], {dryRun: true, args: ["--dev"]}) to return: pnpm add --dev uuid@latest', async function () {
    const result = await pnpm(['uuid@latest'], {dryRun: true, args: ['--dev']});
    expect(result).to.equal('pnpm add --dev uuid@latest');
  });

  it('(["uuid"], {dryRun: true}) to return: pnpm add uuid@^?(d+.?)+', async function () {
    const result = await pnpm(['uuid'], {dryRun: true});
    expect(result).to.match(/pnpm add uuid@\^?(\d+\.?)+/);
  });
});

describe('yarn', function () {
  it('([], {dryRun: true}) to return: yarn install', async function () {
    const result = await yarn([], {dryRun: true});
    expect(result).to.equal('yarn install');
  });

  it('(["uuid@latest"], {dryRun: true}) to return: yarn add uuid@latest', async function () {
    const result = await yarn(['uuid@latest'], {dryRun: true});
    expect(result).to.equal('yarn add uuid@latest');
  });

  it('(["uuid@latest"], {dryRun: true, args: ["--dev"]}) to return: yarn add --dev uuid@latest', async function () {
    const result = await yarn(['uuid@latest'], {dryRun: true, args: ['--dev']});
    expect(result).to.equal('yarn add --dev uuid@latest');
  });

  it('(["uuid"], {dryRun: true}) to return: yarn add uuid@^?(d+.?)+', async function () {
    const result = await yarn(['uuid'], {dryRun: true});
    expect(result).to.match(/yarn add uuid@\^?(\d+\.?)+/);
  });
});
