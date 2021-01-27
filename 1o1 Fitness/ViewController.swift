//
//  ViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 21/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
     var animationDurationTimer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
                self.imgView.loadGif(name: "test_000001x")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "LoadingVC")
                    self.imgView.removeFromSuperview()
                    self.navigationController?.pushViewController(controller, animated: true)
                })
    }


}

