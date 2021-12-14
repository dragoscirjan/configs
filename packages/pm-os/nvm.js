require('./src/http')([
  [
    'https://github.com/coreybutler/nvm-windows/releases',
    (body) => {
      return (
        'https://github.com/' +
        body
          .match(/<a href="([^"]+nvm-setup.zip)"/gi)
          .shift()
          .split('href=')[1]
          .slice(1, -1)
      );
    },
  ],
]);
