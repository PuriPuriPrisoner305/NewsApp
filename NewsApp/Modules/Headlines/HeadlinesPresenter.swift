//
//  HeadlinesPresenter.swift
//  NewsApp
//
//  Created by ardy on 04/08/23.
//

import Foundation
import UIKit
import RxSwift

class HeadlinesPresenter: BasePresenter {
    var newsData = BehaviorSubject(value: [ArticleEntity]())
    var onSuccessFetchData = PublishSubject<Bool>()
    
    var currentPage = 1
    
    var interactor = HeadlinesInteractor()
    
    func fetchNews(category: String) {
        interactor.fetchNews(category: category, page: currentPage)
            .subscribe(onNext: { [weak self] data in
                guard let self = self,
                      let articles = data.articles
                else {
                    self?.onSuccessFetchData.onNext(false)
                    return
                }
                newsData.onNext(articles)
                onSuccessFetchData.onNext(true)
                currentPage += 1
            }, onError: { error in
                self.onSuccessFetchData.onNext(false)
                print(error)
            }).disposed(by: bag)
    }
    
}
