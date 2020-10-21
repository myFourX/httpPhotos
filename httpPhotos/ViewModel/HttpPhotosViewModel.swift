//
//  HttpPhotosViewModel.swift
//  httpPhotos
//
//  Created by Four Hsieh_謝松達 on 2020/10/20.
//  Copyright © 2020 Four Hsieh_謝松達. All rights reserved.
//

import UIKit
import Alamofire

class HttpPhotosViewModel: NSObject {
    static let shared = HttpPhotosViewModel()

    func requestAPI(completion: ((_ responseObject: [PhotosModel]?, _ error: Error?) -> Void)?) {
        AF.request("https://jsonplaceholder.typicode.com/photos").responseJSON { (response) in
            if let data = response.data {
                do {
                    let model = try JSONDecoder().decode([PhotosModel].self, from: data)
                    completion!(model, nil)
                } catch {
                    print(error)
                    completion!(nil, error)
                }
            }
        }
    }
}
