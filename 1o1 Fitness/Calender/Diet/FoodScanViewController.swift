
//
//  FoodScanViewController.swift
//  1o1 Fitness
//
//  Created by Hareen.Pulivarthi on 16/09/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import BarcodeScanner
enum OCRSelection {
    case camera
    case gallery
    case form

}
class FoodScanViewController: UIViewController {

    @IBOutlet weak var autoFillBgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var foodNameTxt: UITextField!
    
    @IBOutlet weak var nutritionLbl: UILabel!
    @IBOutlet weak var proteinTxt: UITextField!
    @IBOutlet weak var sugarsTxt: UITextField!
    @IBOutlet weak var fibertxt: UITextField!
    @IBOutlet weak var carboTxt: UITextField!
    @IBOutlet weak var sodiumTxt: UITextField!
    @IBOutlet weak var choleTxt: UITextField!
    @IBOutlet weak var saturatedTxt: UITextField!
    @IBOutlet weak var fatTxt: UITextField!
    @IBOutlet weak var caloriesTxt: UITextField!
    @IBOutlet weak var servingSizeTxt: UITextField!
    @IBOutlet weak var brandNameTxt: UITextField!
    var selectedFoodDetails : NutritionixFoodData?
    var mealType : String = ""
    var selectedUPC = ""
    var navigationView = NavigationView()
    var isFromBarcodeScanner : Bool = true
    var xBarHeight :CGFloat  = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addPaddingAndBorder(to: self.foodNameTxt)
         self.addPaddingAndBorder(to: self.brandNameTxt)
         self.addPaddingAndBorder(to: self.caloriesTxt)
         self.addPaddingAndBorder(to: self.servingSizeTxt)
         self.addPaddingAndBorder(to: self.fatTxt)
         self.addPaddingAndBorder(to: self.saturatedTxt)
         self.addPaddingAndBorder(to: self.choleTxt)
         self.addPaddingAndBorder(to: self.sodiumTxt)
         self.addPaddingAndBorder(to: self.carboTxt)
         self.addPaddingAndBorder(to: self.fibertxt)
         self.addPaddingAndBorder(to: self.proteinTxt)
         self.addPaddingAndBorder(to: self.sugarsTxt)
        self.nutritionLbl.textColor = AppColours.textGreen
//        self.autoFillBgView.layer.cornerRadius = 5
//        self.autoFillBgView.layer.borderWidth = 1
//        self.autoFillBgView.layer.borderColor = AppColours.textGreen.cgColor
        
        self.navigationController?.isNavigationBarHidden = false
                       navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
                      navigationView.titleLbl.text = " "
                      navigationView.backgroundColor = AppColours.topBarGreen
                      navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        navigationView.saveBtn.isHidden = false
                  navigationView.saveBtn.setTitle("Add", for: .normal)
                      navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
                      self.view.addSubview(navigationView)
                      self.navigationController?.isNavigationBarHidden = true
        
        self.servingSizeTxt.attributedPlaceholder = NSAttributedString(string: "Required",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.caloriesTxt.attributedPlaceholder = NSAttributedString(string: "Required",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.fatTxt.attributedPlaceholder = NSAttributedString(string: "Required",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.carboTxt.attributedPlaceholder = NSAttributedString(string: "Required",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.proteinTxt.attributedPlaceholder = NSAttributedString(string: "Required",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.foodNameTxt.attributedPlaceholder = NSAttributedString(string: "Required",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        self.setUpView()
    }
    func setUpView() {
        if self.isFromBarcodeScanner {
            
            self.foodNameTxt.isEnabled = false
            self.brandNameTxt.isEnabled = false
            self.servingSizeTxt.isEnabled = true
            self.fatTxt.isEnabled = false
            self.caloriesTxt.isEnabled = false
            self.saturatedTxt.isEnabled = false
            self.fatTxt.isEnabled = false
            self.choleTxt.isEnabled = false
            self.proteinTxt.isEnabled = true
            self.sodiumTxt.isEnabled = false
            self.sugarsTxt.isEnabled = false
            self.fibertxt.isEnabled = false
            let viewController = BarcodeScannerViewController()
            viewController.codeDelegate = self
            viewController.errorDelegate = self
            viewController.dismissalDelegate = self
            viewController.headerViewController.titleLabel.text = "Scan Product"
            viewController.headerViewController.closeButton.tintColor = AppColours.topBarGreen
            present(viewController, animated: true, completion: nil)
            
        }else {
            self.foodNameTxt.isEnabled = true
            self.brandNameTxt.isEnabled = true
            self.servingSizeTxt.isEnabled = true
            self.fatTxt.isEnabled = true
            self.caloriesTxt.isEnabled = true
            self.saturatedTxt.isEnabled = true
            self.fatTxt.isEnabled = true
            self.choleTxt.isEnabled = true
            self.proteinTxt.isEnabled = true
            self.sodiumTxt.isEnabled = true
            self.sugarsTxt.isEnabled = true
            self.fibertxt.isEnabled = true
        }
    }
    @objc func backBtnTapped(sender : UIButton){
           self.navigationController?.popViewController(animated: true)
       }
       @objc func saveBtnTapped(sender : UIButton){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        if self.servingSizeTxt.text?.count ?? 0 > 0 {
            if  Double(self.servingSizeTxt.text!)! == 0.0 {
                self.presentAlertWithTitle(title: "", message: "Please enter valid serving quantity", options: "OK") { (_) in
                    
                }
            }
            if self.foodNameTxt.text?.count ?? 0 > 0 && self.servingSizeTxt.text?.count ?? 0 > 0 && self.fatTxt.text?.count ?? 0 > 0 && self.carboTxt.text?.count ?? 0 > 0 && self.proteinTxt.text?.count ?? 0 > 0  && self.caloriesTxt.text?.count ?? 0 > 0 {
                let size = self.servingSizeTxt.text?.components(separatedBy: " ")
                let serving = (size?[0])!
                let calories = self.caloriesTxt.text?.components(separatedBy: " ")
                let calory = (calories?[0])!
                let fat = self.fatTxt.text?.components(separatedBy: " ")
                let fats = (fat?[0])!
                let satFat = saturatedTxt.text?.components(separatedBy: " ")
                let satuFat = (satFat?[0])!
                let chole = self.choleTxt.text?.components(separatedBy: " ")
                let cholest = (chole?[0])!
                let sodiums = self.sodiumTxt.text?.components(separatedBy: " ")
                let sodium = (sodiums?[0])!
                let totalCarb = self.carboTxt.text?.components(separatedBy: " ")
                let carbs = (totalCarb?[0])!
                let dFiber = self.fibertxt.text?.components(separatedBy: " ")
                let dfib = (dFiber?[0])!
                let sugurs = self.sugarsTxt.text?.components(separatedBy: " ")
                let dsug = (sugurs?[0])!
                let protien = proteinTxt.text?.components(separatedBy: " ")
                let dprot = (protien?[0])!
//                let protien = proteinTxt.text?.components(separatedBy: " ")
//                let dprot = (protien?[0])!
                
                let foodItem : NutritionixFoodData = NutritionixFoodData(food_name:  self.foodNameTxt.text!, serving_unit:  self.selectedFoodDetails?.serving_unit ?? "", nix_brand_id: self.selectedFoodDetails?.nix_brand_id, brand_name_item_name: self.selectedFoodDetails?.brand_name_item_name, serving_qty: Double(serving)!, nf_calories: Double(calory)!, photo: self.selectedFoodDetails?.photo, locale: "", brand_name: self.brandNameTxt.text ?? "", brand_type: self.selectedFoodDetails?.brand_type, region: self.selectedFoodDetails?.region, nix_item_id: self.selectedFoodDetails?.nix_item_id, nix_brand_name: self.selectedFoodDetails?.nix_brand_name, nix_item_name: self.selectedFoodDetails?.nix_item_name, serving_weight_grams: self.selectedFoodDetails?.serving_weight_grams, nf_total_fat: Double(fats), nf_saturated_fat: Double(satuFat), nf_cholesterol: Double(cholest), nf_sodium: Double(sodium), nf_total_carbohydrate: Double(carbs), nf_dietary_fiber: Double(dfib), nf_sugars: Double(dsug), nf_protein: Double(dprot), nf_potassium: self.selectedFoodDetails?.nf_potassium, nf_p: self.selectedFoodDetails?.nf_p, alt_measures: self.selectedFoodDetails?.alt_measures, upc: self.selectedUPC,time:(dateFormatter.string(from: NSDate() as Date)), createdBy:"trainee",foodStatus:"new")
                
                let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
                var authenticatedHeaders: [String: String] {
                    [
                        HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                        HeadersKeys.contentType: HeaderValues.json
                    ]
                }
                
                let postbody = AddNutritionixFoodPostBody(date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, mealType: self.mealType, foodItem: foodItem)

                let jsonEncoder = JSONEncoder()
                let jsonData = try! jsonEncoder.encode(postbody)

                GetDietByDateAPI.updateMealPlanAPI(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, methodName: "post", successHandler: { [weak self] (diet) in
                          print("diet is \(diet)")
                         // self?.dietView.diet = diet
                                          DispatchQueue.main.async {
                                          //   self?.dietView.reloadDietView()
                                             LoadingOverlay.shared.hideOverlayView()
                                             if diet == nil && diet?.mealplan == nil {
                                                 var message = "No data available for the selected date"
                                                 if messageString.count > 0 {
                                                     message = messageString
                                                 }

                                             }else {
                                                self?.navigationController?.popToRootViewController(animated: true)
                                            }

                                         }
                      }, errorHandler: {  error in
                              print(" error \(error)")
                              DispatchQueue.main.async {
                                  LoadingOverlay.shared.hideOverlayView()
                              }
                      })
            }else {
                self.presentAlertWithTitle(title: "", message: "Please Enter Required Fields", options: "OK") { (_) in
                    
                }
            }

        }
        
       
        
    }
    func addPaddingAndBorder(to textfield: UITextField) {
        textfield.layer.cornerRadius =  5
        textfield.layer.borderColor = AppColours.lineColor.cgColor
        textfield.layer.borderWidth = 0.5
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
   

}
extension FoodScanViewController : BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
      print(code)
        self.selectedUPC = code
        var authenticatedHeaders: [String: String] {
            [
                "x-app-id": "99a9215b",
               "x-app-key": "411f28ce68a972db7dec151444d8bcea",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
       DispatchQueue.main.async {
           LoadingOverlay.shared.showOverlay(view: self.view)
       }
           GetDietByDateAPI.getNutritionixFoodItemsByBarcode(header: authenticatedHeaders, searchString: self.selectedUPC, successHandler: { (foodDetails) in
              // self.foodArray = foodDetails
               print("fooddetails ae \(foodDetails)")
            DispatchQueue.main.async {
            if foodDetails?.foods?.count ?? 0 > 0 {
            let food = foodDetails?.foods![0]
                self.selectedFoodDetails = food
                if  food?.photo?.thumb != nil {
                    self.imgView.loadImage(url: URL(string: (food?.photo?.thumb)!)!)
                }
                self.foodNameTxt.text = food?.food_name ?? ""
                self.brandNameTxt.text = food?.brand_name ?? ""
                self.servingSizeTxt.text = String(format: "%.2f", food!.serving_qty)
                self.caloriesTxt.text = String(format: "%.2f", food!.nf_calories)
                self.fatTxt.text = String(format: "%.2f", food!.nf_total_fat ?? 0.0)
                self.saturatedTxt.text = String(format: "%.2f", food!.nf_saturated_fat ?? 0.0)
                self.choleTxt.text = String(format: "%.2f", food!.nf_cholesterol ?? 0.0)
                self.sodiumTxt.text = String(format: "%.2f", food!.nf_sodium ?? 0.0)
                self.carboTxt.text = String(format: "%.2f", food!.nf_total_carbohydrate ?? 0.0)
                self.fibertxt.text = String(format: "%.2f", food!.nf_dietary_fiber ?? 0.0)
                self.sugarsTxt.text = String(format: "%.2f", food!.nf_sugars ?? 0.0)
                self.proteinTxt.text = String(format: "%.2f", food!.nf_protein ?? 0.0)
                LoadingOverlay.shared.hideOverlayView()
            controller.dismiss(animated: false, completion: nil)
            }else {
                DispatchQueue.main.async {
                self.presentAlertWithTitle(title: "", message: "No data found", options: "OK") { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                }
            }
               }
              }, errorHandler: {  error in
                      print(" error \(error)")
                      DispatchQueue.main.async {
                          LoadingOverlay.shared.hideOverlayView()
                        controller.dismiss(animated: false, completion: nil)
                        self.presentAlertWithTitle(title: "", message: "No data found", options: "OK") { (_) in
                            self.navigationController?.popViewController(animated: true)
                        }
                      }
              })
      
    }
    func addFoodItemItem() {
        var authenticatedHeaders: [String: String] {
            [
                "x-app-id": "99a9215b",
               "x-app-key": "411f28ce68a972db7dec151444d8bcea",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
       DispatchQueue.main.async {
           LoadingOverlay.shared.showOverlay(view: self.view)
       }
           GetDietByDateAPI.getNutritionixFoodItemsByBarcode(header: authenticatedHeaders, searchString: "801541071005", successHandler: { (foodDetails) in
              // self.foodArray = foodDetails
               print("fooddetails ae \(foodDetails)")
            DispatchQueue.main.async {
            if foodDetails?.foods?.count ?? 0 > 0 {
            let food = foodDetails?.foods![0]
                self.selectedFoodDetails = food
                if  food?.photo?.thumb != nil {
                    self.imgView.loadImage(url: URL(string: (food?.photo?.thumb)!)!)
                }
                self.foodNameTxt.text = food?.food_name ?? ""
                self.brandNameTxt.text = food?.brand_name ?? ""
                self.servingSizeTxt.text = String(format: "%.2f", food!.serving_qty)
                self.caloriesTxt.text = String(format: "%.2f", food!.nf_calories)
                self.fatTxt.text = String(format: "%.2f", food!.nf_total_fat ?? 0.0)
                self.saturatedTxt.text = String(format: "%.2f", food!.nf_saturated_fat ?? 0.0)
                self.choleTxt.text = String(format: "%.2f", food!.nf_cholesterol ?? 0.0)
                self.sodiumTxt.text = String(format: "%.2f", food!.nf_sodium ?? 0.0)
                self.carboTxt.text = String(format: "%.2f", food!.nf_total_carbohydrate ?? 0.0)
                self.fibertxt.text = String(format: "%.2f", food!.nf_dietary_fiber ?? 0.0)
                self.sugarsTxt.text = String(format: "%.2f", food!.nf_sugars ?? 0.0)
                self.proteinTxt.text = String(format: "%.2f", food!.nf_protein ?? 0.0)
           }
               
                    LoadingOverlay.shared.hideOverlayView()
                 //  self.resTblView.reloadData()
               // controller.dismiss(animated: false, completion: nil)
               }
              }, errorHandler: {  error in
                      print(" error \(error)")
                      DispatchQueue.main.async {
                          LoadingOverlay.shared.hideOverlayView()
                       // controller.dismiss(animated: false, completion: nil)
                      }
              })
    }
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
      print(error)
    }
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            controller.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
      
    }
    
    func getFoodDetails(barcode:String){
         var authenticatedHeaders: [String: String] {
             [
                 "x-app-id": "99a9215b",
                "x-app-key": "411f28ce68a972db7dec151444d8bcea",
                 HeadersKeys.contentType: HeaderValues.json
             ]
         }
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: self.view)
        }
            GetDietByDateAPI.getNutritionixFoodItemsByBarcode(header: authenticatedHeaders, searchString: barcode, successHandler: { (foodDetails) in
               // self.foodArray = foodDetails
                print("fooddetails ae \(foodDetails)")
              //  self.foodItemsArray = foodDetails
                DispatchQueue.main.async {
                     LoadingOverlay.shared.hideOverlayView()
                  //  self.resTblView.reloadData()
                }
               }, errorHandler: {  error in
                       print(" error \(error)")
                       DispatchQueue.main.async {
                           LoadingOverlay.shared.hideOverlayView()
                       }
               })

    }
}
extension FoodScanViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text qty changed Details")
        if self.servingSizeTxt.text?.count ?? 0 > 0 && self.isFromBarcodeScanner {
            let qtySel : Double = Double(self.servingSizeTxt.text!)!
            var cal = self.selectedFoodDetails!.nf_calories / self.selectedFoodDetails!.serving_qty * qtySel
            var fat = self.selectedFoodDetails!.nf_total_fat! / self.selectedFoodDetails!.serving_qty * qtySel
            var carbo = self.selectedFoodDetails!.nf_total_carbohydrate! / self.selectedFoodDetails!.serving_qty * qtySel
            var prot = self.selectedFoodDetails!.nf_protein! / self.selectedFoodDetails!.serving_qty * qtySel
                self.caloriesTxt.text = String(format:"%.2f kcal", cal)
                self.fatTxt.text = String(format: "%.2f g", fat)
                self.carboTxt.text = String(format: " %.2f g", carbo)
                self.proteinTxt.text = String(format: " %.2f g", prot )
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.servingSizeTxt   {
            self.servingSizeTxt.text = ""
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.servingSizeTxt   {
            
            let maxLength = 4
               let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else {
            let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
        }
        //return true
    }
}
