const base = require('../base');

module.exports = async () =>
  base([
    ['clang-13', 'clang-format-13', 'clang-tidy-13', 'llvm-13'],
    ['clang-12', 'clang-format-12', 'clang-tidy-12', 'llvm-12'],
    ['clang-11', 'clang-format-11', 'clang-tidy-11', 'llvm-11'],
    ['clang-10', 'clang-format-10', 'clang-tidy-10', 'llvm-10'],
    ['clang', 'clang-format', 'clang-tidy', 'llvm'],
  ]);
