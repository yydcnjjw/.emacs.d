# .emacs.d
## Requirements
- [ccls](https://github.com/MaskRay/ccls)
  ```Makefile
  git submodule update --init
  cmake -H. -Bbuild -DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_ENABLE_RTTI=on
  cmake --build build
  ```
- [intellij-lsp-server](https://github.com/Ruin0x11/intellij-lsp-server)
  ```Makefile
  ./gradlew clean buildPlugin
  ```
- `Noto Sans CJK SC`
- `hunspell`
- python package: jieba
- `ag`
- `texlive`
