//
//  ViewController.swift
//  httpPhotos
//
//  Created by Four Hsieh_謝松達 on 2020/10/20.
//  Copyright © 2020 Four Hsieh_謝松達. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func requestAPI(_ sender: Any) {
        let httpPhotosViewController = HttpPhotosViewController()
        self.navigationController?.pushViewController(httpPhotosViewController, animated: true)
    }
}

