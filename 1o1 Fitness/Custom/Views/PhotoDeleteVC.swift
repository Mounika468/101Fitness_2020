//
//  PhotoDeleteVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 24/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire
protocol DeletePhotoDelegate {
    func reloadPhotos()
}
class PhotoDeleteVC: UIViewController {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
     var selectedPhotoId : String = ""
    var photos : ProgressPhoto?
    var deletePhotoDelegate : DeletePhotoDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupImage()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupImage() {
        let imageInfo = photos?.imgUrl ?? ""
        if imageInfo.count > 0 {
            //cell.profileImgView.loadImage(url:URL(string: imageInfo)!)
            self.imgView.sd_setImage(with: URL(string: imageInfo)!, completed: nil)
        }
        self.dateLbl.textColor = .white
        let dob = String((photos?.name!.prefix(10))!) as String
         self.dateLbl.text = dob
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        
       self.presentAlertWithTitle(title: "Delete", message: "Do you want to delete the image", options: "OK","Cancel") { (option) in
        if option == 0 {
            self.deletePhotoCall(photoId: self.photos?.photoId ?? "", successHandler: { (progressPhoto) in
                       
                       DispatchQueue.main.async {
                           self.dismiss(animated: true) {
                               self.deletePhotoDelegate?.reloadPhotos()
                           }
                       }
                   }) { (message) in
                       DispatchQueue.main.async {
                           self.presentAlertWithTitle(title: "", message: message, options: "OK") { (Int) in
                               
                           }
                       }
                       
                   }
        }
        }
       
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
             
        
        let postBody : [String: Any] = ["date": Date.getDateInFormat(format: "yyyy-MM-dd", date: Date()),"isCalendar":false,"photoId":photoId]
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
