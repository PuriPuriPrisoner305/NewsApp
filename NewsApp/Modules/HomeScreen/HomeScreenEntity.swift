//
//  HomeScreenEntity.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import Foundation

enum NewsCategory: CaseIterable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology

    var name: String {
        return String(describing: self).capitalized
    }
}

struct NewsEntity: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleEntity]?
}

struct ArticleEntity: Codable {
    let source: Source?
    let author, title, description, url, urlToImage, publishedAt, content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
