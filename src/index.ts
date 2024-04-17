import {Command} from 'commander';
import browsersList from './apps/browsers';
import gitsList from './apps/gits';
import idesList from './apps/ides';
import imsList from './apps/ims';
import langsList from './apps/langs';
import {App, installMultiple} from './lib/installer';

export default function run() {
  const program = new Command();

  /** broswers */
  program
    .command('browsers')
    .description('Install browsers')
    .argument(
      '<string...>',
      `Browsers to install: ${browsersList.map((b: App) => b.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'browsers'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (browsers: string[], options: any) => {
      await installMultiple(
        browsersList.filter((item) => browsers.includes(item.name)),
        options.update,
      );
    });

  /** gits */
  program
    .command('git')
    .description('Install Git utils')
    .argument(
      '<string...>',
      `Git stuff to install: ${gitsList.map((b: App) => b.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'gits'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (gits: string[], options: any) => {
      await installMultiple(
        gitsList.filter((item) => gits.includes(item.name)),
        options.update,
      );
    });

  /** ides */
  program
    .command('ides')
    .description('Install IDEs')
    .argument(
      '<string...>',
      `IDEs to install: ${idesList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'ides'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (ides: string[], options: any) => {
      await installMultiple(
        idesList.filter((item) => ides.includes(item.name)),
        options.update,
      );
    });

  /** ims */
  program
    .command('ims')
    .description('Install Instant Messengers')
    .argument(
      '<string...>',
      `IMs to install: ${imsList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'ides'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (ims: string[], options: any) => {
      await installMultiple(
        imsList.filter((item) => ims.includes(item.name)),
        options.update,
      );
    });

  /** langs */
  program
    .command('langs')
    .description('Install Programming Languages')
    .argument(
      '<string...>',
      `Languages to install: ${langsList.map((i: App) => i.name).join(' ')}`,
      (value: string, previous: string[]) => [...(previous || []), value].filter((item) => item !== 'langs'),
    )
    .option('--update', 'Force update to the latest version')
    .action(async (langs: string[], options: any) => {
      await installMultiple(
        langsList.filter((item) => langs.includes(item.name)),
        options.update,
      );
    });

  program.parse();
}
