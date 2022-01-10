import Shell from '@dragoscirjan/configs-shell-run';

declare namespace Lang {}
declare namespace Lang.Node {
  export interface Options extends Shell.Options {
    useNvm: boolean;
    version: string;
  }
}

export = Lang;
