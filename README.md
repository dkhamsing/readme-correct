# readme-correct

The README correcting 🤖

`readme-correct` can open a pull request to correct a typo found in a GitHub README. The code is adapted from https://github.com/dkhamsing/cocoapods-readme :sparkles:

[![Build Status](https://travis-ci.org/dkhamsing/readme-correct.svg)](https://travis-ci.org/dkhamsing/readme-correct)

## Installation

```shell
$ git clone https://github.com/dkhamsing/readme-correct.git
$ cd readme-correct/
$ rake install
```

## Usage

Create a [`correct.yml` file](bin/correct.example.yml)

```yml
correct: Mississippi
incorrect:
  - Missisipi
  - Missisippi
  - Mississipi
pull_commit_message: Correct the spelling of Mississippi in README
pull_request_title: Correct the spelling of Mississippi in README
pull_request_description: |
  This pull request corrects the spelling of **Mississippi** 🤓
  https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/M

  Created with [`readme-correct`](https://github.com/dkhamsing/readme-correct).
```

Run `readme-correct`, it takes a GitHub repository as an argument.

```
$ readme-correct user/awesome-repo-with-typos
```

```
$ readme-correct dkarchive/Mississipi
```

:tada:

### Batch

You can even correct in batches with `batch-correct`, the input is a file with repos (one repo per line).

```
$ batch-correct list.txt
```

## Examples

- https://github.com/rnpm/rnpm/pull/94
- https://github.com/square/SocketRocket/pull/334
- https://github.com/foursquare/FSQCellManifest/pull/2

## Contact

- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
