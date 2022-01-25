//
//  detailsViewModel.swift
//  NYReader
//
//  Created by Hp  on 24/01/2022.
//

import Foundation


class DetailsViewModel {
    // MARK: - Properties
    var news: NewsModel
    
    init(model: NewsModel) {
        news = model
    }
    
    // MARK: - Methods
    func body() -> String {
        return news.body
    }
}
