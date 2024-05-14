import {Apps, createBrewInstaller, createChocoInstaller, createScoopInstaller, createWingetInstaller} from '../lib/installer';

const office: Apps = [
  {
    name: 'libreoffice',
    installers: [
      createBrewInstaller(['libreoffice'], ['--cask']),
      createChocoInstaller(['libreoffice']),
      createScoopInstaller(['extras/libreoffice']),
      createWingetInstaller(['TheDocumentFoundation.LibreOffice'])
      //
    ],
  },
  {
    name: 'notion',
    installers: [
      createBrewInstaller(['notion'], ['--cask']),
      createChocoInstaller(['notion']),
      createScoopInstaller(['extras/notion']),
      createWingetInstaller(['Notion.Notion'])
      //
    ],
  },
  {
    name: 'openoffice',
    installers: [
      createBrewInstaller(['openoffice'], ['--cask']),
      createChocoInstaller(['openoffice']),
      createScoopInstaller(['extras/openoffice']),
      createWingetInstaller(['Apache.OpenOffice'])
      //
    ],
  },
  {
    name: 'wpsoffice',
    installers: [
      createBrewInstaller(['wpsoffice'], ['--cask']),
      createChocoInstaller(['wps-office-free']),
      createScoopInstaller(['extras/wpsoffice']),
      createWingetInstaller(['Kingsoft.WPSOffice'])
      //
    ],
  },
];

export default office;
