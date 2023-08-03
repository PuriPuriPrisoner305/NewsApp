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
