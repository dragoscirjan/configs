import {Apps, createBrewInstaller, createChocoInstaller, createScoopInstaller, createWingetInstaller} from '../lib/installer';

const vms: Apps = [
  {
    name: 'docker',
    installers: [
      createBrewInstaller(['docker', 'docker-completion', 'docker-compose']),
      createChocoInstaller(['docker']),
      createScoopInstaller(['main/docker']),
      createWingetInstaller(['Docker.DockerDesktop'])
      //
    ],
  },
  {
    name: 'qemu',
    installers: [
      createBrewInstaller(['qemu']),
      createChocoInstaller(['qemu']),
      createScoopInstaller(['main/qemu']),
      createWingetInstaller(['SoftwareFreedomConservancy.QEMU'])
      //
    ],
  },
  {
    name: 'vagrant',
    installers: [
      createBrewInstaller(['vagrant'], ['--cask']),
      createChocoInstaller(['vagrant']),
      createScoopInstaller(['main/vagrant']),
      createWingetInstaller(['Hashicorp.Vagrant'])
      //
    ],
  },
  {
    name: 'virtualbox',
    installers: [
      createBrewInstaller(['virtualbox'], ['--cask']),
      createChocoInstaller(['virtualbox']),
      // createScoopInstaller(['main/openssl']),
      createWingetInstaller(['Oracle.VirtualBox'])
      //
    ],
  },
];

export default vms;
