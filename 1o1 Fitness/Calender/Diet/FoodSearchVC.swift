//
//  FoodSearchVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 28/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
enum NutritionixFoodType {
    case common
    case branded
}
class FoodSearchVC: UIViewController {
 var navigationView = NavigationView()
    var xBarHeight :CGFloat  = 0.0
    @IBOutlet weak var brandedBtn: UIButton!
    @IBOutlet weak var resTblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var commonBtn: UIButton!
    var foodArray : [PartialFoodDetails]?
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    var foodItemsArray : PartialNutritionixFoodData?
    var searchActive : Bool = false
     var mealType : String = ""
    var nuritionixFoodType : NutritionixFoodType = .common
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib1 = UINib(nibName: "SearchResTableViewCell", bundle: nil)
                         self.resTblView.register(nib1, forCellReuseIdentifier: "searchResCell")
               //   self.dietTblHeight.constant = self.dietTableView.contentSize.height
                  self.resTblView.tableFooterView = UIView()
               resTblView.separatorColor = AppColours.lineColor
               self.resTblView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        self.navigationController?.isNavigationBarHidden = false
                navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
               navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               navigationView.saveBtn.isHidden = true
       
               navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
               self.navigationController?.isNavigationBarHidden = true
       
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        searchBar.setImage(UIImage(named: "hover"), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 15.0
        self.searchBar.layer.borderColor = AppColours.textGreen.cgColor
        self.searchBar.layer.borderWidth = 0.5
        if #available(iOS 13.0, *) {
            self.searchBar.searchTextField.clearButtonMode = .whileEditing
            
        } else {
            // Fallback on earlier versions
        }
      //  self.searchBar.searchTextField.textColor = UIColor.white
        
        self.commonBtn.layer.cornerRadius = 5
        self.commonBtn.layer.borderWidth = 1
        self.commonBtn.backgroundColor = AppColours.textGreen
        self.commonBtn.layer.borderColor = AppColours.textGreen.cgColor
        self.commonBtn.setTitleColor(.black, for: .normal)
        
        self.brandedBtn.layer.cornerRadius = 5
        self.brandedBtn.layer.borderWidth = 1
        self.brandedBtn.backgroundColor = .clear
        self.brandedBtn.layer.borderColor = AppColours.textGreen.cgColor
        self.brandedBtn.setTitleColor(.white, for: .normal)
        self.brandedBtn.isHidden = false
        self.commonBtn.isHidden = false
      //  self.searchFoodItems()
        self.scanBtn.setTitleColor(AppColours.topBarGreen, for: .normal)
        self.addItem.setTitleColor(AppColours.topBarGreen, for: .normal)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.searchBar.text = ""
//        self.foodItemsArray = nil
//        self.resTblView.reloadData()
        self.navigationView.titleLbl.text  = self.mealType
    }
    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func saveBtnTapped(sender : UIButton){
    }

    @IBAction func brandedBtnTapped(_ sender: Any) {
        
        if self.brandedBtn.isSelected == true {
            self.brandedBtn.isSelected = false
            self.commonBtn.isSelected = true
            self.brandedBtn.backgroundColor = .clear
            self.brandedBtn.setTitleColor(.white, for: .normal)
            self.commonBtn.backgroundColor = AppColours.textGreen
            self.nuritionixFoodType = .common
            self.commonBtn.setTitleColor(.black, for: .normal)
            
        }else {
          self.commonBtn.isSelected = false
            self.nuritionixFoodType = .branded
            self.brandedBtn.isSelected = true
            self.brandedBtn.backgroundColor = AppColours.textGreen
            self.brandedBtn.setTitleColor(.black, for: .normal)
            self.commonBtn.backgroundColor = .clear
            self.commonBtn.setTitleColor(.white, for: .normal)
            
        }
        self.resTblView.reloadData()

    }
    @IBAction func commonBtnTapped(_ sender: Any) {
        
        if self.commonBtn.isSelected == true {
            self.commonBtn.isSelected = false
            self.brandedBtn.isSelected = true
            self.commonBtn.backgroundColor = .clear
            self.commonBtn.setTitleColor(.white, for: .normal)
            self.brandedBtn.backgroundColor = AppColours.textGreen
            self.brandedBtn.setTitleColor(.black, for: .normal)
            self.nuritionixFoodType = .branded
            
        }else {
          self.commonBtn.isSelected = true
            self.nuritionixFoodType = .common
            self.brandedBtn.isSelected = false
            self.commonBtn.backgroundColor = AppColours.textGreen
            self.commonBtn.setTitleColor(.black, for: .normal)
            self.brandedBtn.backgroundColor = .clear
            self.brandedBtn.setTitleColor(.white, for: .normal)
            
        }
        self.resTblView.reloadData()

    }
    @IBAction func manualBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FoodDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FoodScanViewController") as! FoodScanViewController
        controller.isFromBarcodeScanner = false
        controller.mealType = self.mealType
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func cameraScanTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "FoodDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FoodScanViewController") as! FoodScanViewController
        controller.mealType = self.mealType
        controller.isFromBarcodeScanner = true
        self.navigationController?.pushViewController(controller, animated: false)
    }
    @objc func searchFoodItems() {
     var authenticatedHeaders: [String: String] {
         [
             "x-app-id": "99a9215b",
            "x-app-key": "411f28ce68a972db7dec151444d8bcea",
             HeadersKeys.contentType: HeaderValues.json
         ]
     }
        var searchString = "full"
        if self.searchBar.text?.count != 0 {
            searchString = self.searchBar.text!
        }
        
        LoadingOverlay.shared.showOverlay(view: self.view)
        GetDietByDateAPI.getNutritionixFoodItems(header: authenticatedHeaders, searchString: searchString, successHandler: { (foodDetails) in
           // self.foodArray = foodDetails
            print("fooddetails ae \(foodDetails)")
            self.foodItemsArray = foodDetails
            DispatchQueue.main.async {
                 LoadingOverlay.shared.hideOverlayView()
                self.resTblView.reloadData()
            }
           }, errorHandler: {  error in
                   print(" error \(error)")
                   DispatchQueue.main.async {
                       LoadingOverlay.shared.hideOverlayView()
                   }
           })

   }

}
extension FoodSearchVC: UITableViewDelegate,UITableViewDataSource {

 func numberOfSections(in tableView: UITableView) -> Int {
     return 1
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // return 80
     return UITableView.automaticDimension
    }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
    switch self.nuritionixFoodType {
    case .common:
        return self.foodItemsArray?.common?.count ?? 0
    case .branded:
    return self.foodItemsArray?.branded?.count ?? 0
    default:
        return self.foodItemsArray?.common?.count ?? 0
    }
    //return self.foodArray?.count ?? 0
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResCell")
         as? SearchResTableViewCell
         else {
             return UITableViewCell()
     }
   // var foodDetails = self.foodArray![indexPath.row]
    
    
    switch self.nuritionixFoodType {
    case .common:
        let foodDetails = self.foodItemsArray?.common![indexPath.row]
        cell.foodName.text = foodDetails?.food_name
        cell.foodComName.text = ""
        cell.servingLbl.text = "\(foodDetails?.serving_qty ?? 0)  \(foodDetails?.serving_unit ?? "") "
    case .branded:
        let foodDetails = self.foodItemsArray?.branded![indexPath.row]
        cell.foodName.text = foodDetails?.food_name
        cell.foodComName.text = foodDetails?.brand_name
        cell.servingLbl.text =  "\(foodDetails?.serving_qty ?? 0)  \(foodDetails?.serving_unit ?? "") "
    default:
        print("")
    }
    
   
    cell.selectBtn.tag = indexPath.row
    cell.selectBtn.addTarget(self, action: #selector(foodSelected(sender:)), for: .touchUpInside)
     return cell
 }
 
 
 func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
     return 0;
 }
    @objc func foodSelected(sender : UIButton){
//         let foodDetails = self.foodArray![sender.tag]
//        let indexPath = NSIndexPath(row:sender.tag, section: 0)
//        let cell = self.resTblView.cellForRow(at: indexPath as IndexPath) as! SearchResTableViewCell
//        cell.selectBtn.setImage(UIImage(named: "cstatus"), for: .normal)
       // self.addFoodItem(foodCode: foodDetails.foodCode) // Commented by MM adding moved to details page
//        if cell.selectBtn.image(for: .normal) == UIImage(named: "cstatus") {
//             cell.selectBtn.setImage(UIImage(named: "gstatus"), for: .normal)
//        }else {
//
//        }
       
        
    }
//    func addFoodItem(foodCode:Int) {
//        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
//        var authenticatedHeaders: [String: String] {
//            [
//                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
//                HeadersKeys.contentType: HeaderValues.json
//            ]
//        }
//
//        let postbody = AddFoodItems(program_id: ProgramDetails.programDetails.programId, date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, mealType: self.mealType, foodCode: foodCode)
//
//              let jsonEncoder = JSONEncoder()
//              let jsonData = try! jsonEncoder.encode(postbody)
//
//        GetDietByDateAPI.updateMealPlanAPI(parameters: [:], header: authenticatedHeaders, dataParams: jsonData, methodName: "post", successHandler: { [weak self] (diet) in
//                  print("diet is \(diet)")
//                 // self?.dietView.diet = diet
//                                  DispatchQueue.main.async {
//                                  //   self?.dietView.reloadDietView()
//                                     LoadingOverlay.shared.hideOverlayView()
//                                     if diet == nil && diet?.mealplan == nil {
//                                         var message = "No data available for the selected date"
//                                         if messageString.count > 0 {
//                                             message = messageString
//                                         }
//
//                                     }else {
//                                       // self?.navigationController?.popToRootViewController(animated: true)
//                                    }
//
//                                 }
//              }, errorHandler: {  error in
//                      print(" error \(error)")
//                      DispatchQueue.main.async {
//                          LoadingOverlay.shared.hideOverlayView()
//                      }
//              })
//    }
    func getFoodDetailsForFoodItem() {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
        }
        let storyboard = UIStoryboard(name: "FoodDetailsVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FoodDetailsVC") as! FoodDetailsVC
        controller.xBarHeight = 80
        switch self.nuritionixFoodType {
        case .common:
            let foodDetails = self.foodItemsArray?.common![indexPath.row]
            controller.foodCode = ""
            controller.commonfoodItem = foodDetails
        case .branded:
            let foodDetails = self.foodItemsArray?.branded![indexPath.row]
            controller.foodCode = ""
            controller.brandedfoodItem = foodDetails
        default:
            print("")
        }
        
    // let foodDetails = self.foodArray![indexPath.row]
            
           // controller.foodCode = "\(foodDetails.foodCode)"
        controller.nuritionixFoodType = self.nuritionixFoodType
            controller.isFromSearch = true
            controller.mealType = self.mealType
            self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension FoodSearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
//        self.brandedBtn.isHidden = true
//        self.commonBtn.isHidden = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
//        self.brandedBtn.isHidden = true
//        self.commonBtn.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchFoodItems), object: nil)
        self.perform(#selector(searchFoodItems), with: nil, afterDelay: 0.5)

    }
    
}
