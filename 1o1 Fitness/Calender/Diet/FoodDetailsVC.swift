//
//  FoodDetailsVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire

class FoodDetailsVC: UIViewController {
    
    @IBOutlet weak var qtyInGrms: UILabel!
    @IBOutlet weak var proMacPer: UILabel!
    @IBOutlet weak var carMacPer: UILabel!
    @IBOutlet weak var fatMacPer: UILabel!
    @IBOutlet weak var horizontalBar: HorizontalBar!
    @IBOutlet weak var qtyTxtField: UnderlineTextField!
    @IBOutlet weak var proteinMacroWidth: NSLayoutConstraint!
    @IBOutlet weak var fatMacroWidth: NSLayoutConstraint!
    @IBOutlet weak var proteinMacro: UILabel!
    @IBOutlet weak var carboMacro: UILabel!
    @IBOutlet weak var fatMacro: UILabel!
    @IBOutlet weak var fiberPerLbl: UILabel!
    @IBOutlet weak var fiberLbl: UILabel!
    @IBOutlet weak var proteinPerLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    @IBOutlet weak var carboPerLbl: UILabel!
    @IBOutlet weak var carboLbl: UILabel!
    @IBOutlet weak var fatPerLbl: UILabel!
    @IBOutlet weak var fatLbl: UILabel!
    @IBOutlet weak var calValLbl: UILabel!
    @IBOutlet weak var macrosBgView: UIView!
    @IBOutlet weak var grmsBtn: UIButton!
    @IBOutlet weak var qtyValLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var servingLbl: UILabel!
    @IBOutlet weak var caloreLbl: UILabel!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var navigationView = NavigationView()
    var xBarHeight :CGFloat  = 0.0
    var foodItems : NutritionixFoodItems?
     var isFromSearch = false
    var foodCode : String = ""
     var mealType : String = ""
    var nuritionixFoodType : NutritionixFoodType = .common
    var commonfoodItem : PartialCommonFoodData?
    var brandedfoodItem : PartialBrandedFoodData?
    var selectedFoodDetails : NutritionixFoodData?
    
  let  dailyValueOfCarbohydrate = 300
   let dailyValueOfFat = 65
   let dailyValueOfFibre = 25
   let dailyValueOfProtein = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
                navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
               navigationView.titleLbl.text = "Food Details"
               navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
              
           navigationView.saveBtn.setTitle("Add", for: .normal)
               navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
               self.navigationController?.isNavigationBarHidden = true
        self.setUpView()
        self.fatMacro.backgroundColor = AppColours.graphBlue
        self.carboMacro.backgroundColor = AppColours.graphYello
        self.proteinMacro.backgroundColor = AppColours.topBarGreen
        self.imgView.layer.cornerRadius = 10.0
        imgView.layer.borderColor = AppColours.textGreen.cgColor
        imgView.layer.borderWidth = 0.8
        self.qtyTxtField.vUnderline.backgroundColor = AppColours.textGreen
        self.qtyTxtField.textColor = AppColours.textGreen
        
        self.horizontalBar.colors = [
            AppColours.graphBlue, // red
            AppColours.graphYello, // orange
            AppColours.appGreen
        ]
       // self.horizontalBar.values = [0.33, 0.33, 0.33]
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
    }
    
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func saveBtnTapped(sender : UIButton){
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
       
        
        let qtySel : Double = Double(self.qtyTxtField.text ?? "") ?? 0.0
          
            if qtySel == 0.0 {
                self.presentAlertWithTitle(title: "", message: "Please enter valid serving quantity", options: "OK") { (_) in
                    
                }
                
            }else {
                if self.isFromSearch == false {
                    
                    
                    let consumedFood = ConsumedFoodItems(refId: self.foodItems?.refId ?? 0, consumedQuantity: Double(self.qtyTxtField.text ?? "") ?? 0.0, consumedTime: self.foodItems?.consumedTime ?? self.foodItems?.time ?? "", foodStatus: WOStatus.complete)
                    let mealType = self.mealType
             
                let postbody = MealUpdatePostBoday(program_id: ProgramDetails.programDetails.programId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, mealType: mealType, consumedFoodItems: [consumedFood])
                let jsonEncoder = JSONEncoder()
                let jsonData = try! jsonEncoder.encode(postbody)
                
                GetDietByDateAPI.updateMealPlanAPI(parameters: [:], header: [:], dataParams: jsonData, methodName: "put", successHandler: { [weak self] (diet) in
                    print("diet is \(diet)")
                   // self?.dietView.diet = diet
                                    DispatchQueue.main.async {
                                      // self?.dietView.reloadDietView()
                                       LoadingOverlay.shared.hideOverlayView()
                                       if diet == nil && diet?.mealplan == nil {
                                           var message = "Food updating failed"
                                           if messageString.count > 0 {
                                               message = messageString
                                           }
                                         //  self?.dietView.diet = nil
//                                           self?.dietView.reloadDietView()
//                                           self?.dietView.displayNoDiet(message: message)
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
                } else {
                    var cal = self.selectedFoodDetails!.nf_calories / self.selectedFoodDetails!.serving_qty * qtySel
                    var fat = self.selectedFoodDetails!.nf_total_fat! / self.selectedFoodDetails!.serving_qty * qtySel
                    var carbo = self.selectedFoodDetails!.nf_total_carbohydrate! / self.selectedFoodDetails!.serving_qty * qtySel
                    var prot = self.selectedFoodDetails!.nf_protein! / self.selectedFoodDetails!.serving_qty * qtySel
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm"
                    
                    let foodItem : NutritionixFoodData = NutritionixFoodData(food_name:  self.selectedFoodDetails?.food_name ?? "", serving_unit:  self.selectedFoodDetails?.serving_unit ?? "", nix_brand_id: self.selectedFoodDetails?.nix_brand_id, brand_name_item_name: self.selectedFoodDetails?.brand_name_item_name, serving_qty: Double(self.qtyTxtField.text ?? "") ?? 0.0, nf_calories: cal, photo: self.selectedFoodDetails?.photo, locale: "", brand_name: self.selectedFoodDetails?.brand_name ?? "", brand_type: self.selectedFoodDetails?.brand_type, region: self.selectedFoodDetails?.region, nix_item_id: self.selectedFoodDetails?.nix_item_id, nix_brand_name: self.selectedFoodDetails?.nix_brand_name, nix_item_name: self.selectedFoodDetails?.nix_item_name, serving_weight_grams: self.selectedFoodDetails?.serving_weight_grams, nf_total_fat: fat, nf_saturated_fat: self.selectedFoodDetails?.nf_saturated_fat ?? 0.0, nf_cholesterol: self.selectedFoodDetails?.nf_sugars ?? 0.0, nf_sodium: self.selectedFoodDetails?.nf_cholesterol ?? 0.0, nf_total_carbohydrate: carbo, nf_dietary_fiber: self.selectedFoodDetails?.nf_dietary_fiber ?? 0.0, nf_sugars: self.selectedFoodDetails?.nf_sugars ?? 0.0, nf_protein: prot, nf_potassium: self.selectedFoodDetails?.nf_potassium, nf_p: self.selectedFoodDetails?.nf_p, alt_measures: self.selectedFoodDetails?.alt_measures, upc: self.selectedFoodDetails?.upc ?? "",time:(dateFormatter.string(from: NSDate() as Date)), createdBy:"trainee",foodStatus:"new")
                   
                   
                  
                    
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
                }
               
            }
    }
   
    func setUpView() {
        if self.isFromSearch {
            self.qtyTxtField.isEnabled = true
             navigationView.saveBtn.isHidden = false
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            var authenticatedHeaders: [String: String] {
                [
                    HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                    HeadersKeys.contentType: HeaderValues.json
                ]
            }

               LoadingOverlay.shared.showOverlay(view: self.view)
            self.getNutritionixData()

            
        }else {
            navigationView.saveBtn.isHidden = false
            self.qtyTxtField.isEnabled = true
            if  self.foodItems?.photo != nil {
                self.imgView.loadImage(url: URL(string: (foodItems!.photo?.thumb)!)!)
             }
             self.foodNameLbl.text = self.foodItems?.food_name ?? ""
            
            // self.servingLbl.text = self.foodItems!.units
            self.grmsBtn.setTitle(self.foodItems!.serving_unit, for: .normal)
            
            self.fatLbl.text = "Fat \(self.foodItems!.nf_total_fat!.recommended)g"
           
             self.carboLbl.text = "Carbohydrate \(self.foodItems!.nf_total_carbohydrate!.recommended)g"
                 
             self.proteinLbl.text = "Protein \(self.foodItems!.nf_protein!.recommended)g"
                   // self.proteinPerLbl.text = "\(self.foodItems!.dailyValues!.p)g"
             self.fiberLbl.text = "Fiber \(self.foodItems!.nf_dietary_fiber!.recommended)g"
            
            self.grmsBtn.setTitle(self.foodItems!.serving_unit, for: .normal)
                   
            if self.foodItems?.foodStatus == WOStatus.complete {
              
                self.qtyTxtField.text = "\(self.foodItems!.serving_qty!.consumed)"
                self.caloreLbl.text = "\(self.foodItems!.nf_calories!.consumed) kcal"
                self.calValLbl.text = "\(self.foodItems!.nf_calories!.consumed) kcal"
                   self.carboPerLbl.text = "\(self.foodItems!.dailyValues?.carboHydrate_consumed ?? 0)%"
                  self.fatPerLbl.text = "\(self.foodItems!.dailyValues?.fat_consumed ?? 0)%"
                 self.fiberPerLbl.text = "\(self.foodItems!.dailyValues?.fibre_consumed ?? 0)%"
                self.fatMacroWidth.constant = (CGFloat(self.foodItems?.macros?.fat_consumed ?? 0)/self.macrosBgView.frame.size.width) * 100
                self.fatMacro.text = "\(self.foodItems?.macros?.fat_consumed ?? 0)"
                self.proteinMacroWidth.constant = (CGFloat(self.foodItems?.macros?.protein_consumed ?? 0)/self.macrosBgView.frame.size.width) * 100
                 self.proteinMacro.text = "\(self.foodItems?.macros?.protein_consumed ?? 0)"
                 self.carboMacro.text = "\(self.foodItems?.macros?.carboHydrate_consumed ?? 0)"
                
                let fat = (CGFloat(self.foodItems?.macros?.fat_recommended ?? 0)/100)
                let carbo = (CGFloat(self.foodItems?.macros?.carboHydrate_recommended ?? 0)/100)
                let prot = (CGFloat(self.foodItems?.macros?.protein_recommended ?? 0)/100)
                self.horizontalBar.values = [fat, carbo,prot]
                self.fatMacPer.text = String(format:"(%.0f %%)",fat*100)
                self.carMacPer.text = String(format:"(%.0f %%)",carbo*100)
                self.proMacPer.text = String(format:"(%.0f %%)",prot*100)
                self.qtyInGrms.text = String(format:"%.0f",(self.foodItems?.serving_weight_grams?.consumed ?? 0))
                
            }else {
                self.caloreLbl.text = "\(self.foodItems!.nf_calories!.recommended) kcal"
                self.calValLbl.text = "\(self.foodItems!.nf_calories!.recommended) kcal"
                self.qtyTxtField.text = "\(self.foodItems!.serving_qty!.recommended)"
                   self.carboPerLbl.text = "\(self.foodItems!.dailyValues?.carboHydrate_recommended ?? 0)%"
                  self.fatPerLbl.text = "\(self.foodItems!.dailyValues?.fat_recommended ?? 0)%"
                 self.fiberPerLbl.text = "\(self.foodItems!.dailyValues?.fibre_recommended ?? 0)%"
                let fatconstant = self.macrosBgView.frame.width*(CGFloat(self.foodItems?.macros?.fat_recommended ?? 0)/100)
                self.fatMacroWidth.constant = fatconstant
               // self.fatMacroWidth.constant = (CGFloat(self.foodItems?.macros?.fat_recommended ?? 0)/self.macrosBgView.frame.size.width) * 100
             //    self.proteinMacroWidth.constant = (CGFloat(self.foodItems?.macros?.protein_recommended ?? 0)/self.macrosBgView.frame.size.width) * 100
                
                let proteinConstant = self.macrosBgView.frame.width*(CGFloat(self.foodItems?.macros?.protein_recommended ?? 0)/100)
                               self.proteinMacroWidth.constant = proteinConstant
                self.proteinMacro.text = "\(self.foodItems?.macros?.protein_recommended ?? 0)"
                self.carboMacro.text = "\(self.foodItems?.macros?.carboHydrate_recommended ?? 0)"
                 self.fatMacro.text = "\(self.foodItems?.macros?.fat_recommended ?? 0)"
                self.qtyInGrms.text = String(format:"%.0f",(self.foodItems?.serving_weight_grams?.recommended ?? 0))
                
                let fat = (CGFloat(self.foodItems?.macros?.fat_recommended ?? 0)/100)
                let carbo = (CGFloat(self.foodItems?.macros?.carboHydrate_recommended ?? 0)/100)
                let prot = (CGFloat(self.foodItems?.macros?.protein_recommended ?? 0)/100)
                self.horizontalBar.values = [fat, carbo,prot]
                
                self.fatMacPer.text = String(format:"(%.0f %%)",fat*100)
                self.carMacPer.text = String(format:"(%.0f %%)",carbo*100)
                self.proMacPer.text = String(format:"(%.0f %%)",prot*100)
                
            }
             self.updateViewConstraints()
        }
        
    }
    @IBAction func grmsBtnTapped(_ sender: Any) {
        if self.isFromSearch {
            if self.selectedFoodDetails?.alt_measures?.count ?? 0 > 0 {
                let storyboard = UIStoryboard(name: "ProfileMenuVC", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
                controller.popType = .foodQuantity
                controller.foodQtyArr = self.selectedFoodDetails?.alt_measures
                controller.foodPickerDelegate = self
                controller.modalPresentationStyle = .custom
                controller.transitioningDelegate = self
                controller.view.backgroundColor = UIColor.black
                self.present(controller, animated: true, completion: nil)
            }
            
        }
        
    }
    func getNutritionixData() {
        let window = UIApplication.shared.windows.first!
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        var authenticatedHeaders: [String: String] {
            [
                "x-app-id": "99a9215b",
               "x-app-key": "411f28ce68a972db7dec151444d8bcea",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        if self.nuritionixFoodType == .common {
            let query = "\(self.commonfoodItem!.serving_qty) " + "\(self.commonfoodItem!.serving_unit) " + self.commonfoodItem!.food_name
         //   let postBody : [String: Any] = ["query": query]
            self.getCommonFoodDetails(query: query)  { (foodDetails) in
                print("food Details \(foodDetails)")
                DispatchQueue.main.async { [self] in
                     LoadingOverlay.shared.hideOverlayView()
                     print(" error \(foodDetails)")
                    if foodDetails?.foods?.count ?? 0 > 0 {
                    let food = foodDetails?.foods![0]
                        self.selectedFoodDetails = food
                        if  food?.photo?.thumb != nil {
                            self.imgView.loadImage(url: URL(string: (food?.photo?.thumb)!)!)
                        }
                        self.foodNameLbl.text = food?.food_name ?? ""
                        self.caloreLbl.text = "\(food!.nf_calories) kcal"
                        self.calValLbl.text = "\(food!.nf_calories) kcal"
                        self.fatLbl.text = "Fat \(food!.nf_total_fat!)g"
                        self.carboLbl.text = "Carbohydrate \(food!.nf_total_carbohydrate!)g"
                        self.proteinLbl.text = "Protein \(food!.nf_protein!)g"
                        self.grmsBtn.setTitle(food?.serving_unit ?? "", for: .normal)
                        self.qtyTxtField.text = "\(food?.serving_qty ?? 0)"
                        let totalMacro = (food!.nf_total_carbohydrate! * 4) + (food!.nf_protein! * 4) + (food!.nf_total_fat! * 9)
                        let fatPer = CGFloat((food!.nf_total_fat! * 9)/totalMacro)
                        let protPer = CGFloat((food!.nf_protein! * 4)/totalMacro)
                        let carbo : CGFloat = 1 - (fatPer + protPer)
                        self.horizontalBar.values = [fatPer, carbo,protPer]
                        self.fatMacPer.text = String(format:"(%.0f %%)",fatPer*100)
                        self.carMacPer.text = String(format:"(%.0f %%)",carbo*100)
                        self.proMacPer.text = String(format:"(%.0f %%)",protPer*100)
                        
                        let dvCarbs = (Int(food!.nf_total_carbohydrate!*100)/self.dailyValueOfCarbohydrate)
                        let dvFat = (Int(food!.nf_total_fat!*100)/self.dailyValueOfCarbohydrate)
                        let dvProtein = (Int(food!.nf_protein!*100)/self.dailyValueOfCarbohydrate)
                        
                        self.fatPerLbl.text = String("\(dvFat)%")
                        self.carboPerLbl.text = String("\(dvCarbs)%")
                        self.proteinPerLbl.text = String("\(dvProtein)%")
                        self.qtyInGrms.text = String(format:"%.0f",(food?.serving_weight_grams ?? 0))

                   }
                }
            } errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self.presentAlertWithTitle(title: "", message: error, options: "OK") {_ in
                        self.navigationController?.popViewController(animated: false)
                    }
                    
                }
        }

          /*  GetDietByDateAPI.getNutritionixCommomFoodDetails(header: authenticatedHeaders, dataParams: data,  successHandler: { (foodDetails) in
                print("food Details \(foodDetails)")
//             DispatchQueue.main.async {
//                  LoadingOverlay.shared.hideOverlayView()
//                  print(" error \(foodDetails)")
//                if foodDetails != nil {
//                    if  foodDetails?.imgUrl != nil {
//                         self.imgView.loadImage(url: URL(string: foodDetails!.imgUrl)!)
//                     }
//                    self.foodNameLbl.text = foodDetails!.foodName
//                     self.caloreLbl.text = "\(foodDetails!.energy!.recommended) kcal"
//                     self.calValLbl.text = "\(foodDetails!.energy!.recommended) kcal"
//                    // self.servingLbl.text = foodDetails!.units
//                     self.grmsBtn.setTitle(foodDetails!.units, for: .normal)
//                     self.qtyValLbl.text = "\(foodDetails!.actualQuantity)"
//                     self.fatLbl.text = "Fat \(foodDetails!.totalFat!.recommended)g"
//                    // self.fatPerLbl.text = "\(self.foodItems!.totalFat!.recommended)g"
//                     self.carboLbl.text = "Carbohydrate \(foodDetails!.carboHydrate!.recommended)g"
//                          //  self.carboPerLbl.text = "\(self.foodItems!.totalFat!.recommended)g"
//                     self.proteinLbl.text = "Protein \(foodDetails!.protein!.recommended)g"
//                         //   self.proteinPerLbl.text = "\(self.foodItems!.totalFat!.recommended)g"
//                     self.fiberLbl.text = "Fiber \(foodDetails!.totalFibre!.recommended)g"
//                           // self.fiberPerLbl.text = "\(self.foodItems!.totalFat!.recommended)g"
//                    self.carboPerLbl.text = "\(foodDetails!.dailyValues?.carboHydrate_recommended ?? 0)%"
//                     self.fatPerLbl.text = "\(foodDetails!.dailyValues?.fat_recommended ?? 0)%"
//                    self.fiberPerLbl.text = "\(foodDetails!.dailyValues?.fibre_recommended ?? 0)%"
//                   // self.fatMacroWidth.constant = (CGFloat(foodDetails?.macors?.fat_recommended ?? 0)/self.macrosBgView.frame.size.width) * 100
//
//                    let fatconstant = self.macrosBgView.frame.width*(CGFloat(foodDetails?.macors?.fat_recommended ?? 0)/100)
//                    self.fatMacroWidth.constant = fatconstant
//                    let proteinConstant = self.macrosBgView.frame.width*(CGFloat(foodDetails?.macors?.protein_recommended ?? 0)/100)
//                                                  self.proteinMacroWidth.constant = proteinConstant
//                  //  self.proteinMacroWidth.constant = (CGFloat(foodDetails?.macors?.protein_recommended ?? 0)/self.macrosBgView.frame.size.width) * 100
//                    self.updateViewConstraints()
//                    self.proteinMacro.text = "\(foodDetails?.macors?.protein_recommended ?? 0)"
//                                   self.carboMacro.text = "\(foodDetails?.macors?.carboHydrate_recommended ?? 0)"
//                                    self.fatMacro.text = "\(foodDetails?.macors?.protein_recommended ?? 0)"
//                }
//             }
            }, errorHandler: {  error in
                    print(" error \(error)")
                    DispatchQueue.main.async {
                        LoadingOverlay.shared.hideOverlayView()
                    }
            })*/
        }else {
            GetDietByDateAPI.getNutritionixBrandedFoodDetails(header: authenticatedHeaders, nixID: (self.brandedfoodItem?.nix_item_id)!) { (foodDetails) in
                print("food Details \(foodDetails)")
                DispatchQueue.main.async {
                     LoadingOverlay.shared.hideOverlayView()
                     print(" error \(foodDetails)")
                    if foodDetails?.foods?.count ?? 0 > 0 {
                    let food = foodDetails?.foods![0]
                        self.selectedFoodDetails = food
                        if  food?.photo?.thumb != nil {
                            self.imgView.loadImage(url: URL(string: (food?.photo?.thumb)!)!)
                        }
                        self.foodNameLbl.text = food?.food_name ?? ""
                        self.caloreLbl.text = "\(food!.nf_calories) kcal"
                        self.calValLbl.text = "\(food!.nf_calories) kcal"
                        self.fatLbl.text = "Fat \(food!.nf_total_fat!)g"
                        self.carboLbl.text = "Carbohydrate \(food!.nf_total_carbohydrate!)g"
                        self.proteinLbl.text = "Protein \(food!.nf_protein!)g"
                        self.grmsBtn.setTitle(food?.serving_unit ?? "", for: .normal)
                        self.qtyTxtField.text = "\(food?.serving_qty ?? 0)"
                        let totalMacro = (food!.nf_total_carbohydrate! * 4) + (food!.nf_protein! * 4) + (food!.nf_total_fat! * 9)
                        let fatPer = CGFloat((food!.nf_total_fat! * 9)/totalMacro)
                        let protPer = CGFloat((food!.nf_protein! * 4)/totalMacro)
                        let carbo : CGFloat = 1 - (fatPer + protPer)
                        self.horizontalBar.values = [fatPer, carbo,protPer]
                        self.fatMacPer.text = String(format:"(%.0f %%)",fatPer*100)
                        self.carMacPer.text = String(format:"(%.0f %%)",carbo*100)
                        self.proMacPer.text = String(format:"(%.0f %%)",protPer*100)
                        
                        let dvCarbs = (Int(food!.nf_total_carbohydrate!*100)/self.dailyValueOfCarbohydrate)
                        let dvFat = (Int(food!.nf_total_fat!*100)/self.dailyValueOfCarbohydrate)
                        let dvProtein = (Int(food!.nf_protein!*100)/self.dailyValueOfCarbohydrate)
                        
                        self.fatPerLbl.text = String("\(dvFat)%")
                        self.carboPerLbl.text = String("\(dvCarbs)%")
                        self.proteinPerLbl.text = String("\(dvProtein)%")
                        self.qtyInGrms.text = String(format:"%.0f",(food?.serving_weight_grams ?? 0))



                   }
                }
            } errorHandler: {  error in
                print(" error \(error)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
        }

        }
        
    }
    func getCommonFoodDetails(query: String,successHandler: @escaping (FullNutritionixFoodData?) -> Void,
                                      errorHandler: @escaping (String) -> Void)  {
        
        var authenticatedHeaders: [String: String] {
            [
                "x-app-id": "99a9215b",
               "x-app-key": "411f28ce68a972db7dec151444d8bcea",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
       // let query = "\(self.commonfoodItem!.serving_qty) " + "\(self.commonfoodItem!.serving_unit)" + self.commonfoodItem!.food_name
        let postBody : [String: Any] = ["query": query]
                  
                   let urlString = getNutrionixCommonFoodDetails
                   guard let url = URL(string: urlString) else {return}
                   var request        = URLRequest(url: url)
                   request.httpMethod = "Post"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.setValue("99a9215b", forHTTPHeaderField: "x-app-id")
                    request.setValue("411f28ce68a972db7dec151444d8bcea", forHTTPHeaderField: "x-app-key")
                   do {
                       request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
                   } catch let error {
                       print("Error : \(error.localizedDescription)")
                   }

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
                                    if json is NSNull {
                                           
                                        if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                             messageString = (jsonMessage as? String)!
                                             //  self.nodataLbl.text = messageString
                                         }
                                        // self.photosArr = nil
                                         successHandler(nil)
                                           
                                       }else {
                                           let jsonData = try JSONSerialization.data(withJSONObject: json as Any,
                                                                                     options: .prettyPrinted)
                                           let foodDetails = try JSONDecoder().decode(FullNutritionixFoodData?.self, from: jsonData)
                                           successHandler(foodDetails)
                                       }
                                   
                               }else {
                                   if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                       messageString = (jsonMessage as? String)!
                                       
                                       errorHandler(messageString)
                                   }
                               } }catch let error {
                                 
                                   errorHandler("Fetching the food details failed")
                           }
                       }
                        case 500:
                            if let json = response.result.value as? [String: Any] {
                            if let jsonMessage = json[ResponseKeys.message.rawValue] {
                                messageString = (jsonMessage as? String)!
                                
                                errorHandler(messageString)
                            }
                            }else {
                                errorHandler(response.result.description)
                            }
                            
                   default:
                    if let json = response.result.value as? [String: Any] {
                    if let jsonMessage = json[ResponseKeys.message.rawValue] {
                        messageString = (jsonMessage as? String)!
                        
                        errorHandler(messageString)
                    }
                    }else {
                        errorHandler("Fetching food details failed")
                    }

                   }
               }
           }
       }

}
extension FoodDetailsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.qtyTxtField   {
            self.qtyTxtField.text = ""
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.qtyTxtField   {
            let maxLength = 4
               let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text qty changed Details")
        if self.qtyTxtField.text?.count ?? 0 > 0  {
            if self.isFromSearch == true {
                let qtySel : Double = Double(self.qtyTxtField.text ?? "") ?? 0.0
                let cal = self.selectedFoodDetails!.nf_calories / self.selectedFoodDetails!.serving_qty * qtySel
                let fat = self.selectedFoodDetails!.nf_total_fat! / self.selectedFoodDetails!.serving_qty * qtySel
                let carbo = self.selectedFoodDetails!.nf_total_carbohydrate! / self.selectedFoodDetails!.serving_qty * qtySel
                let prot = self.selectedFoodDetails!.nf_protein! / self.selectedFoodDetails!.serving_qty * qtySel
                    self.caloreLbl.text = String(format: "%.2f kcal", cal)
                    self.calValLbl.text = String(format: "%.2f kcal", cal)
                    self.fatLbl.text = String(format: "Fat %.2f g", fat)
                    self.carboLbl.text = String(format: "Carbohydrate %.2f g", carbo)
                    self.proteinLbl.text = String(format: "Protein %.2f g", prot )
                self.qtyInGrms.text = String(format:"%.0f",(self.selectedFoodDetails!.serving_weight_grams ?? 0) / self.selectedFoodDetails!.serving_qty * qtySel)
            }else {
                
                let qtySel : Float = Float(self.qtyTxtField.text ?? "") ?? 0.0
                if self.foodItems?.foodStatus == WOStatus.complete {
                    let cal = self.foodItems!.nf_calories!.consumed / (self.foodItems!.serving_qty?.consumed)! * qtySel
                    let fat = self.foodItems!.nf_total_fat!.consumed / (self.foodItems!.serving_qty?.consumed)! * qtySel
                    let carbo = self.foodItems!.nf_total_carbohydrate!.consumed / (self.foodItems!.serving_qty?.consumed)! * qtySel
                    let prot = self.foodItems!.nf_protein!.consumed / (self.foodItems!.serving_qty?.consumed)! * qtySel
                        self.caloreLbl.text = String(format: "%.2f kcal", cal)
                        self.calValLbl.text = String(format: "%.2f kcal", cal)
                        self.fatLbl.text = String(format: "Fat %.2f g", fat)
                        self.carboLbl.text = String(format: "Carbohydrate %.2f g", carbo)
                        self.proteinLbl.text = String(format: "Protein %.2f g", prot )
                    self.qtyInGrms.text = String(format:"%.0f",(self.foodItems!.serving_weight_grams?.consumed ?? 0) / (self.foodItems!.serving_qty?.consumed)! * qtySel)
                    
                }else {
                    let cal = self.foodItems!.nf_calories!.recommended / (self.foodItems!.serving_qty?.recommended)! * qtySel
                    let fat = self.foodItems!.nf_total_fat!.recommended / (self.foodItems!.serving_qty?.recommended)! * qtySel
                    let carbo = self.foodItems!.nf_total_carbohydrate!.recommended / (self.foodItems!.serving_qty?.recommended)! * qtySel
                    let prot = self.foodItems!.nf_protein!.recommended / (self.foodItems!.serving_qty?.recommended)! * qtySel
                        self.caloreLbl.text = String(format: "%.2f kcal", cal)
                        self.calValLbl.text = String(format: "%.2f kcal", cal)
                        self.fatLbl.text = String(format: "Fat %.2f g", fat)
                        self.carboLbl.text = String(format: "Carbohydrate %.2f g", carbo)
                        self.proteinLbl.text = String(format: "Protein %.2f g", prot )
                    self.qtyInGrms.text = String(format:"%.0f",(self.foodItems!.serving_weight_grams?.recommended ?? 0) / (self.foodItems!.serving_qty?.recommended)! * qtySel)
                    
                }
                
               
            }
            
        }
    }
}
extension FoodDetailsVC : FoodQuantityChangedDelegate ,UIViewControllerTransitioningDelegate{
    func foodQtyChanged(measures :AlternateMeasures) {
//        DispatchQueue.main.async {
//        self.grmsBtn.setTitle(qty, for: .normal)
//        }
        let query = "\(measures.measure) " + "\(measures.qty) " + self.commonfoodItem!.food_name
        self.getCommonFoodDetails(query: query) { (foodDetails) in
            
            DispatchQueue.main.async {
                 LoadingOverlay.shared.hideOverlayView()
                 print(" error \(foodDetails)")
                if foodDetails?.foods?.count ?? 0 > 0 {
                let food = foodDetails?.foods![0]
                    self.selectedFoodDetails = food
                    if  food?.photo?.thumb != nil {
                        self.imgView.loadImage(url: URL(string: (food?.photo?.thumb)!)!)
                    }
                    self.foodNameLbl.text = food?.food_name ?? ""
                    self.caloreLbl.text = "\(food!.nf_calories) kcal"
                    self.calValLbl.text = "\(food!.nf_calories) kcal"
                    self.fatLbl.text = "Fat \(food!.nf_total_fat!)g"
                    self.carboLbl.text = "Carbohydrate \(food!.nf_total_carbohydrate!)g"
                    self.proteinLbl.text = "Protein \(food!.nf_protein!)g"
                    self.grmsBtn.setTitle(food?.serving_unit ?? "", for: .normal)
                    self.qtyTxtField.text = "\(food?.serving_qty ?? 0)"

               }
            }
        } errorHandler: {  error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                self.presentAlertWithTitle(title: "", message: error, options: "OK") {_ in
                    self.navigationController?.popViewController(animated: false)
                }
                
            }
    }

    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
}
