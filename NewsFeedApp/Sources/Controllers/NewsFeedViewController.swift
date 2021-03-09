//
//  NewsFeedViewController.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 03/03/21.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    //--------------------------------------------------------------------------
    // MARK: - IBOutlets
    //--------------------------------------------------------------------------
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //--------------------------------------------------------------------------
    // MARK: - Public Properties
    //--------------------------------------------------------------------------
    var viewModel = NewsFeedViewModel()
    
    //--------------------------------------------------------------------------
    // MARK: - ViewController Lifecycle
    //--------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width / 5, height: width / 4)
        layout.minimumInteritemSpacing = 0.5
        layout.minimumLineSpacing = 3
        collectionView!.collectionViewLayout = layout
        
        self.viewModel.newsFeed{(errorMessage) in
            print("Error message \(String(describing: errorMessage))")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension NewsFeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsFeedCell", for: indexPath) as! NewsFeedCollectionViewCell
        let localData = self.viewModel.dataArray[indexPath.row]
        cell.setNewsFeedCellWith(data: localData)
        return cell
    }
}

extension NewsFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.detailViewData = self.viewModel.dataArray[indexPath.row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
}
