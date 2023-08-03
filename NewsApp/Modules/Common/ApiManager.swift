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
            
            // Set Header Values
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("X-Api-Key", forHTTPHeaderField: APIEndpoint.APIKey.url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
// MARK: List of endpoint
    enum APIEndpoint {
        case APIKey
        case topHeadlines(category: String, page: Int)
        
        var url: String {
            switch self {
            case .APIKey:
                return "f0a82022c6474f9c912e9ab4a04d55d1"
            case .topHeadlines(let category, let page):
                return "https://newsapi.org/v2/top-headlines?category=\(category)&page=\(page)"
            }
        }
    }
}
