![Hyperconnectivity](https://github.com/rwbutler/Hyperconnectivity/raw/main/docs/images/hyperconnectivity-banner.png)

[![Build Status](https://app.travis-ci.com/rwbutler/Hyperconnectivity.svg?branch=main)](https://app.travis-ci.com/rwbutler/Hyperconnectivity)
[![Version](https://img.shields.io/cocoapods/v/Hyperconnectivity.svg?style=flat)](http://cocoapods.org/pods/Hyperconnectivity)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Connectivity.svg?style=flat)](http://cocoapods.org/pods/Connectivity)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frwbutler%2FHyperconnectivity%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/rwbutler/Hyperconnectivity)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frwbutler%2FHyperconnectivity%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/rwbutler/Hyperconnectivity)
[![Twitter](https://img.shields.io/badge/twitter-@ross_w_butler-blue.svg?style=flat)](https://twitter.com/ross_w_butler)

Hyperconnectivity is a modern replacement for Reachability written fully in Swift and using Apple's [Combine](https://developer.apple.com/documentation/combine) framework. It offers the ability to detect reachability, Internet connectivity as well the presence of [captive portals](https://en.wikipedia.org/wiki/Captive_portal). It is an offshoot of the [Connectivity](https://github.com/rwbutler/Connectivity) project which offers similar features. To find out which one is right for you, take a look at the [Connectivity vs Hyperconnectivity](#connectivity-vs-hyperconnectivity) section below for a comparison.

- [Features](#features)
- [Quickstart](#quickstart)
- [Connectivity vs Hyperconnectivity](#connectivity-vs-hyperconnectivity)
- [Installation](#installation)
	- [Cocoapods](#cocoapods)
	- [Carthage](#carthage)
	- [Swift Package Manager](#swift-package-manager)
- [How It Works](#how-it-works)
- [Usage](#usage)
- [FAQs](#faqs)
- [Known Issues](#known-issues)
- [Author](#author)
- [License](#license)
- [Additional Software](#additional-software)
	- [Frameworks](#frameworks)
	- [Tools](#tools)

## Features

- [x] Determines whether Internet connectivity is available and provides notification of changes.
- [x] Support for Combine [Publishers](https://developer.apple.com/documentation/combine/publisher).
- [x] Detects Captive Portals when the device joins a network.
- [x] Detects when connected to a hotspot or router without Internet access.

## Quickstart

Getting started is as simple as subscribing to the provided publisher as follows:

```swift
cancellable = Hyperconnectivity.Publisher()
	.receive(on: DispatchQueue.main)
	.eraseToAnyPublisher()
	.sink(receiveCompletion: { [weak self] _ in
		self?.updateUIWhenComplete()
	}, receiveValue: { [weak self] connectivityResult in
		self?.updateUI(with: connectivityResult)
	})
```

For a full example, see the example [`UIViewController`](https://github.com/rwbutler/Hyperconnectivity/blob/main/Example/Hyperconnectivity/ViewController.swift) in the sample app.

## Connectivity vs Hyperconnectivity

Hyperconnectivity is an offshoot of the Connectivity framework so why would you choose Hyperconnectivity over Connectivity? 

### TL;DR

With iOS 14 just around the corner, Hyperconnectivity drops the Objective-C interoperability and support for older versions of iOS provided by Connectivity in order to provide a cleaner, more elegant interface in Swift for those apps who need only support iOS 13 an above. 

Connectivity was designed to provide a familiar API to users of Apple's Reachability which was written in Obj-C and whose designed was heavily influenced by that language. With many recent advancements in the Swift language and introduction of the Network and Combine frameworks in iOS 12 and 13 respectively it felt as though there was an opportunity to provide a 'Swiftier' and more reactive interface at the cost of sacrificing Obj-C compatibility and support for older versions of iOS.

### Feature Comparison

The table below will be updated as future releases of Hyperconnectivity bring the framework towards feature parity with Connectivity.

<div align="center">
    <img src="https://github.com/rwbutler/Hyperconnectivity/raw/main/docs/images/comparison-with-connectivity.png" alt="Comparison with Connectivity Table" width="80%">
</div>

## Installation

Hyperconnectivity is compatible with Cocoapods, Carthage and Swift Package Manager. For installation instructions take a look at the relevant section below.

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager which integrates dependencies into your Xcode workspace. To install it using [Ruby gems](https://rubygems.org/) run:

```bash
gem install cocoapods
```

To install Hyperconnectivity using Cocoapods, simply add the following line to your Podfile:

```ruby
pod "Hyperconnectivity"
```

Then run the command:

```ruby
pod install
```

For more information [see here](https://cocoapods.org/#getstarted).

### Carthage

Carthage is a dependency manager which produces a binary for manual integration into your project. It can be installed via [Homebrew](https://brew.sh/) using the commands:

```bash
brew update
brew install carthage
```

In order to integrate Hyperconnectivity into your project via Carthage, add the following line to your project's Cartfile:

```ogdl
github "rwbutler/Hyperconnectivity"
```

From the macOS Terminal run `carthage update --platform iOS` to build the framework then drag `Hyperconnectivity.framework` into your Xcode project.

For more information [see here](https://github.com/Carthage/Carthage#quick-start).

### Swift Package Manager

Xcode 11 includes support for [Swift Package Manager](https://swift.org/package-manager/). In order to add Hyperconnectivity to your project in Xcode 11, from the `File` menu select `Swift Packages` and then select `Add Package Dependency`.

A dialogue will request the package repository URL which is:

```
https://github.com/rwbutler/hyperconnectivity
```

After verifying the URL, Xcode will prompt you to select whether to pull a specific branch, commit or versioned release into your project. 

<div align="center">
    <img src="https://github.com/rwbutler/Connectivity/raw/main/docs/images/package-options.png" alt="Xcode 11 Package Options" width="80%">
</div>

Proceed to the next step by where you will be asked to select the package product to integrate into a target. There will be a single package product named `Hyperconnectivity` which should be pre-selected. Ensure that your main app target is selected from the rightmost column of the dialog then click Finish to complete the integration.

<div align="center">
    <img src="https://github.com/rwbutler/Connectivity/raw/main/docs/images/add-package.png" alt="Xcode 11 Add Package" width="80%">
</div>

## How It Works

iOS adopts a protocol called Wireless Internet Service Provider roaming ([WISPr 2.0](https://www.wballiance.com/glossary/)) published by the [Wireless Broadband Alliance](https://www.wballiance.com/). This protocol defines the Smart Client to Access Gateway interface describing how to authenticate users accessing public IEEE 802.11 (Wi-Fi) networks using the [Universal Access Method](https://en.wikipedia.org/wiki/Universal_access_method) in which a captive portal presents a login page to the user. 

The user must then register or provide login credentials via a web browser in order to be granted access to the network using [RADIUS](https://www.cisco.com/c/en/us/support/docs/security-vpn/remote-authentication-dial-user-service-radius/12433-32.html) or another protocol providing centralized Authentication, Authorization, and Accounting ([AAA](https://en.wikipedia.org/wiki/AAA_(computer_security))).

In order to detect a that it has connected to a Wi-Fi network with a captive portal, iOS contacts a number of endpoints hosted by Apple - an example being [https://www.apple.com/library/test/success.html](https://www.apple.com/library/test/success.html). Each endpoint hosts a small HTML page of the form:

```html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
	<TITLE>Success</TITLE>
</HEAD>
<BODY>
	Success
</BODY>
</HTML>

```

If on downloading this small HTML page iOS finds that it contains the word `Success` as above then it knows that Internet connectivity is available. However, if a login page is presented by a captive portal then the word `Success` will not be present and iOS will realize that the network connection has been hijacked by a captive portal and will present a browser window allowing the user to login or register.

Apple hosts a number of these pages such that should one of these pages go down, a number of fallbacks can be checked to determine whether connectivity is present or whether our connection is blocked by the presence of a captive portal. Unfortunately iOS exposes no framework to developers which allows us to make use of the operating system’s awareness of captive portals.

Hyperconnectivity is an open-source framework which  endeavours to replicate iOS’s means of detecting captive portals. When NWPathMonitor detects Wi-Fi or WWAN connectivity, Hyperconnectivity contacts a number of endpoints to determine whether true Internet connectivity is present or whether a captive portal is intercepting the connections. This approach can also be used to determine whether an iOS device is connected to a Wi-Fi router with no Internet access. 

Hyperconnectivity provides a Combine [Publisher](https://developer.apple.com/documentation/combine/publisher) for providing notifications of changing Internet connectivity state therefore getting up to speed with the framework should be straightforward for anyone with prior experience of working with Combine publishers.

By default, Hyperconnectivity contacts a number of endpoints already used by iOS but it is recommended that these are replaced by endpoints hosted by the developer by setting the `connectivityURLs` property of the `Hyperconnectivity.Configuration` object. Further customization is possible through setting the `successThreshold` property of this object which determines the percentage of endpoints contacted which must result in a successful check in order to conclude that connectivity is present. The default value specifies that 50% of URLs contacted must result in a successful connectivity check.

## Usage

For an example of how to use Hyperconnectivity, see the sample app in the [Example](./Example) directory. The provided example [`UIViewController`](https://github.com/rwbutler/Hyperconnectivity/blob/main/Example/Hyperconnectivity/ViewController.swift) illustrates how the publisher can be used to update your UI.

## FAQs

### Does the release of Hyperconnectivity mean that Connectivity will no longer be supported going forwards?

No, both Connectivity and Hyperconnectivity will be supported in future with improvements in each framework being symbiotic leading to improvement in the other.

## Known Issues

### Caller responsible for retaining the `AnyCancellable` object

Please ensure that any implementation making use of this framework holds a strong reference to the `AnyCancellable` object returned when subscribing to the publisher. If this object is not retained then any Internet connectivity checks will be cancelled prematurely.

### Simulator issues

Before reporting a bug please ensure that you have tested on a physical device as on simulator changes in network adapter state are not reported correctly by iOS frameworks particularly when transitioning from a disconnected -> connected state. This behaviour functions correctly on a physical device.

## Author

[Ross Butler](https://github.com/rwbutler)

## License

Hyperconnectivity is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.

## Additional Software

### Controls

* [AnimatedGradientView](https://github.com/rwbutler/AnimatedGradientView) - Powerful gradient animations made simple for iOS.

|[AnimatedGradientView](https://github.com/rwbutler/AnimatedGradientView) |
|:-------------------------:|
|[![AnimatedGradientView](https://raw.githubusercontent.com/rwbutler/AnimatedGradientView/master/docs/images/animated-gradient-view-logo.png)](https://github.com/rwbutler/AnimatedGradientView) 

### Frameworks

* [Cheats](https://github.com/rwbutler/Cheats) - Retro cheat codes for modern iOS apps.
* [Connectivity](https://github.com/rwbutler/Connectivity) - Improves on Reachability for determining Internet connectivity in your iOS application.
* [FeatureFlags](https://github.com/rwbutler/FeatureFlags) - Allows developers to configure feature flags, run multiple A/B or MVT tests using a bundled / remotely-hosted JSON configuration file.
* [FlexibleRowHeightGridLayout](https://github.com/rwbutler/FlexibleRowHeightGridLayout) - A UICollectionView grid layout designed to support Dynamic Type by allowing the height of each row to size to fit content.
* [Hyperconnectivity](https://github.com/rwbutler/Hyperconnectivity) - Modern replacement for Apple's Reachability written in Swift and made elegant using Combine. An offshoot of the [Connectivity](https://github.com/rwbutler/Connectivity) framework.
* [Skylark](https://github.com/rwbutler/Skylark) - Fully Swift BDD testing framework for writing Cucumber scenarios using Gherkin syntax.
* [TailorSwift](https://github.com/rwbutler/TailorSwift) - A collection of useful Swift Core Library / Foundation framework extensions.
* [TypographyKit](https://github.com/rwbutler/TypographyKit) - Consistent & accessible visual styling on iOS with Dynamic Type support.
* [Updates](https://github.com/rwbutler/Updates) - Automatically detects app updates and gently prompts users to update.

|[Cheats](https://github.com/rwbutler/Cheats) |[Connectivity](https://github.com/rwbutler/Connectivity) | [FeatureFlags](https://github.com/rwbutler/FeatureFlags) | [Hyperconnectivity](https://github.com/rwbutler/Hyperconnectivity) | [Skylark](https://github.com/rwbutler/Skylark) | [TypographyKit](https://github.com/rwbutler/TypographyKit) | [Updates](https://github.com/rwbutler/Updates) |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
|[![Cheats](https://raw.githubusercontent.com/rwbutler/Cheats/master/docs/images/cheats-logo.png)](https://github.com/rwbutler/Cheats) |[![Connectivity](https://github.com/rwbutler/Connectivity/raw/master/ConnectivityLogo.png)](https://github.com/rwbutler/Connectivity) | [![FeatureFlags](https://raw.githubusercontent.com/rwbutler/FeatureFlags/master/docs/images/feature-flags-logo.png)](https://github.com/rwbutler/FeatureFlags) | [![Hyperconnectivity](https://raw.githubusercontent.com/rwbutler/Hyperconnectivity/main/docs/images/hyperconnectivity-logo.png)](https://github.com/rwbutler/Hyperconnectivity) | [![Skylark](https://github.com/rwbutler/Skylark/raw/master/SkylarkLogo.png)](https://github.com/rwbutler/Skylark) | [![TypographyKit](https://raw.githubusercontent.com/rwbutler/TypographyKit/master/docs/images/typography-kit-logo.png)](https://github.com/rwbutler/TypographyKit) | [![Updates](https://raw.githubusercontent.com/rwbutler/Updates/master/docs/images/updates-logo.png)](https://github.com/rwbutler/Updates)

### Tools

* [Clear DerivedData](https://github.com/rwbutler/ClearDerivedData) - Utility to quickly clear your DerivedData directory simply by typing `cdd` from the Terminal.
* [Config Validator](https://github.com/rwbutler/ConfigValidator) - Config Validator validates & uploads your configuration files and cache clears your CDN as part of your CI process.
* [IPA Uploader](https://github.com/rwbutler/IPAUploader) - Uploads your apps to TestFlight & App Store.
* [Palette](https://github.com/rwbutler/TypographyKitPalette) - Makes your [TypographyKit](https://github.com/rwbutler/TypographyKit) color palette available in Xcode Interface Builder.

|[Config Validator](https://github.com/rwbutler/ConfigValidator) | [IPA Uploader](https://github.com/rwbutler/IPAUploader) | [Palette](https://github.com/rwbutler/TypographyKitPalette)|
|:-------------------------:|:-------------------------:|:-------------------------:|
|[![Config Validator](https://raw.githubusercontent.com/rwbutler/ConfigValidator/master/docs/images/config-validator-logo.png)](https://github.com/rwbutler/ConfigValidator) | [![IPA Uploader](https://raw.githubusercontent.com/rwbutler/IPAUploader/master/docs/images/ipa-uploader-logo.png)](https://github.com/rwbutler/IPAUploader) | [![Palette](https://raw.githubusercontent.com/rwbutler/TypographyKitPalette/master/docs/images/typography-kit-palette-logo.png)](https://github.com/rwbutler/TypographyKitPalette)


