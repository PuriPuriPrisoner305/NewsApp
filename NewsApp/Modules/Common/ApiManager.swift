//
//  ApiManager.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import UIKit
import RxSwift

class ApiManager {
    func fetchData<T: Codable>(_ endpoint: APIEndpoint) -> Observable<T> {
        return Observable.create { observer in
            guard let url = URL(string: endpoint.url) else {
                observer.onError(NSError(domain: ErrorType.invalidURL.description, code: 0))
                return Disposables.create()
            }
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let data = data else {
                    observer.onError(NSError(domain: ErrorType.emptyFetchedData.description, code: 0))
                    return
                }
                do {
                    let objects = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(objects)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }.observe(on: MainScheduler.instance)
    }
}

extension ApiManager {
    enum APIEndpoint {
        case category
        
        var url: String {
            switch self {
            case .category:
                return ""
            }
        }
    }
}
