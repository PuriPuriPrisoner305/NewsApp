//
//  HomeScreenInteractor.swift
//  NewsApp
//
//  Created by Ardyansyah Wijaya on 03/08/23.
//

import Foundation
import RxSwift

class HomeScreenInteractor: BaseInteractor {
    func fetchNews(category: String, page: Int) -> Observable<NewsEntity> {
        api.fetchData(.topHeadlines(category: category, page: page))
    }
}
