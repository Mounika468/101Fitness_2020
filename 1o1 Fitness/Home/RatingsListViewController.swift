//
//  RatingsListViewController.swift
//  1o1 Fitness
//
//  Created by Mounika Reddy on 12/02/21.
//  Copyright © 2021 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class RatingsListViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var trainerId : String?
    var trainerRatings : [TrainerRatings]?
    var navigationView = NavigationView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        // Do any additional setup after loading the view.
         navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
         navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.titleLbl.text = "Reviews"
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
        self.tblView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getTrainerRatings()
    }
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func getTrainerRatings() {
        let window = UIApplication.shared.windows.first!
               DispatchQueue.main.async {
                   LoadingOverlay.shared.showOverlay(view: window)
               }
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        ProgramAPI.getTrainerRatings(trainerId: self.trainerId ?? "", header: authenticatedHeaders) { (ratings) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            
            if ratings?.count ?? 0 > 0 {
                self.trainerRatings = ratings
                self.tblView.reloadData()
            }else {
                self.tblView.reloadData()
            }
            }
            
        } errorHandler: { (error) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }

//        TrainerDetailsAPI.post(trainerId:(self.trainersInfo?.trainerId)!, header: authenticatedHeaders, successHandler: { [weak self] trainerPofile  in
//
//            print(" success response \(trainerPofile)")
//            DispatchQueue.main.async {
//                LoadingOverlay.shared.hideOverlayView()
//                self?.profileView.nameLbl.text = trainerPofile[0].firstName! + " " + trainerPofile[0].lastName!
//                self?.profileView.aboutLbl.text = trainerPofile[0].about!
//                let imagePath = trainerPofile[0].profileImage?.profileImagePath!
//                self?.profileView.imgView.loadImage(url:URL(string: imagePath!)!)
//                self?.profileView.certArray = trainerPofile[0].certification
//                 let profileVideo = trainerPofile[0].profileIntroVideo
//                self?.introVideo = profileVideo?.videoMp4Destination!
//                self?.profileView.setupCertificatesView()
//                self?.profileView.ratings.rating = Double(trainerPofile[0].rating ?? 0)
//            }
//        }) { [weak self] error in
//            print(" error \(error)")
//            DispatchQueue.main.async {
//                LoadingOverlay.shared.hideOverlayView()
//            }
//        }
    }

}
extension RatingsListViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainerRatings?.count ?? 0
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
         let cell = tableView.dequeueReusableCell(withIdentifier: "ratingsCell",
                                                       for: indexPath) as! RatingTableViewCell
        let rating = self.trainerRatings![indexPath.row]
        let imageURl = rating.trainerProfileImage?.profileImagePath
        if imageURl != nil && imageURl?.count ?? 0 > 0 {
            cell.imgView.sd_setImage(with: URL(string:imageURl!)!, placeholderImage: UIImage(named: "chest"))
        }
        cell.comments.text = rating.review_comment
        cell.nameLbl.text = rating.trainee_name ?? ""
        let dob = String(rating.creationDate!.prefix(10)) as String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dob)
        let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
        cell.dateLbl.text = date1
        cell.ratingsView.rating = rating.program_rating ?? 0
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
