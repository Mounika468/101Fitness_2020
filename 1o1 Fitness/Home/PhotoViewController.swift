//
//  PhotoViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 22/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import CropViewController
import Alamofire
class PhotoViewController: UIViewController {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var photoCV: UICollectionView! {
        didSet {
            photoCV.showsVerticalScrollIndicator = false
            photoCV.showsHorizontalScrollIndicator = false
        }
    }
    
     var selectedImage : UIImage?
   
    var photosArr : [ProgressPhoto]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
               let xBarHeight = navigationController?.navigationBar.frame.maxY
               let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
                      navigationView.titleLbl.text = "Progress Photos"
               navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.saveBtn.isHidden = false
        navigationView.saveBtn.setTitle("Add Photo", for: .normal)
         navigationView.saveBtn.addTarget(self, action: #selector(addBtnTapped(sender:)), for: .touchUpInside)
                      navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
                      self.view.addSubview(navigationView)
               self.navigationController?.isNavigationBarHidden = true
        let trainerNib = UINib(nibName: "HomeTrainerCollectionViewCell", bundle: nil)
        self.photoCV.register(trainerNib, forCellWithReuseIdentifier:"HomeProfileCV")
        let flowLayoutVertical = UICollectionViewFlowLayout()
        flowLayoutVertical.scrollDirection = .vertical
        self.photoCV.collectionViewLayout = flowLayoutVertical
         self.bgView.dropShadow(color: UIColor.white, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
      //  self.bgView.roundCorners(corners: [.topLeft,.topRight], radius: 3)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getAllPhotosForTheUser()
//        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//
//        visualEffectView.frame = self.view.bounds
//        visualEffectView.alpha = 0.5
//        self.view.addSubview(visualEffectView)
        
      
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    @objc func addBtnTapped(sender : UIButton){
    // self.navigationController?.popViewController(animated: true)
        self.photoCV.alpha = 0.5
        self.photoCV.isUserInteractionEnabled = false
        self.bgView.isHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getAllPhotosForTheUser() {
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
               var authenticatedHeaders: [String: String] {
                   [
                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                       HeadersKeys.contentType: HeaderValues.json
                   ]
               }
               if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                            ProgramDetails.programDetails.subId = id
                                        }
    
        ProgressPhotosByDateAPI.getAllPhotosAPI(header: authenticatedHeaders, traineeId: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, successHandler: { (progrssPhotos) in
            self.photosArr = progrssPhotos
            if self.photosArr?.count ?? 0 > 0 {
                
            }
            self.photoCV.reloadData()
        }) { (error) in
            
        }
    }
   
    @IBAction func cameraTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func galleryTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func closeTapped(_ sender: Any) {
        self.photoCV.alpha = 1.0
               self.photoCV.isUserInteractionEnabled = true
               self.bgView.isHidden = true
    }
}
extension PhotoViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosArr?.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProfileCV", for: indexPath) as! HomeTrainerCollectionViewCell
//        cell.contentView.layer.cornerRadius = 10.0
//        cell.contentView.layer.borderColor = AppColours.lineColor.cgColor
//        cell.contentView.layer.backgroundColor = UIColor.init(red: 41/255, green: 37/255, blue: 37/255, alpha: 1.0).cgColor
//        cell.contentView.layer.masksToBounds = false
        //cell.ratingBtn.setImage(UIImage(named: "magnify"), for: .normal)
        cell.ratingBtn.setBackgroundImage(UIImage(named: "magnify"), for: .normal)
        cell.ratingBtn.isHidden = false
        cell.deleteBtn.isHidden = false
        let photo = self.photosArr![indexPath.row]
        let imageInfo = photo.imgUrl ?? ""
        if imageInfo.count > 0 {
            //cell.profileImgView.loadImage(url:URL(string: imageInfo)!)
            cell.profileImgView.sd_setImage(with: URL(string: imageInfo)!, completed: nil)
        }
        cell.ratingBtn.tag = indexPath.row
        cell.ratingBtn.addTarget(self, action: #selector(ratingBtnTapped(sender:)), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped(sender:)), for: .touchUpInside)
        cell.nameLbl.textColor = .white
        let dob = String(photo.name!.prefix(10)) as String
        cell.nameLbl.text = dob
        return cell
        
        
    }
    @objc func deleteBtnTapped(sender : UIButton) {
        
        let photo = self.photosArr![sender.tag]
        self.presentAlertWithTitle(title: "Delete", message: "Do you want to delete the image", options: "OK","Cancel") { (option) in
           if option == 0 {
               self.deletePhotoCall(photoId: photo.photoId ?? "", successHandler: { (progressPhoto) in
                         
                         DispatchQueue.main.async {
                             LoadingOverlay.shared.hideOverlayView()
                             self.photosArr = progressPhoto
                            self.photoCV.reloadData()
                         }
                     }) { (message) in
                         DispatchQueue.main.async {
                              LoadingOverlay.shared.hideOverlayView()
                            self.photosArr = nil
                            self.photoCV.reloadData()
                             self.presentAlertWithTitle(title: "", message: message, options: "OK") { _ in
                                 
                             }
                         }
                         
                     }
           }}
        
    }
    @objc func ratingBtnTapped(sender : UIButton){
          // self.woViewDelegate?.workOutSelected(indexPath:indexPath as NSIndexPath,exercises: (self.workOutsArr?.workouts?[sender.tag])!)
             let photo = self.photosArr![sender.tag]
                  let storyboard = UIStoryboard(name: "PhotoDeleteVC", bundle: nil)
                               let controller = storyboard.instantiateViewController(withIdentifier: "PhotoDeleteVC") as! PhotoDeleteVC
                               controller.modalPresentationStyle = .custom
                controller.deletePhotoDelegate = self
                controller.photos = photo
                //               controller.photoPickerDelegate = self
                //               controller.transitioningDelegate = self
                               self.present(controller, animated: true, completion: nil)

       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        let noOfCellsInRow = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .vertical
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 180)
        
        
        // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//         let photo = self.photosArr![indexPath.row]
//          let storyboard = UIStoryboard(name: "PhotoDeleteVC", bundle: nil)
//                       let controller = storyboard.instantiateViewController(withIdentifier: "PhotoDeleteVC") as! PhotoDeleteVC
//                       controller.modalPresentationStyle = .custom
//        controller.deletePhotoDelegate = self
//        controller.photos = photo
//        //               controller.photoPickerDelegate = self
//        //               controller.transitioningDelegate = self
//                       self.present(controller, animated: true, completion: nil)
        
    }
    func deletePhotoCall(photoId:String, successHandler: @escaping ([ProgressPhoto]?) -> Void,
       errorHandler: @escaping (String) -> Void) {
          
           let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
           var authenticatedHeaders: [String: String] {
               [
                   HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                   HeadersKeys.contentType: HeaderValues.json
               ]
           }
           if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                        ProgramDetails.programDetails.subId = id
                                    }
                
           
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()),"isCalendar":true,"photoId":photoId]
                   let urlString = deletePhoto + UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)! + "/progressphotos"
                   guard let url = URL(string: urlString) else {return}
                   var request        = URLRequest(url: url)
                   request.httpMethod = "Post"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                   do {
                       request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                   } catch let error {
                       print("Error : \(error.localizedDescription)")
                   }
           //  request.setValue(postBody.capacity, forHTTPHeaderField: "Content-Length")

           Alamofire.request(request).responseJSON{ (response) in
               print("response is \(response)")
               if let status = response.response?.statusCode {
                   switch(status){
                   case 200:
                       if let json = response.result.value as? [String: Any] {
                           print("JSON: \(json)") // serialized json response
                           do {
                               if json["code"] as? Int != 40
                               {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                        }
                                        successHandler(nil)
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        let photosArr = try JSONDecoder().decode([ProgressPhoto]?.self, from: jsonData)
                                        successHandler(photosArr)
                                    }
                                    
                                } else {
                                       
                                       errorHandler("Fetching the Schedules failed")
                                   }
                               }else {
                                   if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                       messageString = (jsonMessage as? String)!
                                      
                                       errorHandler(messageString)
                                   }
                               } }catch let error {
                                  
                                   errorHandler("Fetching the Schedules failed")
                           }
                       }
                       
                   default:
                       DispatchQueue.main.async {
                           LoadingOverlay.shared.hideOverlayView()
                           self.presentAlertWithTitle(title: "", message: "Fetching the Schedules failed", options: "OK") {_ in
                           }
                       }
                   }
               }
           }
         
       }
}
extension PhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate{
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let pickedImage = info[.originalImage] as? UIImage {
            picker.dismiss(animated: false, completion: {
                self.selectedImage = pickedImage
                self.bgView.isHidden = true
                self.presentCropViewController(image: self.selectedImage!)
//                self.dismiss(animated: true) {
//                    self.photoPickerDelegate?.imageSelected(image: self.selectedImage ?? UIImage(named: "")!)
//                }
            })
            
         }
       
     }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        //    self.profilePicImageView.image = image
        let window = UIApplication.shared.windows.first!
               DispatchQueue.main.async {
                   LoadingOverlay.shared.showOverlay(view: window)
               }
        uploadPhotoForTrainer(image: image, successHandler: { (progressPhotos) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self.photoCV.reloadData()
                self.photoCV.alpha = 1.0
                self.photoCV.isUserInteractionEnabled = true
                cropViewController.dismiss(animated: true, completion: nil)
                
            }
            
        }) { (message) in
            DispatchQueue.main.async {
                self.photoCV.reloadData()
                LoadingOverlay.shared.hideOverlayView()
                cropViewController.dismiss(animated: true, completion: nil)
                self.presentAlertWithTitle(title: "", message: message, options: "OK") {_ in
                    self.photoCV.alpha = 1.0
                    self.photoCV.isUserInteractionEnabled = true
                    
                }
                
            }
        }
        //              Progress.shared.showProgressView()
        //              ProfileUpdateAPI.init().updateProfileImage(img: image) { (msg, issucces) in
        //                  cropViewController.dismiss(animated: true, completion: nil)
        //                  self.myPickerController.dismiss(animated: true, completion: nil)
        //                  Progress.shared.hideProgressView()
        //                  var mesg = ""
        //                  if issucces{
        //                      mesg = "Profile Image Successfully Updated"
        //                  }else{
        //                      mesg = "Profile Image Successfully Updated"
        //                  }
        //                  Utility.topViewController()?.view.makeToast(mesg)
        //              }
        
    }
              
    func presentCropViewController(image :UIImage) {
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        self.present(cropViewController, animated: true, completion: nil)
    }
    func uploadPhotoForTrainer(image:UIImage, successHandler: @escaping ([ProgressPhoto]?) -> Void,
    errorHandler: @escaping (String) -> Void) {
       
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                     ProgramDetails.programDetails.subId = id
                                 }
              if let id = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId) {
                  ProgramDetails.programDetails.programId = id
              }
        let imageName = "iOS" + "\(Date())"
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()),"trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"name":imageName,"imgcode":image.toString() as Any,"file_type":"jpg","isCalendar":false]
                let urlString = savePhoto
                guard let url = URL(string: urlString) else {return}
                var request        = URLRequest(url: url)
                request.httpMethod = "Post"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
                do {
                    request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                } catch let error {
                    print("Error : \(error.localizedDescription)")
                }
        //  request.setValue(postBody.capacity, forHTTPHeaderField: "Content-Length")

        Alamofire.request(request).responseJSON{ (response) in
            print("response is \(response)")
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let json = response.result.value as? [String: Any] {
                        print("JSON: \(json)") // serialized json response
                        do {
                            if json["code"] as? Int != 40
                            {
                                if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                    if jsonDict is NSNull {
                                        
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                            messageString = (jsonMessage as? String)!
                                            //  self.nodataLbl.text = messageString
                                        }
                                        self.photosArr = nil
                                        successHandler(self.photosArr)
                                        
                                    }else {
                                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                  options: .prettyPrinted)
                                        self.photosArr = try JSONDecoder().decode([ProgressPhoto]?.self, from: jsonData)
                                        successHandler(self.photosArr)
                                    }
                                    
                                } else {
                                     errorHandler("Uploading the photo is failed")
                                }
                            }else {
                                if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                    messageString = (jsonMessage as? String)!
                                   
                                    errorHandler(messageString)
                                }
                                self.photosArr = nil
                            } }catch let error {
                                
                                errorHandler("Uploading the photo is failed")
                        }
                    }
                    
                default:
                    DispatchQueue.main.async {
                       // LoadingOverlay.shared.hideOverlayView()
                          errorHandler("Uploading the photo is failed as image is too big")
                    }
                }
            }
        }
      
    }
   
}
extension PhotoViewController : DeletePhotoDelegate {
    func reloadPhotos() {
        self.getAllPhotosForTheUser()
    }
}
