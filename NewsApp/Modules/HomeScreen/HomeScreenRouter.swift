//
//  HomeScreenRouter.swift
//  NewsApp
//
//  Created by ardy on 04/08/23.
//

import Foundation
import UIKit

class HomeScreenRouter {
    func navigateToHeadlines(navigation: UINavigationController, category: NewsCategory) {
        let view = HeadlinesRouter().showView(category: category)
        navigation.pushViewController(view, animated: true)
    }
}
