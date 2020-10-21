//
//  HttpPhotosViewController.swift
//  httpPhotos
//
//  Created by 謝松達 on 2020/10/19.
//

import UIKit
import Alamofire

class HttpPhotosViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos = [PhotosModel]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
                
        self.setupUI()
        
        self.indicatorView.startAnimating()
        HttpPhotosViewModel.shared.requestAPI { (response, error) in
            self.indicatorView.isHidden = true
            if (error == nil) {
                self.photos = response!
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        flowLayout.itemSize = CGSize(width: size.width/4, height: size.width/4)
    }

    func setupUI() {
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        self.collectionView.register(UINib(nibName: "PhotoItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoItemCollectionViewCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCollectionViewCell", for: indexPath) as! PhotoItemCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.update(with: photo)
        
        return cell
    }
    
    deinit {
        print("deinit: \(self.classForCoder)")
    }
}
