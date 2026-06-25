### Added

- `scripts/run`: an OpenResty demo runner that serves the compiled dist under
  `content_by_lua`.

### Changed

- Migrated to the new spago (`spago.yaml` + the published Lua package set) and
  fixed the push-CI trigger so it runs on `main`.
