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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collectionView!.collectionViewLayout = layout
        
        self.viewModel.newsFeed{(errorMessage) in
            print("Error message \(String(describing: errorMessage))")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(
            alongsideTransition: { _ in self.collectionView.collectionViewLayout.invalidateLayout() },
            completion: { _ in }
        )
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

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let noOfCellsInRow: Int
        // We can also use size classes to decide the number of cells in rows (Since iPhone is Compact| Regualar and IphoneMax and IPads are Regular|Regular we can using the userInterfaceIdiom approach.  But in requirement it mentioned only the iphone and the ipad.  So going with this approach.
        if UIDevice.current.userInterfaceIdiom == .pad {
            noOfCellsInRow = 8
        } else {
            noOfCellsInRow = 4
        }
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}
