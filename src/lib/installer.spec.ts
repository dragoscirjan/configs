/* eslint-disable max-lines-per-function */
import {App, createAptInstaller, installSingle} from './installer';
import * as spawn_module from './spawn';
import browsers from '../apps/browsers';

jest.mock('./spawn', () => ({
  spawn: jest.fn(),
  which: jest.fn((value) => value),
}));

describe('spawn', () => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let nodeSpawnSpy: any;

  beforeAll(() => {
    // Spy on console.log and provide a mock implementation
    nodeSpawnSpy = jest.spyOn(spawn_module, 'spawn').mockImplementation();
  });

  afterEach(() => {
    // Clear mock call history after each test
    nodeSpawnSpy.mockClear();
  });

  afterAll(() => {
    // Restore console.log to its original implementation after all tests
    nodeSpawnSpy.mockRestore();
  });

  it('createAptInstaller(["firefox"])() to call spawn()', async () => {
    const {spawn} = createAptInstaller(['firefox']);
    await spawn();
    expect(spawn_module.spawn).toHaveBeenCalled();
    expect(spawn_module.spawn).toHaveBeenCalledWith(['sudo', 'apt', 'install', '-yf', 'firefox'], {stdio: 'inherit'});
  });

  it('createAptInstaller(["firefox"])(true) to call spawn()', async () => {
    const {spawn} = createAptInstaller(['firefox']);
    await spawn(true);

    expect(spawn_module.spawn).toHaveBeenCalled();
    expect(spawn_module.spawn).toHaveBeenCalledWith(['sudo', 'apt', 'install', '--only-upgrade', '-yf', 'firefox'], {
      stdio: 'inherit',
    });
  });

  it('install() to call spawn()', async () => {
    const firefox = browsers.find((browser) => browser.name === 'firefox') as App;

    await installSingle(firefox);

    expect(spawn_module.spawn).toHaveBeenCalled();
    expect(spawn_module.spawn).toHaveBeenCalledWith(
      expect.arrayContaining(['firefox']),
      expect.objectContaining({
        stdio: 'inherit',
      }),
    );
  });

  it('dummy', () => {
    expect(true).toBe(true);
  });
});
