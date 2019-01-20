//
//  DrumAPI.swift
//  Click
//
//  Created by Sam Dhondt on 19/01/2019.
//  Copyright © 2019 Sam Dhondt. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/// Handles data retrieval from a web api service
enum DrumAPI {
    private static let _url = "https://drumapi.azurewebsites.net/api/"
    
    /// Returns an observable array of rudiments retrieved from the web api service
    static func retrieveRudiments() -> Observable<[Rudiment]> {
        return Observable<[Rudiment]>.create { observer in
            let request = AF.request("\(_url)rudiments").validate().responseJSON { response in
                switch response.result {
                case .success:
                    let rudiments = try! JSONDecoder().decode([Rudiment].self, from: response.data!)
                    observer.onNext(rudiments)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
