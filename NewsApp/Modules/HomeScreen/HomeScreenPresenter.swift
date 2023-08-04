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
    var interactor = HomeScreenInteractor()
    
    var router = HomeScreenRouter()
    
    func navigateToHeadlines(navigation: UINavigationController, category: NewsCategory) {
        router.navigateToHeadlines(navigation: navigation, category: category)
    }
    
}

