//
//  NewsService.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 03/03/21.
//

import Foundation

class NewsService {
    
    enum NewsFeedError: Error {
        case invalidTokenError
        case responseError
        case noError
        case urlError
        case noNewItemsError
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Public properties
    //--------------------------------------------------------------------------
    
    var apiKey = "_hRY33Nqus1-TfH3S2j0vRm6YXdPRxjD_4JU1TpVyuh4VqwO"
    
    lazy var endPoint: String = {
        return "https://api.currentsapi.services/v1/latest-news?apiKey=\(apiKey)"
    }()
    
    
    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------
    
    func getNewsFeed(completion: @escaping (Result<NewsFeedModel, NewsFeedError>) -> Void) {
        let urlString = self.endPoint
        guard let url = URL(string: urlString) else {
            return completion(Result.failure(NewsFeedError.urlError))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return completion(Result.failure(NewsFeedError.invalidTokenError))
            }
            guard let data = data else {
                return completion(Result.failure(NewsFeedError.noNewItemsError))
            }
            do {
                let results = try JSONDecoder().decode(NewsFeedModel.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(results))
                }
            } catch {
                return completion(Result.failure(NewsFeedError.responseError))
            }
        }.resume()
    }
}

