//
//  HeadlinesInteractor.swift
//  NewsApp
//
//  Created by ardy on 04/08/23.
//

import Foundation
import RxSwift

class HeadlinesInteractor: BaseInteractor {
    func fetchNews(category: String, page: Int) -> Observable<NewsEntity> {
        api.fetchData(.topHeadlines(category: category, page: page))
    }
}
