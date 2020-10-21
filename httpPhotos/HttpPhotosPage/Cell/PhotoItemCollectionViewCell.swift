//
//  PhotoItemCollectionViewCell.swift
//  httpPhotos
//
//  Created by Four Hsieh_謝松達 on 2020/10/20.
//  Copyright © 2020 Four Hsieh_謝松達. All rights reserved.
//

import UIKit

class PhotoItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    static let imageCache = NSCache<NSURL, UIImage>()
    var photo: PhotosModel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func update(with photo: PhotosModel) {
        self.indicator.startAnimating()

        self.photo = photo
        
        idLabel.text = "\(photo.id)"
        titleLabel.text = photo.title
        
        if let url = URL(string: photo.thumbnailUrl) {
            if let image = PhotoItemCollectionViewCell.imageCache.object(forKey: url as NSURL) {
                self.indicator.isHidden = true
                mainImageView.image = image
                return
            }
            else {
                self.indicator.isHidden = false
                mainImageView.image = UIImage(contentsOfFile: "")
            }
                    
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let data = data, let image = UIImage(data: data) {
                PhotoItemCollectionViewCell.imageCache.setObject(image, forKey: url as NSURL)
                  DispatchQueue.main.async {
                     if self.photo.id == photo.id {
                         self.indicator.isHidden = true
                         self.mainImageView.image = image
                     }
                  }
               }
            }
            task.resume()
        }
    }
}
