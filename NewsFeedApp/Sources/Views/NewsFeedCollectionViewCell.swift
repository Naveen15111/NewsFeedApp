//
//  NewsFeedCollectionViewCell.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 04/03/21.
//

import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {
    
    //--------------------------------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------
    
    func setNewsFeedCellWith(data: NewsViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = data.title
            if let url = data.image {
                self.imageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
    }
}

