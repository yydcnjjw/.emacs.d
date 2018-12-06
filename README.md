# .emacs.d
## Configure
### language support
Setting `support-languages` for configure support language.
- conf-c-c++: require ccls and set `ccls-executable`
  - [ccls](https://github.com/MaskRay/ccls)
  ```Makefile
  git submodule update --init
  cmake -H. -Bbuild -DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_ENABLE_RTTI=on
  cmake --build build
  ```
- conf-python: require [python-language-server](https://github.com/palantir/python-language-server)
  `pip install 'python-language-server[all]'`
  - option: `virtualenv jupyter`
- conf-org: require texlive

- `Noto Sans CJK SC`
- `hunspell`
- python package: jieba
- `ag`
-
- [intellij-lsp-server](https://github.com/Ruin0x11/intellij-lsp-server)
  ```Makefile
  ./gradlew clean buildPlugin
  ```
