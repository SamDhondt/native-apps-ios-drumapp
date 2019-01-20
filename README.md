# Click - a drumapp
This is an iOS app written in Swift for the course Native Apps II: iOS at University College Ghent. With the app you can use a metronome and browse drum rudiments

## Data
Metronome data is stored locally. Rudiments are retrieved from a web api and stored locally. Comments on rudiments are retrieved from a web api. No personal data is stored or used.

## Used libraries
* Realm(swift) for local persistence
* Alamofire for HTTP requests
* RxSwift for reactive programming
