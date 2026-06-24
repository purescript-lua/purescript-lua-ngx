# purescript-lua-ngx

Purescript Lua bindings for the openresty/lua-nginx-module

* [PureScript Compiler Backend for Lua](https://github.com/purescript-lua/purescript-lua)
* [NGINX API for Lua](https://github.com/openresty/lua-nginx-module#nginx-api-for-lua)

## Building

```sh
nix develop -c ./scripts/build
```

Spago compiles the PureScript to CoreFn (a no-op `backend` keeps codegen on
corefn rather than JavaScript), then pslua links each module to a flat Lua file
under `dist/`, for example `dist/Lua.Ngx.lua`.

## Running

The bindings wrap the `ngx.*` API that the lua-nginx-module injects, so they
only work inside an OpenResty worker. Plain `lua` cannot run them (`ngx` is
nil) and neither can vanilla nginx (no Lua). The dev shell ships OpenResty, and
`scripts/run` serves the compiled modules so you can curl them:

```sh
nix develop -c ./scripts/build   # produce dist/*.lua
nix develop -c ./scripts/run     # serve on http://127.0.0.1:8099
```

Then, in another terminal:

```sh
curl http://127.0.0.1:8099/say
# hello from purescript-lua-ngx

curl -i http://127.0.0.1:8099/status
# HTTP/1.1 404 Not Found
# ...
# HTTP_OK constant = 200
# ngx.status now   = 404
```

`PORT=9000 nix develop -c ./scripts/run` picks another port.

### Using the bindings from your own config

A linked module is a flat file whose name contains literal dots, such as
`Lua.Ngx.lua`, so load it with `dofile` by absolute path. `require("Lua.Ngx")`
would rewrite the dot to a directory separator and miss the file. Effectful
bindings are curried, so a `String -> Effect Unit` like `say` is called as
`say(msg)()`:

```nginx
location /hello {
  content_by_lua_block {
    local Ngx = dofile("/path/to/dist/Lua.Ngx.lua")
    Ngx.say("hello")()
  }
}
```
