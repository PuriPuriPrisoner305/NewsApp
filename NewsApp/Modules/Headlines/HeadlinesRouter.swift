//
//  HeadlinesRouter.swift
//  NewsApp
//
//  Created by ardy on 04/08/23.
//

import Foundation
import UIKit

class HeadlinesRouter {
    func showView(category: NewsCategory) -> HeadlinesView {
        let storyboardID = String(describing: HeadlinesView.self)
        let headlinesView = UIStoryboard(name: storyboardID, bundle: nil)
        guard let view = headlinesView.instantiateViewController(withIdentifier: storyboardID) as? HeadlinesView
        else {
            fatalError(ErrorType.failLoadView.description)
        }
        view.category = category
        return view
    }
    
    func navigateToNewsWeb(navigation: UINavigationController, url: String) {
        let view = NewsWebRouter().showView(url: url)
        navigation.pushViewController(view, animated: true)
    }
    
}

