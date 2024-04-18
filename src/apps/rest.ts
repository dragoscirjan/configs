import {Apps, createBrewInstaller} from '../lib/installer';

const office: Apps = [
  {
    name: 'insomnia',
    installers: [
      createBrewInstaller(['insomnia'], ['--cask']),
      //
    ],
  },
  {
    name: 'postman',
    installers: [
      createBrewInstaller(['postman'], ['--cask']),
      //
    ],
  },
];

export default office;
