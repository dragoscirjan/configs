import {Apps, createBrewInstaller, createChocoInstaller, createScoopInstaller, createWingetInstaller} from '../lib/installer';

const ims: Apps = [
  {
    name: 'dircord',
    installers: [
      createBrewInstaller(['discord'], ['--cask']),
      createChocoInstaller(['discord']),
      createScoopInstaller(['extras/discord']),
      createWingetInstaller(['Discord.Discord'])
    ],
  },
  {
    name: 'ferdium',
    installers: [
      createBrewInstaller(['ferdium'], ['--cask']),
      createChocoInstaller(['ferdium']),
      createScoopInstaller(['extras/ferdium']),
      createWingetInstaller(['Ferdium.Ferdium'])
    ],
  },
  {
    name: 'rocket',
    installers: [
      createBrewInstaller(['rocket-chat'], ['--cask']),
      createChocoInstaller(['rocketchat']),
      createScoopInstaller(['extras/rocketchat-client']),
      createWingetInstaller(['RocketChat.RocketChat'])
      //
    ],
  },
  {
    name: 'slack',
    installers: [
      createBrewInstaller(['slack'], ['--cask']),
      createChocoInstaller(['slack']),
      createScoopInstaller(['extras/slack']),
      createWingetInstaller(['SlackTechnologies.Slack'])
    ],
  },
  {
    name: 'teams',
    installers: [
      createBrewInstaller(['microsoft-teams'], ['--cask']),
      createChocoInstaller(['microsoft-teams']),
      createScoopInstaller(['extras/microsoft-teams']),
      createWingetInstaller(['Microsoft.Teams'])
    ],
  },
];

export default ims;
