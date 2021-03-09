//
//  NewsFeedViewModel.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 03/03/21.
//

import Foundation

class NewsFeedViewModel {
    
    //--------------------------------------------------------------------------
    // MARK: - Public properties
    //--------------------------------------------------------------------------
    
    var dataArray = [NewsViewModel]()
    
    //--------------------------------------------------------------------------
    // MARK: - Private properties
    //--------------------------------------------------------------------------
    
    private let newsFeedService = NewsService()
    private let coreDataService = CoreDataService()
    
    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------
    
    public func newsFeed(completionHandler: @escaping((NewsService.NewsFeedError?) -> Void)) {
        self.newsFeedService.getNewsFeed {(result) in
            switch result {
            case Result.success(let data):
                self.coreDataService.clearData()
                self.coreDataService.saveInCoreDataWith(model: data)
                self.fetchNewsFeed()
                completionHandler(.noError)
                
            case Result.failure(let message):
                DispatchQueue.main.async {
                    self.fetchNewsFeed()
                    completionHandler(message)
                }
            }
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private methods
    //--------------------------------------------------------------------------
    
    private func fetchNewsFeed() {
        self.dataArray.removeAll()
        guard let data = self.coreDataService.fetchNewsData() else {
            return
        }
        self.dataArray = data.map { NewsViewModel(newsFeed: $0)}
    }
}
