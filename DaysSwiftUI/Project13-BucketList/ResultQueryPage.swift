//
//  ResultQueryPage.swift
//  DaysSwiftUI
//
//  Created by Denis Yaremenko on 6/9/21.
//

import Foundation

struct QueryResult: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int : Page]
}

struct Page: Codable {
    let pageId: Int
    let title: String
    let terms: [String : [String]]?
}


