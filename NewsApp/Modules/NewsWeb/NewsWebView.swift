//
//  NewsWebView.swift
//  NewsApp
//
//  Created by Ardyansyah Wijaya on 09/08/23.
//

import UIKit
import WebKit

class NewsWebView: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var newsView: WKWebView!
    var url = "www.google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsView.navigationDelegate = self
        loadNews()
    }
    
    func loadNews() {
        let url = URL(string: url)!
        newsView.load(URLRequest(url: url))
        newsView.allowsBackForwardNavigationGestures = true
    }
    
}
