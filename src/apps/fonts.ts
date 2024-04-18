import * as decompress from 'decompress';
import { Apps, Installer } from '../lib/installer';
import { download } from '../lib/axios';
import * as copy from 'copy';
import { join as pathJoin } from 'path';
import { mkdirSync } from 'fs';
import { logger } from '../lib/logger';

const zipFile = '/tmp/font.zip';
const fontFolder = '/tmp/font';

const nixDownloadAndUnzip = async (url: string): Promise<void> => {
  logger.info(`Downloading and unzipping ${url}`);
  await download(url, zipFile);
  logger.info('Unziping...');
  await decompress(zipFile, fontFolder)
    .then((files) => files.map((file) => file.path))
    .then((files) => console.log(files));
};

const promisedCopy = (src: string, dest: string): Promise<void> => new Promise((resolve, reject) => {
  logger.info(`Copying ${src} to ${dest}`);
  copy(src, dest, (err, _files) => {
    if (err) {
      return reject(err);
    } else {
      return resolve();
    }
  })
});

const createDarwinFontInstaller = (url: string): Installer => ({
  platform: 'darwin', spawn: async (_update?: boolean) => {
    await nixDownloadAndUnzip(url);
    const darwinFontsPath = pathJoin(process.env.HOME as string, 'Library', 'Fonts');
    mkdirSync(darwinFontsPath, { recursive: true });
    await promisedCopy(pathJoin(fontFolder, '**/*.{ttf,otf}'), darwinFontsPath)
  }
});

const fonts: Apps = [
  {
    name: 'agave',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Agave.zip'),
      //
    ],
  },
  {
    name: 'dejavu',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip'),
      //
    ],
  },
  {
    name: 'fira-code',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip'),
      //
    ],
  },
  {
    name: 'hasklug',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hasklig.zip'),
      //
    ],
  },
  {
    name: 'inconsolata',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Inconsolata.zip'),
      //
    ],
  },
  {
    name: 'lekton-nerd',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lekton.zip'),
      //
    ],
  },
  {
    name: 'lilex',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lilex.zip'),
      //
    ],
  },
  {
    name: 'roboto',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip'),
      //
    ],
  },
  {
    name: 'sauce-code-pro',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/SourceCodePro.zip'),
      //
    ],
  },
  {
    name: 'ubuntu',
    installers: [
      createDarwinFontInstaller('https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip'),
      //
    ],
  },
];

export default fonts;
