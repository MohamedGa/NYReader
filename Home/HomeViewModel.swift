//
//  HomeViewModel.swift
//  NYReader
//
//  Created by Mohammed Gamal  on 24/01/2022.
//

import Foundation
import UIKit

    // MARK: - protocols
protocol HomeViewModelProtocol {
    func dataUpdated()
    func showLoader()
}

class HomeViewModel {
    
    // MARK: - Properties
    var news = [NewsModel]()
    var selectedIndex: Int?
    let viewController: HomeViewModelProtocol
    
    
    // MARK: Initialization
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: - Methods
    func title(atIndex index: Int) -> String {
        return news[index].title
    }
    func headline(atIndex index: Int) -> String {
        return news[index].headLine
    }
    func numberOfArticles() -> Int {
        if news.count == 0 {
            getPopularNews()
            viewController.showLoader()
        }
        
        return news.count
    }
    
    // MARK: - Segue
    func prepareForDetailsViewController(segue: UIStoryboardSegue) {
        if let destination = segue.destination as? DetailsViewController {
            if let selectedIndex = selectedIndex {
                destination.viewModel = DetailsViewModel(model: news[selectedIndex])
            }
        }
    }
    
    //MARK: - privete Methods
    
    private func getPopularNews() {
        Networking.getPopularNews { [unowned self] retrievedNews in
            news = retrievedNews
            
            self.viewController.dataUpdated()
        } failureHandler: { error in
            // Show alertView with error
        }
    }
    
    
}
