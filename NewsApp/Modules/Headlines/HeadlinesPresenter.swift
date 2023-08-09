//
//  HeadlinesPresenter.swift
//  NewsApp
//
//  Created by ardy on 04/08/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class HeadlinesPresenter: BasePresenter {
    var newsData = BehaviorRelay<[ArticleEntity]>(value: [])
    var onSuccessFetchData = PublishSubject<Bool>()
    
    var currentPage = 1
    
    var interactor = HeadlinesInteractor()
    var router = HeadlinesRouter()
    
    func fetchNews(category: String) {
        interactor.fetchNews(category: category, page: currentPage)
            .subscribe(onNext: { [weak self] data in
                guard let self = self,
                      let articles = data.articles
                else {
                    self?.onSuccessFetchData.onNext(false)
                    return
                }
                newsData.accept(self.newsData.value + articles)
                onSuccessFetchData.onNext(true)
                currentPage += 1
            }, onError: { error in
                self.onSuccessFetchData.onNext(false)
                print(error)
            }).disposed(by: bag)
    }
    
    func navigateToNewsWeb(navigation: UINavigationController, url: String) {
        router.navigateToNewsWeb(navigation: navigation , url: url)
    }
    
}
