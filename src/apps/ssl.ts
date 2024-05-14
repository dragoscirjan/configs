import {Apps, createBrewInstaller, createChocoInstaller, createScoopInstaller, createWingetInstaller} from '../lib/installer';

const office: Apps = [
  {
    name: 'libressl',
    installers: [
      createBrewInstaller(['libressl']),
      createChocoInstaller(['libressl']),
    ],
  },
  {
    name: 'openssl',
    installers: [
      createBrewInstaller(['openssl']),
      createChocoInstaller(['openssl']),
      createScoopInstaller(['main/openssl']),
      createWingetInstaller(['ShiningLight.OpenSSL'])
    ],
  },
];

export default office;
