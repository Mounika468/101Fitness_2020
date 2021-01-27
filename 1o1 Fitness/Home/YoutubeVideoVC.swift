//
//  YoutubeVideoVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 09/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubeVideoVC: UIViewController {
    @IBOutlet weak var playerView: YTPlayerView!
    var videoId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.isNavigationBarHidden = false
        let  navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        navigationView.titleLbl.text = ""
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.addBtn.isHidden = true
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        
       // self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        self.playerView.load(withVideoId: self.videoId)
    }
    
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.dismiss(animated: true, completion: nil)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
