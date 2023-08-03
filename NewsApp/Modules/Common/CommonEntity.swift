//
//  CommonEntity.swift
//  NewsApp
//
//  Created by ardy on 31/07/23.
//

import Foundation

enum ErrorType {
    case fetchFailed
    case noInternet
    case decodingFailed
    case storyboardLoadFailed
    case invalidURL
    case emptyFetchedData
    
    var description: String {
        switch self {
        case .fetchFailed:
            return "We have problem loading movie data. Please try again"
        case .noInternet:
            return "Please check for internet connection"
        case .decodingFailed:
            return "Error decoding fetched data"
        case .storyboardLoadFailed:
            return "Error loading storyboard"
        case .invalidURL:
            return "Invalid URL"
        case .emptyFetchedData:
            return "No data returned from API"
        }
    }
}
