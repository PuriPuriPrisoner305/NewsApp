//
//  NewsWebRouter.swift
//  NewsApp
//
//  Created by Ardyansyah Wijaya on 09/08/23.
//

import Foundation
import UIKit

class NewsWebRouter {
    func showView(url: String) -> NewsWebView {
        let storyboardID = String(describing: NewsWebView.self)
        let view = UIStoryboard(name: storyboardID, bundle: nil)
        guard let view = view.instantiateViewController(withIdentifier: storyboardID) as? NewsWebView
        else {
            fatalError(ErrorType.failLoadView.description)
        }
        view.url = url
        return view
    }
}
