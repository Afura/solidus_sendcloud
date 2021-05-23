# Solidus Sendcloud

<!-- Replace REPO_ORG and uncomment the following to show badges for CI and coverage. -->

<!--
[![CircleCI](https://circleci.com/gh/REPO_ORG/solidus_sendcloud.svg?style=shield)](https://circleci.com/gh/REPO_ORG/solidus_sendcloud)
[![codecov](https://codecov.io/gh/REPO_ORG/solidus_sendcloud/branch/master/graph/badge.svg)](https://codecov.io/gh/REPO_ORG/solidus_sendcloud)
-->

[Explain what your extension does.]

## Installation

Add solidus_sendcloud to your Gemfile:

```ruby
gem 'solidus_sendcloud'
```

Bundle your dependencies and run the installation generator:

```shell
bin/rails generate solidus_sendcloud:install
```

## Usage

[Explain how to use your extension once it's been installed.]

## Development

### Testing the extension

First bundle your dependencies, then run `bin/rake`. `bin/rake` will default to building the dummy
app if it does not exist, then it will run specs. The dummy app can be regenerated by using
`bin/rake extension:test_app`.

```shell
bin/rake
```

To run [Rubocop](https://github.com/bbatsov/rubocop) static code analysis run

```shell
bundle exec rubocop
```

When testing your application's integration with this extension you may use its factories.
Simply add this require statement to your spec_helper:

```ruby
require 'solidus_sendcloud/factories'
```

### Running the sandbox

To run this extension in a sandboxed Solidus application, you can run `bin/sandbox`. The path for
the sandbox app is `./sandbox` and `bin/rails` will forward any Rails commands to
`sandbox/bin/rails`.

Here's an example:

```
$ bin/rails server
=> Booting Puma
=> Rails 6.0.2.1 application starting in development
* Listening on tcp://127.0.0.1:3000
Use Ctrl-C to stop
```

### Updating the changelog

Before and after releases the changelog should be updated to reflect the up-to-date status of
the project:

```shell
bin/rake changelog
git add CHANGELOG.md
git commit -m "Update the changelog"
```

### Releasing new versions

Your new extension version can be released using `gem-release` like this:

```shell
bundle exec gem bump -v 1.6.0
bin/rake changelog
git commit -a --amend
git push
bundle exec gem release
```

## License

Copyright (c) 2021 [name of extension author], released under the New BSD License.
