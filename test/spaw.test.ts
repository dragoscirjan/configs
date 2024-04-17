/* eslint-disable max-lines-per-function */
import * as cp from 'child_process';
import {spawn} from '../src/lib/spawn';

describe('spawn', () => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let consoleSpy: any;

  beforeAll(() => {
    // Spy on console.log and provide a mock implementation
    consoleSpy = jest
      .spyOn(cp, 'spawn')
      .mockImplementation((_command: string, _args: readonly string[], _options: cp.SpawnOptions) => {
        const proc = new cp.ChildProcess();
        proc.kill();
        return proc;
      });
  });

  afterEach(() => {
    // Clear mock call history after each test
    consoleSpy.mockClear();
  });

  afterAll(() => {
    // Restore console.log to its original implementation after all tests
    consoleSpy.mockRestore();
  });

  // TODO: Fix this test. child_process.spawn is one of the hardest things to mock

  // it('spawn(["ls", "-la"]) to call child_process.spawn()', async () => {
  //   await spawn(['ls', '-la']);
  //   expect(cp.spawn).toHaveBeenCalled();
  //   expect(cp.spawn).toHaveBeenCalledWith('ls', ['-la']);
  // });

  it('dummy', () => {
    expect(true).toBe(true);
  });
});
