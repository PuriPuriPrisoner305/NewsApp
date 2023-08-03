//
//  HomeScreenPresenter.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import UIKit
import RxSwift
import RxDataSources

class HomeScreenPresenter {
    let categoryList = BehaviorSubject(value: NewsCategory.allCases)
}

