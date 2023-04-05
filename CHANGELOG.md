# Changelog for Redmine Legal Notes

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.2.2 - 2023-04-05

### Changed

* Copyrigh year

## 0.2.1 - 2023-01-18

### Fixed

* placeholder in .github/ISSUE_TEMPLATE
* missleading info text in plugin settings

### Changed

* copyright year

## 0.2.0 - 2023-01-05

### Added

* Redmine 5 support
* git hook scripts
* advanced_plugin_helper as required plugin
* possibility to enter links to external legal notes
* SECURITY.md
* GitHub issue templates

### Changes

* presenter registration to use the new API of advanced_plugin_helper
* README.md

### Fixes

* rubocop offenses

## 0.1.4 - 2022-04-28

### Changed

* copyright year in footer to 2022
* copyright year in each file

## 0.1.3 - 2021-07-02

### Changed

* required version of redmine_base_deface to 1.6.2 due to some incompatabilities 
  with Redmine and Rails 5.2

### Added

* missing translations (:en)

## 0.1.2 - 2021-05-30

### Changed

* loading order of deface overrides

## 0.1.1 - 2021-05-29

### Deleted

* Gemfile in favour of redmine_base_deface 1.8.1

## 0.1.0 - 2021-05-20

### Added

* optional data privacy consent on registration and user account

## 0.0.6 - 2021-04-26

### Changed

* credits year in the footer partial

## 0.0.5 - 2021-04-20

### Changed

* deface origin hash of add-legal-notes-to-footer-content

## 0.0.4 - 2021-04-08

### Changed

* loading of gem deface to be optionally
* integration test to be more stable

## 0.0.3 - 2021-03-01

### Added

* version specifier for gem deface which freezes its version to 1.6.2

## 0.0.2 - 2021-01-18

### Changed

* legal notes link rendering in the footer to be conditional

## 0.0.1 - 2020-11-21

### Added

* text areas with wiki toolbar for editing legal notes and data privacy policy
* rendering of legal notes as fullscreen pages
* links for each page below Redmine credits in the footer
