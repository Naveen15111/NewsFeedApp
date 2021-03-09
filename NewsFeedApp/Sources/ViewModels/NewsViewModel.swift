//
//  NewsViewModel.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 08/03/21.
//

import Foundation

class NewsViewModel {
    
    //--------------------------------------------------------------------------
    // MARK: - Public properties
    //--------------------------------------------------------------------------
    
    var title: String {
        self.newsFeed.title ?? ""
    }
    
    var image: String? {
        self.newsFeed.image
    }
    
    var dateString: String {
        String(self.newsFeed.published?.dropLast(5) ?? "not available")
    }
    
    var description: String {
        self.newsFeed.description
    }
    
    var author: String? {
        self.newsFeed.author
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private properties
    //--------------------------------------------------------------------------
    
    private let newsFeed: NewsFeed
    
    //--------------------------------------------------------------------------
    // MARK: - Initializer
    //--------------------------------------------------------------------------
    
    init(newsFeed: NewsFeed) {
        self.newsFeed = newsFeed
    }
}
