import {Logger} from 'winston';

declare function Shell(command: string, args: string[], options: Shell.Options): Promise<Shell.Result>;

declare namespace Shell {
  export interface Options {
    catchOutput: boolean;
    dryRun: boolean;
    logger: Logger,
    sudo: boolean;
    sudoPwd: string;
    workingDirectory: string;
  }

  export interface Result {
    code: number;
    stderr: string;
    stdout: string;
  }

  export const defaultOptions: Options;
}

export = Shell;
