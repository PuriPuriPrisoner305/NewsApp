//
//  HomeScreenPresenter.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import UIKit
import RxSwift
import RxDataSources

class HomeScreenPresenter: BasePresenter {
    let categoryList = BehaviorSubject(value: NewsCategory.allCases)
    var newsData = BehaviorSubject(value: [ArticleEntity]())
    var onSuccessFetchData = PublishSubject<Bool>()
    
    var currentPage = 1
    
    var interactor = HomeScreenInteractor()
    
    func fetchNews(category: String, page: Int) {
        interactor.fetchNews(category: category, page: page)
            .subscribe(onNext: { [weak self] data in
                guard let self = self,
                      let articles = data.articles else {
                    self?.onSuccessFetchData.onNext(false)
                    return
                }
                newsData.onNext(articles)
            }, onError: { error in
                self.onSuccessFetchData.onNext(false)
                print(error)
            }).disposed(by: bag)
                       
    }
    
}

