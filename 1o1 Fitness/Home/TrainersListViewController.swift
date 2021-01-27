//
//  VideoPlayerViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 22/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class TrainersListViewController: UIViewController {
    @IBOutlet weak var profileCV: UICollectionView! {
        didSet {
            profileCV.showsVerticalScrollIndicator = false
            profileCV.showsHorizontalScrollIndicator = false
        }
    }
    var trainersInfo : [TrainerInfo]?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    var pageNumber : Int = 0
    var isLoading = false
    override func viewDidLoad() {
       super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let xBarHeight = navigationController?.navigationBar.frame.maxY
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
               navigationView.titleLbl.text = "Trainers"
        navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
       let trainerNib = UINib(nibName: "TrainerCollectionViewCell", bundle: nil)
              self.profileCV.register(trainerNib, forCellWithReuseIdentifier:"profileCV")
              let flowLayoutVertical = UICollectionViewFlowLayout()
              flowLayoutVertical.scrollDirection = .vertical
              self.profileCV.collectionViewLayout = flowLayoutVertical
         self.searchBar.isHidden = true
        self.searchBar.layer.cornerRadius = 15.0
              self.searchBar.layer.borderColor = UIColor.init(red: 152/255, green: 255/255, blue: 84/255, alpha: 1.0).cgColor
              self.searchBar.layer.borderWidth = 0.5
//        if IOSVersion.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: "13.0") {
//             self.searchBar.searchTextField.textColor = UIColor.white
//        }else {
//            
//        }
             
        self.profileCV.reloadData()
      //  print("trainer info \(trainersInfo)")

    }
    override func viewDidAppear(_ _animated: Bool)
    {
        self.isLoading = false
        self.pageNumber = 0
        self.getTrainersInfo()
        if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
        }
        
    }
    private func getTrainersInfo()
        {
             let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
                   }
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            if token == nil {
                AWSUserSingleton.shared.getUserattributes()
            }
                var authenticatedHeaders: [String: String] {
                                           [
                                             HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                                               HeadersKeys.contentType: HeaderValues.json
                                           ]
                         }

        GetTrainersAPI.post(parameters:[:], pageNumber: self.pageNumber,header:authenticatedHeaders, successHandler: { [weak self] trainerInfo  in
                      self?.trainersInfo = trainerInfo
            self?.pageNumber = self!.pageNumber + 1
                      print(" success response \(trainerInfo)")
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.profileCV.reloadData()
                        LoadingOverlay.shared.hideOverlayView()
                    }
                  }) { [weak self] error in
                      print(" error \(error)")
                    DispatchQueue.main.async {
                        self?.isLoading = true
                           LoadingOverlay.shared.hideOverlayView()
                           }
                  }
        }
    @objc func backBtnTapped(sender : UIButton){
           self.navigationController?.popViewController(animated: true)
          }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func searchBtnTapped(_ sender: Any) {
        if self.searchBar.isHidden == true {
            self.searchBar.isHidden = false
        }else {
            self.searchBar.isHidden = true
        }
    }
    
}
extension TrainersListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return 10
        return self.trainersInfo?.count ?? 0
       
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCV", for: indexPath) as! TrainerCollectionViewCell
        let trainer = self.trainersInfo?[indexPath.row] as! TrainerInfo
        let imageInfo = trainer.profileImage?.profileImagePath as! String
        if imageInfo.count > 0 {
             cell.profileImgView.load(url:URL(string: imageInfo)!,width:cell.profileImgView.frame.size.width ,height:cell.profileImgView.frame.size.height )
            let imageURL = URL(string: imageInfo)!
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:imageURL)
                {
                    DispatchQueue.main.async {
                        let image = UIImage( data:data)
                        let squared = image?.squared
                        cell.profileImgView.image = squared
                    }
                }
            }
        }
        cell.nameLbl.text = trainer.firstName! + " " + trainer.lastName!
//        if  let rating = trainer.rating {
//            let ratings = String(describing: rating)
//            let rating = ratings
//            cell.ratingBtn.setTitle(rating, for: .normal)
//        }else {
//            cell.ratingBtn.setTitle("", for: .normal)
//        }
        cell.ratingBtn.setImage(UIImage(named: ""), for: .normal)
        cell.ratingBtn.isHidden = true

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               flowLayout.scrollDirection = .vertical
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: 160)

    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let trainer = self.trainersInfo?[indexPath.row]
        let storyboard = UIStoryboard(name: "TrainerDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TrainerDetailsVC") as! TrainerDetailsViewController
        controller.trainersInfo = trainer
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.profileCV && self.trainersInfo?.count ?? 0 > 2{
            if indexPath.row == self.trainersInfo!.count  - 1 && !self.isLoading {
               // self.isLoading = true
                loadMoreData()
            }
        }
       
    }
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
//            let start = self.trainersInfo!.count + 1
//            let end = start + 20
        //    DispatchQueue.global().async {
                // fake background loading task
              //  sleep(2)
//                for _ in start...end {
//                    self.itemsArray.append(self.getRandomColor())
//                }
                let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                if token == nil {
                    AWSUserSingleton.shared.getUserattributes()
                }
                var authenticatedHeaders: [String: String] {
                    [
                        HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                        HeadersKeys.contentType: HeaderValues.json
                    ]
                }
                
               
                let window = UIApplication.shared.windows.first!
                DispatchQueue.main.async {
                    LoadingOverlay.shared.showOverlay(view: window)
                }
            GetTrainersAPI.post(parameters:[:], pageNumber: self.pageNumber,header:authenticatedHeaders, successHandler: { [weak self] trainerInfo  in
                if trainerInfo.count > 0 {
                    self?.trainersInfo?.append(contentsOf: trainerInfo)
                   // self?.trainersInfo = trainerInfo
                    self?.pageNumber = self!.pageNumber + 1
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.profileCV.reloadData()
                        LoadingOverlay.shared.hideOverlayView()
                    }
                }else {
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                        self?.profileCV.reloadData()
                        self?.isLoading = true
                    }
                }
                print(" success response \(trainerInfo)")
                      }) { [weak self] error in
                          print(" error \(error)")
                        DispatchQueue.main.async {
                            self?.isLoading = true
                               LoadingOverlay.shared.hideOverlayView()
                               }
                      }
        }
    }
   
}
extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var squared: UIImage? {
        guard let cgImage = cgImage?
            .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                              y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                size: breadthSize)) else { return nil }
        return UIGraphicsImageRenderer(size: breadthSize, format: imageRendererFormat).image { _ in
            UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
            .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
}
extension TrainersListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      //  searchActive = true;
//        self.brandedBtn.isHidden = true
//        self.commonBtn.isHidden = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       // searchActive = false;
//        self.brandedBtn.isHidden = true
//        self.commonBtn.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       // searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  searchActive = false;
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchTrainersList), object: nil)
        self.perform(#selector(searchTrainersList), with: nil, afterDelay: 0.5)

    }
    @objc func searchTrainersList() {
        
       var idToken = ""
        
        let searchText = self.searchBar.text ?? ""
        if searchText.count == 0 { // If no search text is entered
            self.isLoading = false
            self.pageNumber = 0
            self.getTrainersInfo()
        }else {
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            if token == nil {
                AWSUserSingleton.shared.getUserattributes()
            }
                var authenticatedHeaders: [String: String] {
                                           [
                                             HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                                               HeadersKeys.contentType: HeaderValues.json
                                           ]
                         }
                 TrainerSearch.searchTrainers(searchText: searchText , header: authenticatedHeaders) {[weak self] (trainerInfo) in
                     if trainerInfo != nil {
                          self?.trainersInfo = trainerInfo
                         DispatchQueue.main.async {
                                            self?.profileCV.reloadData()
         //                                   LoadingOverlay.shared.hideOverlayView()
                                        }
                     }else {
                          DispatchQueue.main.async {
                         self?.presentAlertWithTitle(title: "", message: "No trainer found.", options: "OK") {_ in
                             }
                             
                         }
                     }
                     
                 } errorHandler: { (error) in
                     
                 }
        }
        
       
       

    }
}
