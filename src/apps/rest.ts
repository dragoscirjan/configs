import {Apps, createBrewInstaller, createChocoInstaller, createScoopInstaller, createWingetInstaller} from '../lib/installer';

const office: Apps = [
  {
    name: 'insomnia',
    installers: [
      createBrewInstaller(['insomnia'], ['--cask']),
      createChocoInstaller(['insomnia']),
      createScoopInstaller(['extras/insomnia']),
      createWingetInstaller(['Insomnia.Insomnia'])
      //
    ],
  },
  {
    name: 'postman',
    installers: [
      createBrewInstaller(['postman'], ['--cask']),
      createChocoInstaller(['postman']),
      createScoopInstaller(['extras/postman']),
      createWingetInstaller(['Postman.Postman'])
      //
    ],
  },
];

export default office;
