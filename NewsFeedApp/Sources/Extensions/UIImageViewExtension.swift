//
//  UIImageViewExtension.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 04/03/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------
    
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        guard let cachedImage = imageCache.object(forKey: NSString(string: URLString)) else {
            if let url = URL(string: URLString) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                        DispatchQueue.main.async {
                            self.image = placeHolder
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        guard let data = data, let downloadedImage = UIImage(data: data) else {
                            return
                        }
                        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                        self.image = downloadedImage
                    }
                }).resume()
            }
            return
        }
        self.image = cachedImage
        return
    }
}
