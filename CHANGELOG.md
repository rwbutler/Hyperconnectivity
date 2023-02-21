# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2023-02-21
### Changed
- `Configuration` objects may now be instantiated with either `URL` objects or `URLRequest` objects by using the relevant initializer.

## [1.1.1] - 2022-03-20
### Changed
- Merged [PR #4](https://github.com/rwbutler/Hyperconnectivity/pull/4) to ensure that cached results are never used as part of connectivity checks.
- Adjusted tests to pass both locally as well as on Travis CI.

## [1.1.0] - 2020-08-23
### Added
- Compatibility with macOS, watchOS and tvOS via Swift Package Manager.

## [1.0.0] - 2020-05-17
### Added
- Increased unit test coverage to 90%.

## [0.2.0] - 2020-05-08
### Added
- Support for Carthage and Swift Package Manager.

## [0.1.0] - 2020-05-08
### Added
- Initial release.
