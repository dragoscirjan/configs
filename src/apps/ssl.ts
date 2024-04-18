import {Apps, createBrewInstaller} from '../lib/installer';

const office: Apps = [
  {
    name: 'libressl',
    installers: [
      createBrewInstaller(['libressl']),
      //
    ],
  },
  {
    name: 'openssl',
    installers: [
      createBrewInstaller(['openssl']),
      //
    ],
  },
];

export default office;
