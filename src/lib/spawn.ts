import {ChildProcess, StdioOptions, spawn as nodeSpawn} from 'child_process';
import {platform} from 'os';
import {logger} from './logger';

export type SpawnOptions = {
  cwd?: string;
  stdio?: StdioOptions;
  pipeHooks?: (
    proc: ChildProcess,
    resolve: (value: string | void | PromiseLike<string | void>) => void,
    reject?: (reason?: any) => void,
  ) => void;
};

export const spawn = (command: string[], options: SpawnOptions = {}): Promise<void | string> => {
  logger.debug(`executing '${command.join(' ')}' with options '${JSON.stringify(options)}'`);

  return new Promise((resolve, reject) => {
    const proc = nodeSpawn(command[0], command.length > 1 ? command.slice(1) : [], {
      stdio: ['pipe', 'pipe', 'pipe'],
      ...options,
    });

    if (options.pipeHooks) {
      options.pipeHooks(proc, resolve, reject);
      return;
    }

    let stdout = '';
    let stderr = '';

    if (!options.stdio) {
      proc.stdout &&
        proc.stdout.on('data', (data) => {
          stdout += data.toString();
        });

      proc.stderr &&
        proc.stderr.on('data', (data) => {
          stderr += data.toString();
        });
    }

    proc.on('close', (code) => {
      if (code === 0) {
        if (stdout.length) {
          resolve(stdout);
        } else {
          resolve();
        }
      } else {
        logger.error(`'${command.join(' ')}' exited with code ${code}.`);
        if (stderr) {
          logger.debug(`error: ${stderr}`);
        }
        process.exit(1);
      }
    });
  });
};

export const which = async (binary: string): Promise<string> => {
  if (platform() === 'win32') {
    return spawn(['where', binary]).then((b) => (b as string).trim());
  }
  return spawn(['which', binary]).then((b) => (b as string).trim());
};

export const runPlatformInstaller = async (command: string[], soft?: boolean): Promise<void> => {
  await spawn(command, {
    stdio: ['inherit', 'pipe', 'inherit'],
    pipeHooks: (proc, resolve, reject) => {
      proc?.stdout?.pipe(process.stderr);

      proc.on('close', (code: number) => {
        if (code === 0) {
          resolve();
        } else {
          logger.error(`'${command.join(' ')}' exited with code ${code}.`);
          if (!soft) {
            logger.error('exiting');
            process.exit(code);
          }
          reject && reject(code);
        }
      });
    },
  });
};
