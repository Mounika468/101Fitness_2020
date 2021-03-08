//
//  PhotosBottomVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 21/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import CropViewController
import PhotosUI
protocol PhotosBottomVCDelegate {
    func imageSelected(image:UIImage)
}
protocol GuestUserSubscribeTappedDelegate {
    func guestSubscribeTapped()
}
class PhotosBottomVC: UIViewController {
    @IBOutlet weak var guestView: UIView!
    var photoPickerDelegate: PhotosBottomVCDelegate?
    var guestViewDelegate: GuestUserSubscribeTappedDelegate?
    var selectedImage : UIImage?
    var isFromProfileScreen : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.view.dropShadow(color: UIColor.lightGray, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
        if isFromProfileScreen {
            self.guestView.isHidden = false
        }else {
            self.guestView.isHidden = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cameraBtnTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func galleryBtnTapped(_ sender: Any) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.allowsEditing = true
//            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//            self.present(imagePicker, animated: true, completion: nil)
//        }
        if #available(iOS 14, *) {
                    // using PHPickerViewController
                    var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                    config.selectionLimit = 1
                    config.filter = .images
                    config.preferredAssetRepresentationMode = .current
                    let picker = PHPickerViewController(configuration: config)
                    picker.delegate = self
                    DispatchQueue.main.async {
                        self.present(picker, animated: true, completion: nil)
                    }
                } else {
                    let imagePickerViewController = UIImagePickerController()
                    imagePickerViewController.allowsEditing = true
                    imagePickerViewController.sourceType = .photoLibrary
                    imagePickerViewController.delegate = self
                    imagePickerViewController.modalPresentationStyle = .fullScreen
                    if(UIDevice.current.userInterfaceIdiom == .pad) {
                        imagePickerViewController.modalPresentationStyle = .popover
                        imagePickerViewController.popoverPresentationController?.sourceView  = self.view
                        imagePickerViewController.popoverPresentationController?.sourceRect = self.view.frame
                        imagePickerViewController.popoverPresentationController?.permittedArrowDirections = .any
                    }
                    DispatchQueue.main.async {
                        self.present(imagePickerViewController, animated: true, completion: nil)
                    }
                }
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
          self.dismiss(animated: true)
    }
    @IBAction func subscribeBtnTapped(_ sender: Any) {
        self.guestViewDelegate?.guestSubscribeTapped()
         self.dismiss(animated: true)
    }
}
extension PhotosBottomVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate,PHPickerViewControllerDelegate{
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let pickedImage = info[.originalImage] as? UIImage {
            picker.dismiss(animated: false, completion: {
                self.selectedImage = pickedImage
                self.dismiss(animated: true) {
                    self.photoPickerDelegate?.imageSelected(image: self.selectedImage ?? UIImage(named: "")!)
                }
            })
            
         }
       
     }
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        guard !results.isEmpty else { return }
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self)
            { [weak self]  image, error in
                DispatchQueue.main.async {
                  guard let self = self else { return }
                  if let image = image as? UIImage {
                    self.selectedImage = image
                    self.dismiss(animated: true) {
                        self.photoPickerDelegate?.imageSelected(image: self.selectedImage ?? UIImage(named: "")!)
                    }
                    } else {
                        
                    }
                }
            }
        }
        
//        let tempImage:UIImage = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage)!
//        DispatchQueue.main.async {
//            self.profileImgView.image = tempImage
//        self.dismiss(animated: true, completion: nil)
//        }
       
        // request image urls
//        let identifier = results.compactMap(\.assetIdentifier)
//        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifier, options: nil)
//        var count = fetchResult.count
//        fetchResult.enumerateObjects {(asset, index, stop) in
//
//            PHAsset.getURL(ofPhotoWith: asset) {[weak self] (url) in
//                if let url = url {
//                  // got image url
//                } else {
//                  // show error
//                }
//            }
//        }
    }
   
}
class Utility {
    
    static func topViewController() -> UIViewController? {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
}
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.sd_imageData(as: .JPEG, compressionQuality: 0.5)
        return data?.base64EncodedString()
    }
}
