# .emacs.d
```
require: ag jieba
```

## Configure
### language support
Setting `support-languages` for configure support language.

- `c-c++`: require ccls and set `ccls-executable`.[ccls](https://github.com/MaskRay/ccls)
- `python`: require [python-language-server](https://github.com/palantir/python-language-server)
  - option: `virtualenv jupyter`
- `web`: require 
  - `html`: [vscode-html-languageserver](https://github.com/vscode-langservers/vscode-html-languageserver)
  - `css`: [vscode-css-languageserver-bin](https://github.com/vscode-langservers/vscode-css-languageserver-bin)
  - `js`: [javascript-typescript-lanserver](https://github.com/sourcegraph/javascript-typescript-langserver)
- `org`: require texlive
  - option: `Noto Sans CJK SC`
