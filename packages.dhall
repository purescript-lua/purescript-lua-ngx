let upstream-ps =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.15-20240320/packages.dhall
        sha256:ae8a25645e81ff979beb397a21e5d272fae7c9ebdb021a96b1b431388c8f3c34

let upstream-lua =
      https://github.com/purescript-lua/purescript-lua-package-sets/releases/download/psc-0.15.15-20240337/packages.dhall
        sha256:1bbe483b76cd20cdbb77eb202013f96047093281559b7a319cae443ae0eba453

in  upstream-ps // upstream-lua
