//
//  DetailViewController.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 04/03/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    //--------------------------------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //--------------------------------------------------------------------------
    // MARK: - Public properties
    //--------------------------------------------------------------------------
    
    var detailViewData: NewsViewModel? = nil
    
    //--------------------------------------------------------------------------
    // MARK: - ViewController Lifecycle
    //--------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tech News"
        self.titleLabel.text = self.detailViewData?.title
        self.dateLabel.text = self.detailViewData?.dateString
        self.descriptionLabel.text = self.detailViewData?.description
        self.authorLabel.text = self.detailViewData?.author
        if let url = self.detailViewData?.image {
            self.imageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
        }
    }
}
