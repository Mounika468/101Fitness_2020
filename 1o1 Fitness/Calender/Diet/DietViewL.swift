//
//  DietViewL.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 27/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import KYCircularProgress
protocol DietSelectionDelegate {
    func selectedDietOption()
    func addFoodSelected(dietSelected:DietSelection)
    func completeFoodItem(index:Int, dietSelection: DietSelection, foodItems:NutritionixFoodItems, quantity:Double)
    func foodDetailsSelected(foodItems:NutritionixFoodItems, dietSelection:DietSelection)
    func setParentViewHeight(height: CGFloat)
    func timePickerSelected(index:Int, dietSelection: DietSelection, foodItems:NutritionixFoodItems, quantity:Double)
    func deleteFoodItem(dietSelection: DietSelection, foodItems:NutritionixFoodItems)
}
enum DietSelection {
    case breakFast
    case lunch
    case dinner
    case snack1
    case water
}
enum WaterSelection {
    case ml250
    case ml500
    case ml750
   
}
class DietViewL: UIView {
    
    @IBOutlet weak var tbleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var carbsLbl: UILabel!
    
    @IBOutlet weak var mlLbl: UILabel!
    @IBOutlet weak var fatLbl: UILabel!
    @IBOutlet weak var proteinLbl: UILabel!
    
    @IBOutlet weak var waterView: UIView!
    
    @IBOutlet weak var qty750Lbl: UILabel!
    @IBOutlet weak var qty500Lbl: UILabel!
    @IBOutlet weak var qty250Lbl: UILabel!
    @IBOutlet weak var qty750Btn: UIButton!
    @IBOutlet weak var qty500Btn: UIButton!
    @IBOutlet weak var qty250Btn: UIButton!
    @IBOutlet weak var waterQtyLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var jugImgView: UIImageView!
    @IBOutlet weak var lastUpdateLbl: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var glassBtn: UIButton!
    @IBOutlet weak var dinnerBtn: UIButton!
    @IBOutlet weak var snackBtn: UIButton!
    @IBOutlet weak var lunchBtn: UIButton!
    @IBOutlet weak var bfBtn: UIButton!
    @IBOutlet weak var addFoodBtn: UIButton!
    @IBOutlet weak var foodTblView: UITableView!
    @IBOutlet weak var selfDietBtn: UIButton!
    @IBOutlet weak var findDietLbl: UILabel!
  //  @IBOutlet weak var semiCircle: SemiCircleView!
   var diet : Diet?
    @IBOutlet weak var semiCircle: UIView!
    var foodItemsArr : [NutritionixFoodItems]?
       var dietSelection : DietSelection = .breakFast
    var dietviewDelegate: DietSelectionDelegate?
    private var halfCircularProgress: KYCircularProgress!
    private var halfCircularProgress1: KYCircularProgress!
    private var halfCircularProgress2: KYCircularProgress!
    private var  consumedEnergyLbl : UILabel!
    private var  recomEnergyLbl : UILabel!
     private var  ofLbl : UILabel!
    var selectedTimeIndex : NSIndexPath?
    var editedQuantity : Double = 1.0
    var selectedWaterQty : Int = 250
    var selectedWater : WaterSelection = .ml250
       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
            commonInit()
       }
       private func  commonInit()
       {
           Bundle.main.loadNibNamed("DietViewL", owner: self, options: nil)
           addSubview(bgView)
           bgView.frame = self.bounds
           bgView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           
         
           
           
           let nib1 = UINib(nibName: "DietListTableViewCell", bundle: nil)
                  self.foodTblView.register(nib1, forCellReuseIdentifier: "dietListCell")
        //   self.dietTblHeight.constant = self.dietTableView.contentSize.height
           self.foodTblView.tableFooterView = UIView()
        foodTblView.separatorColor = AppColours.lineColor
        self.foodTblView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//            self.dietTableView.estimatedRowHeight = CGFloat(500.0)
//            self.dietTableView.rowHeight = UITableView.automaticDimension
//            self.dietTableView.alwaysBounceVertical = false
        self.lastUpdateLbl.textColor = AppColours.graphBlue
        self.qty250Lbl.textColor = AppColours.graphBlue
        self.qty500Lbl.textColor = AppColours.graphBlue
        self.qty750Lbl.textColor = AppColours.graphBlue
         configureHalfCircularProgress()
        self.waterQtyLbl.text = "0"
       }
    func reloadDietView() {
        self.numberOfRows()
        self.nodataLbl.isHidden = true
        self.foodTblView.reloadData()
         self.tbleHeightConstraint.constant = CGFloat((self.foodItemsArr?.count ?? 0) * 110 + 40)
        let height = self.foodTblView.frame.minY + self.tbleHeightConstraint.constant
        if self.dietSelection == .water {
            self.dietviewDelegate?.setParentViewHeight(height: 1000)
            let water = self.diet?.mealplan?.waterConsumed
            if water != nil {
                self.waterQtyLbl.text = "\(water!.consumed)"
                self.mlLbl.isHidden = false
                if water?.consumed ?? 0 == 0 {
                    self.jugImgView.image = UIImage(named: "nowater")
                }else {
                    let imageName =  "\(water!.consumed)"
                    self.jugImgView.image = UIImage(named: String(imageName))
                }
               
                let dob = String(water!.lastUpdatedOn.prefix(10)) as String
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: dob)
                let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
              // self.dob.setTitle(date1, for: .normal)
                
                self.lastUpdateLbl.text = "Last Update \(date1)"
            }else {
                self.jugImgView.image = UIImage(named: "nowater")
                self.waterQtyLbl.text = ""
                self.mlLbl.isHidden = true
            }
        }else {
             self.dietviewDelegate?.setParentViewHeight(height: height)
        }
      //  self.addFoodBtn.isHidden = false
        self.foodTblView.isHidden = false
        if self.foodItemsArr == nil || self.foodItemsArr?.count == 0 {
           //  self.addFoodBtn.isHidden = true
            self.foodTblView.isHidden = true
            if messageString.count > 0 {
                 self.displayNoDiet(message: messageString)
            }else {
                 self.displayNoDiet(message: "No Mealplan planned on the selected date.")
            }
           
        }
        if self.diet?.mealplan != nil {
            self.ofLbl.text = "of"
            self.carbsLbl.text = String(format: " Carbo %.2f g/%.2f g", self.diet!.mealplan!.overall_carboHydrate_consumed,self.diet!.mealplan!.overall_carboHydrate_recommended)
            self.proteinLbl.text = String(format: " Protein %.2f g/%.2f g", self.diet!.mealplan!.overall_protein_consumed,self.diet!.mealplan!.overall_protein_recommended)
            self.fatLbl.text = String(format: " Fat %.2f g/%.2f g", self.diet!.mealplan!.overall_fat_consumed,self.diet!.mealplan!.overall_fat_recommended)
           // self.proteinLbl.text = "Protein \(self.diet!.mealplan!.overall_protein_consumed)g/\(self.diet!.mealplan!.overall_protein_recommended)g "
           // self.fatLbl.text = "Fat \(self.diet!.mealplan!.overall_fat_consumed)g/\(self.diet!.mealplan!.overall_fat_recommended)g "
            self.consumedEnergyLbl.text = String(format: "%.2f Cals ",self.diet!.mealplan!.overall_calories_consumed)
            self.recomEnergyLbl.text = String(format: "%.2f Cals ",self.diet!.mealplan!.overall_calories_recommended)
              halfCircularProgress.progress = (self.diet!.mealplan!.overall_fat_consumed)/(self.diet!.mealplan!.overall_fat_recommended)
             halfCircularProgress1.progress = (self.diet!.mealplan!.overall_protein_consumed)/(self.diet!.mealplan!.overall_protein_recommended)
             halfCircularProgress2.progress = (self.diet!.mealplan!.overall_carboHydrate_consumed)/(self.diet!.mealplan!.overall_carboHydrate_recommended)
        }
    
    }
    
    override func layoutSubviews() {
        self.updateConstraints()
        self.tbleHeightConstraint.constant =  CGFloat((self.foodItemsArr?.count ?? 0) * 110 + 40)
    }
    func displayNoDiet(message:String) {
           self.nodataLbl.isHidden = false
           self.nodataLbl.text = message
       }
    private func configureHalfCircularProgress() {
        halfCircularProgress = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: semiCircle.frame.width, height: semiCircle.frame.height), showGuide: true)
        let center = CGPoint(x: semiCircle.frame.width / 2 - 40, y: semiCircle.frame.height / 2 + 40)
        halfCircularProgress.path = UIBezierPath(arcCenter: center, radius: CGFloat((halfCircularProgress.frame).width/3), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        halfCircularProgress.strokeStart = 0.5
    halfCircularProgress.colors = [AppColours.graphBlue]
    halfCircularProgress.guideColor = .white
       halfCircularProgress.backgroundColor = UIColor.clear
      
    halfCircularProgress.guideLineWidth = 5.0
      halfCircularProgress.lineWidth = 5.0
        semiCircle.addSubview(halfCircularProgress)
        
        
        
        halfCircularProgress1 = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: semiCircle.frame.width, height: semiCircle.frame.height), showGuide: true)
               let center1 = CGPoint(x: semiCircle.frame.width / 2 - 40, y: semiCircle.frame.height / 2 + 40)
    halfCircularProgress1.path = UIBezierPath(arcCenter: center1, radius: CGFloat((halfCircularProgress.frame).width/3.7), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
               halfCircularProgress1.strokeStart = 0.5
               halfCircularProgress1.colors = [AppColours.graphYello]
    halfCircularProgress1.guideColor = .white
         semiCircle.addSubview(halfCircularProgress1)
     halfCircularProgress1.guideLineWidth = 5.0
      halfCircularProgress1.lineWidth = 5.0
        halfCircularProgress1.backgroundColor = UIColor.clear
        
        
        halfCircularProgress2 = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: semiCircle.frame.width, height: semiCircle.frame.height), showGuide: true)
               let center2 = CGPoint(x: semiCircle.frame.width / 2 - 40, y: semiCircle.frame.height / 2 + 40)
        halfCircularProgress2.path = UIBezierPath(arcCenter: center2, radius: CGFloat((halfCircularProgress.frame).width/4.5), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
               halfCircularProgress2.strokeStart = 0.5
               halfCircularProgress2.colors = [AppColours.appGreen]
    halfCircularProgress2.guideColor = .white
         semiCircle.addSubview(halfCircularProgress2)
        halfCircularProgress2.backgroundColor = UIColor.clear
        
     halfCircularProgress2.guideLineWidth = 5.0
    halfCircularProgress2.lineWidth = 5.0
                let labelWidth = CGFloat(100.0)
//               consumedEnergyLbl = UILabel(frame: CGRect(x: (halfCircularProgress2.frame.width / 2) - labelWidth , y: (halfCircularProgress2.frame.height ) / 2 - 20, width: labelWidth, height: 20.0))
        
         consumedEnergyLbl = UILabel(frame: CGRect(x: (halfCircularProgress2.frame.width / 2) - labelWidth  , y: (halfCircularProgress2.frame.height ) / 2 - 20, width: labelWidth, height: 20.0))
        //consumedEnergyLbl = UILabel()
        halfCircularProgress2.addSubview(consumedEnergyLbl)

        
//        consumedEnergyLbl.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = consumedEnergyLbl.centerXAnchor.constraint(equalTo: halfCircularProgress2.centerXAnchor)
//        let verticalConstraint = consumedEnergyLbl.centerYAnchor.constraint(equalTo: halfCircularProgress2.centerYAnchor)
//        let widthConstraint = consumedEnergyLbl.widthAnchor.constraint(equalToConstant: 100)
//        let heightConstraint = consumedEnergyLbl.heightAnchor.constraint(equalToConstant: 20)
//        consumedEnergyLbl.addConstraints([horizontalConstraint,verticalConstraint, widthConstraint, heightConstraint])
//        NSLayoutConstraint(item: consumedEnergyLbl, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: halfCircularProgress2, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -20).isActive = true

        
        
        
               consumedEnergyLbl.font = UIFont(name: "Lato-Regular", size: 10)
               consumedEnergyLbl.textAlignment = .center
               consumedEnergyLbl.textColor = AppColours.appGreen
               consumedEnergyLbl.alpha = 1
              // consumedEnergyLbl.text = "800 cal"
         ofLbl = UILabel(frame: CGRect(x: (halfCircularProgress2.frame.width / 2) - labelWidth , y: self.consumedEnergyLbl.frame.maxY, width: labelWidth, height: 20.0))
        ofLbl.font = UIFont(name: "Lato-Regular", size: 10)
        ofLbl.textAlignment = .center
        ofLbl.textColor = .white
        ofLbl.alpha = 1
       
        halfCircularProgress2.addSubview(ofLbl)
         let labelWidth1 = CGFloat(240)
        recomEnergyLbl = UILabel(frame: CGRect(x: (halfCircularProgress2.frame.width / 2) - labelWidth , y: self.consumedEnergyLbl.frame.maxY + 20, width: labelWidth, height: 30.0))
        recomEnergyLbl.font = UIFont(name: "Lato-Regular", size: 12)
        recomEnergyLbl.textAlignment = .center
        recomEnergyLbl.textColor = AppColours.graphYello
        recomEnergyLbl.alpha = 1
      //  recomEnergyLbl.text = "800 cal"
        halfCircularProgress2.addSubview(recomEnergyLbl)
        
        self.refreshView(dietSelection: .breakFast)
    }
    func numberOfRows() {
        switch self.dietSelection {
        case .breakFast:
            self.foodItemsArr = self.diet?.mealplan?.breakfast?.foodItems
            self.waterView.isHidden = true
            self.foodTblView.isHidden = false
            self.addFoodBtn.isHidden = false
        case .lunch:
             self.foodItemsArr = self.diet?.mealplan?.lunch?.foodItems
            self.waterView.isHidden = true
            self.foodTblView.isHidden = false
            self.addFoodBtn.isHidden = false
        case .dinner:
             self.foodItemsArr = self.diet?.mealplan?.dinner?.foodItems
            self.waterView.isHidden = true
            self.foodTblView.isHidden = false
            self.addFoodBtn.isHidden = false
        case .snack1:
             self.foodItemsArr = self.diet?.mealplan?.snacks?.foodItems
            self.waterView.isHidden = true
            self.foodTblView.isHidden = false
            self.addFoodBtn.isHidden = false
        case .water:
            self.waterView.isHidden = false
            self.foodTblView.isHidden = true
            self.addFoodBtn.isHidden = true
            let water = self.diet?.mealplan?.waterConsumed
            if water != nil {
                self.waterQtyLbl.text = "\(water!.consumed)"
                self.mlLbl.isHidden = false
                if water?.consumed ?? 0 == 0 {
                    self.jugImgView.image = UIImage(named: "nowater")
                }else {
                    let imageName =  "\(water!.consumed)"
                    self.jugImgView.image = UIImage(named: String(imageName))
                }
               
                let dob = String(water!.lastUpdatedOn.prefix(10)) as String
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: dob)
                let date1 = Date.getDateInFormat(format: "MMM d, yyyy", date: date!)
              // self.dob.setTitle(date1, for: .normal)
                
                self.lastUpdateLbl.text = "Last Update \(date1)"
            }else {
                self.jugImgView.image = UIImage(named: "nowater")
                self.mlLbl.isHidden = true
                self.waterQtyLbl.text = ""
            }
             
        default:
             self.foodItemsArr = self.diet?.mealplan?.snacks_2?.foodItems
        }
    }
    func refreshView(dietSelection : DietSelection) {
           switch dietSelection {
           case .breakFast:
                self.dietSelection = .breakFast
               self.lunchViewDisplay(isActive: false)
               self.snackViewDisplay(isActive: false)
               self.bfViewDisplay(isActive: true)
               self.dinnerViewDisplay(isActive: false)
             self.waterViewDisplay(isActive: false)
              
           case .lunch:
                self.dietSelection = .lunch
               self.lunchViewDisplay(isActive: true)
               self.snackViewDisplay(isActive: false)
               self.bfViewDisplay(isActive: false)
               self.dinnerViewDisplay(isActive: false)
             self.waterViewDisplay(isActive: false)
              
           case .snack1:
               self.dietSelection = .snack1
               self.lunchViewDisplay(isActive: false)
               self.snackViewDisplay(isActive: true)
               self.bfViewDisplay(isActive: false)
               self.dinnerViewDisplay(isActive: false)
             self.waterViewDisplay(isActive: false)
               
           case .dinner:
               self.dietSelection = .dinner
               self.lunchViewDisplay(isActive: false)
               self.snackViewDisplay(isActive: false)
               self.bfViewDisplay(isActive: false)
               self.dinnerViewDisplay(isActive: true)
               self.waterViewDisplay(isActive: false)
            case .water:
                          self.dietSelection = .water
                          self.lunchViewDisplay(isActive: false)
                          self.snackViewDisplay(isActive: false)
                          self.bfViewDisplay(isActive: false)
                          self.dinnerViewDisplay(isActive: false)
             self.waterViewDisplay(isActive: true)
               
           default:
               self.lunchViewDisplay(isActive: false)
               
               self.dietSelection = .breakFast
           }
       }
    //MARK -- Button image changes
       func bfViewDisplay(isActive: Bool) {
           if !isActive {
               self.bfBtn.setImage(UIImage(named: "breakfast"), for: .normal)
               
           }
           else
           {
              
               self.bfBtn.setImage(UIImage(named: "selbreakfast"), for: .normal)
                self.reloadDietView()
               
           }
       }
       func lunchViewDisplay(isActive: Bool) {
           if !isActive {
               self.lunchBtn.setImage(UIImage(named: "fruit"), for: .normal)
              
           }
           else
           {
                // self.getTrainerPublicVideos()
            //   self.videosView.isHidden = false
               self.lunchBtn.setImage(UIImage(named: "selfruit"), for: .normal)
                self.reloadDietView()
           }
       }
       func snackViewDisplay(isActive: Bool) {
           if !isActive {
               self.snackBtn.setImage(UIImage(named: "evening"), for: .normal)
                //self.packagesView.isHidden = true
           }
           else
           {
              // self.getTrainerPackages()
               self.snackBtn.setImage(UIImage(named: "selevening"), for: .normal)
              self.reloadDietView()
           }
       }
       func dinnerViewDisplay(isActive: Bool) {
           if !isActive {
               self.dinnerBtn.setImage(UIImage(named: "dinner"), for: .normal)
              //  self.packagesView.isHidden = true
           }
           else
           {
             //  self.getTrainerPackages()
               self.dinnerBtn.setImage(UIImage(named: "seldinner"), for: .normal)
              self.reloadDietView()
           }
       }
    func waterViewDisplay(isActive: Bool) {
              if !isActive {
                  self.glassBtn.setImage(UIImage(named: "glass"), for: .normal)
                 //  self.packagesView.isHidden = true
              }
              else
              {
                //  self.getTrainerPackages()
                  self.glassBtn.setImage(UIImage(named: "selglass"), for: .normal)
                 self.reloadDietView()
              }
          }
    @IBAction func waterBtnTapped(_ sender: Any) {
         self.refreshView(dietSelection: .water)
    }
    @IBAction func snackBtnTapped(_ sender: Any) {
         self.refreshView(dietSelection: .snack1)
    }
    
    @IBAction func lunchBtnTapped(_ sender: Any) {
        self.refreshView(dietSelection: .lunch)
    }
    @IBAction func bfBtnTapped(_ sender: Any) {
        self.refreshView(dietSelection: .breakFast)
    }
    
    @IBAction func dinnerBtnTapped(_ sender: Any) {
         self.refreshView(dietSelection: .dinner)
    }
    
    @IBAction func addfoodBtnTapped(_ sender: Any) {
        self.dietviewDelegate?.addFoodSelected(dietSelected: self.dietSelection)
    }
    @IBAction func qty750mlBtnTapped(_ sender: Any) {
        if qty750Btn.isSelected {
            self.qty750Btn.setImage(UIImage(named: "bGlass"), for: .normal)
           
        }
        else
        {
            self.selectedWater = .ml750
            self.qty750Btn.setImage(UIImage(named: "btglass"), for: .normal)
            self.qty500Btn.setImage(UIImage(named: "bGlass"), for: .normal)
            self.qty250Btn.setImage(UIImage(named: "bGlass"), for: .normal)
           
        }
    }
    @IBAction func qty500mlBtnTapped(_ sender: Any) {
        if qty500Btn.isSelected {
            self.qty500Btn.setImage(UIImage(named: "bGlass"), for: .normal)
           
        }
        else
        {
           self.selectedWater = .ml500
            self.qty500Btn.setImage(UIImage(named: "btglass"), for: .normal)
            self.qty250Btn.setImage(UIImage(named: "bGlass"), for: .normal)
            self.qty750Btn.setImage(UIImage(named: "bGlass"), for: .normal)
        }
    }
    @IBAction func qty250mlBtnTapped(_ sender: Any) {
        if qty250Btn.isSelected {
            self.qty250Btn.setImage(UIImage(named: "bGlass"), for: .normal)
        }
        else
        {
           self.selectedWater = .ml250
            self.qty250Btn.setImage(UIImage(named: "btglass"), for: .normal)
             self.qty500Btn.setImage(UIImage(named: "bGlass"), for: .normal)
            self.qty750Btn.setImage(UIImage(named: "bGlass"), for: .normal)
          
        }
    }
    @IBAction func minusBtnTapped(_ sender: Any) {
        LoadingOverlay.shared.showOverlay(view: self)
              let water = self.diet?.mealplan?.waterConsumed
               var prevQty : Int = 0
              if water != nil {
                let qty = water!.consumed
                prevQty = Int(qty)
              }
               switch self.selectedWater {
               case .ml750:
                if prevQty >= 750 {
                    prevQty = prevQty - 750
                }else {
                     prevQty = 0
                }
                   
               case .ml500:
                   if prevQty >= 500 {
                       prevQty = prevQty - 500
                   }else {
                        prevQty = 0
                   }
               case .ml250:
                   if prevQty >= 250 {
                       prevQty = prevQty - 250
                   }else {
                        prevQty = 0
                   }
               default:
                   prevQty = prevQty + 250
               }
               self.updateWater(qty: prevQty)
        
    }
    @IBAction func addBtnTapped(_ sender: Any) {
        LoadingOverlay.shared.showOverlay(view: self)
       let water = self.diet?.mealplan?.waterConsumed
        var prevQty : Int = 0
       if water != nil {
        let qty = water!.consumed
        prevQty = Int(qty)
       }
        
        switch self.selectedWater {
        case .ml750:
            prevQty = prevQty + 750
        
        case .ml500:
            prevQty = prevQty + 500
        case .ml250:
            prevQty = prevQty + 250
        default:
            prevQty = prevQty + 250
        }
        if prevQty >= 5000 {
            prevQty = 5000
        }
        self.updateWater(qty: prevQty)
    }
    func updateWater(qty:Int) {
        let waterConsumedM = WaterConsumedPost(consumed: qty, metric: "ml")
       // let postBody = WaterUpdatePostBoday(date: <#T##String#>, trainee_id: <#T##String#>)
        var postbody = WaterUpdatePostBoday( date: Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!)
        postbody.waterConsumed = waterConsumedM
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(postbody)
        
        GetDietByDateAPI.updateWaterAPI(parameters: [:], header: [:], dataParams: jsonData, successHandler: { [weak self] (diet) in
            print("diet is \(diet)")
                        self?.diet = diet
                            DispatchQueue.main.async {
                               self?.reloadDietView()
                               LoadingOverlay.shared.hideOverlayView()
                               if diet == nil && diet?.mealplan == nil {
                                   var message = "No data available for the selected date"
                                   if messageString.count > 0 {
                                       message = messageString
                                   }
                               
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
extension DietViewL: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodItem = self.foodItemsArr![indexPath.row]
        self.dietviewDelegate?.foodDetailsSelected(foodItems:foodItem, dietSelection: self.dietSelection)
       }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
        return UITableView.automaticDimension
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of cells \(self.foodItemsArr?.count ?? 0)")
        return self.foodItemsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dietListCell")
            as? DietListTableViewCell
            else {
                return UITableViewCell()
        }
        let foodItem = self.foodItemsArr![indexPath.row]
        if  foodItem.photo != nil &&  foodItem.photo?.thumb?.count ?? 0 > 0 {
            cell.imgView.loadImage(url: URL(string: (foodItem.photo?.thumb!)!)!)
        }
        
        cell.foodName.text = foodItem.food_name!.lowercased()
        let consumedTime = foodItem.consumedTime ?? foodItem.time ?? ""
        cell.timeBtn.text = consumedTime
        cell.timeBtn.tag = indexPath.row
       //  cell.timeBtn.addTarget(self, action: #selector(timeBtnSelected(sender:)), for: .touchUpInside)
        var units = 0.0
        var serving = 0.0
        if foodItem.foodStatus == WOStatus.complete {
            serving = Double(foodItem.serving_qty?.consumed ?? 0.0)
            units = Double(foodItem.serving_weight_grams?.consumed ?? 0.0)
            cell.dietCompletImgView.isHidden = false  // String(format:"%.2f kcal",calories)
            cell.calLbl.text = String(format:"%.2f kcal",foodItem.nf_calories!.consumed)
            
        }else {
            serving = Double(foodItem.serving_qty?.recommended ?? 0.0)
            units = Double(foodItem.serving_weight_grams?.recommended ?? 0.0)
             cell.dietCompletImgView.isHidden = true
            cell.calLbl.text = String(format:"%.2f kcal",foodItem.nf_calories!.recommended)
        }
        if units == 0.0 {
            cell.qtyLbl.text = String(format: "%.2f", serving)
        }else {
            cell.qtyLbl.text = String(format: "%.2f Serving (%.2f grms)", serving,units)
        }
       
        cell.accessibilityValue = nil
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        cell.timeBtn.isUserInteractionEnabled = true
        cell.timeBtn.addGestureRecognizer(tap)

        return cell
    }
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        let tag = sender.view?.tag ?? 0
        self.selectedTimeIndex = NSIndexPath(row:tag, section: 0)
        let foodItem = self.foodItemsArr![tag]

        print("tap working \(tag)")
        let cell = self.foodTblView.cellForRow(at: self.selectedTimeIndex as! IndexPath) as! DietListTableViewCell
        var serving = 0.0
        if foodItem.foodStatus == WOStatus.complete {
                          serving = Double(foodItem.serving_qty?.consumed ?? 0.0)
                          // editedQuantity = serving
                          
                      }else {
                          serving = Double(foodItem.serving_qty?.recommended ?? 0.0)
                         
                      }
               let qty = cell.accessibilityValue
               if qty != nil {
                   serving = Double(qty!) ?? serving
               }
        self.dietviewDelegate?.timePickerSelected(index:tag, dietSelection: self.dietSelection, foodItems:foodItem, quantity:serving)
  
    }
    
     @objc func timeBtnSelected(sender : UIButton){
            
            let indexPath = NSIndexPath(row:sender.tag, section: 0)
            let cell = self.foodTblView.cellForRow(at: indexPath as IndexPath) as! SearchResTableViewCell
//            cell.selectBtn.setImage(UIImage(named: "cstatus"), for: .normal)
//            self.addFoodItem(foodCode: foodDetails.foodCode)
    
            
        }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.layoutSubviews()
//    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "") {
                                action, sourceView, completionHandler in
                              let actionPerformed = self.deleteAction(action: action, sourceView: sourceView, indexPath: indexPath)
                                completionHandler(actionPerformed)
                            }
        delete.image = UIImage(named: "dietDelete")
        delete.backgroundColor =  UIColor.black
        
        let add = UIContextualAction(style: .normal, title: "") {
                                action, sourceView, completionHandler in
                              let actionPerformed = self.addAction(action: action, sourceView: sourceView, indexPath: indexPath)
                                completionHandler(actionPerformed)
                            }
                          add.image = UIImage(named: "add")
                          add.backgroundColor =  UIColor.black
               
               let minus = UIContextualAction(style: .normal, title: "") {
                                       action, sourceView, completionHandler in
                                       let actionPerformed = self.minusAction(action: action, sourceView: sourceView, indexPath: indexPath)
                                       completionHandler(actionPerformed)
                                   }
        minus.image = UIImage(named: "remove")
                                 minus.backgroundColor =  UIColor.black
        
        let complete = UIContextualAction(style: .normal, title: "") {
            action, sourceView, completionHandler in
            let actionPerformed = self.completeAction(action: action, sourceView: sourceView, indexPath: indexPath)
            completionHandler(actionPerformed)
        }
        complete.image = UIImage(named: "dietgComplete")
                                        complete.backgroundColor =  UIColor.black
        
        let config = UISwipeActionsConfiguration(actions: [delete,complete,add,minus])
                            config.performsFirstActionWithFullSwipe = false
                      let cell:UITableViewCell = (tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)))!
                      cell.backgroundColor = UIColor.black
                      //action.backgroundColor = UIColor.green
                            return config
        
    }
    func deleteAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        let foodItem = self.foodItemsArr![indexPath.row]
        self.dietviewDelegate?.deleteFoodItem(dietSelection: self.dietSelection, foodItems: foodItem)
         return true
    }

    func completeAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
         let foodItem = self.foodItemsArr![indexPath.row]
        var serving = 0.0
        if foodItem.foodStatus == WOStatus.complete {
                   serving = Double(foodItem.serving_qty?.consumed ?? 0.0)
                   // editedQuantity = serving
                   
               }else {
                   serving = Double(foodItem.serving_qty?.recommended ?? 0.0)
                  
               }
         let cell = self.foodTblView.cellForRow(at: indexPath) as! DietListTableViewCell
        let qty = cell.accessibilityValue
        if qty != nil {
            serving = Double(qty!) ?? serving
        }
        self.dietviewDelegate?.completeFoodItem(index: indexPath.row, dietSelection: self.dietSelection, foodItems: foodItem, quantity:serving )
         return true
    }
    func minusAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        let foodItem = self.foodItemsArr![indexPath.row]
        var serving = 0.0
        var units = 0.0
        let cell = self.foodTblView.cellForRow(at: indexPath) as! DietListTableViewCell
        let qty = cell.accessibilityValue
        if foodItem.foodStatus == WOStatus.complete {
            serving = Double(String(format: "%.2f", foodItem.serving_qty?.consumed ?? 0.0)) ?? 0.0
            units = Double(foodItem.serving_weight_grams?.consumed ?? 0.0)
            editedQuantity = Double( qty ?? "\(serving)")!
            editedQuantity = ceil(editedQuantity*100)/100
            if foodItem.createdBy == CreatedByTrainee.lowercased() {
                if editedQuantity != 0 && editedQuantity >=  0.5 {
                  //  editedQuantity = editedQuantity - Double(foodItem.serving_qty?.consumed ?? 0.0)
                    editedQuantity = editedQuantity - 0.5
                }
                if editedQuantity == 0 || editedQuantity < 0.5 {
                    self.dietviewDelegate?.deleteFoodItem(dietSelection: self.dietSelection, foodItems: foodItem)
                }
            }else {
//                if editedQuantity != Double(foodItem.serving_qty?.consumed ?? 0.0) {
//                    editedQuantity = editedQuantity - Double(foodItem.serving_qty?.consumed ?? 0.0)
//                }
                if editedQuantity != 0.5 {
                    editedQuantity = editedQuantity - 0.5
                }

            }
            if serving != 0.0 {
                let calories : Double = Double(Double(foodItem.nf_calories!.consumed) / serving * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }else {
                let calories : Double = Double(Double(foodItem.nf_calories!.consumed) * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }
            if units == 0.0 {
                cell.qtyLbl.text = String(format: "%.2f", editedQuantity)
            }else {
                cell.qtyLbl.text = String(format: "%.2f Serving (%.2f grms)", editedQuantity,units)
            }
            
        }else {
           // serving = Double(foodItem.serving_qty?.recommended ?? 0.0)
            serving = Double(String(format: "%.2f", (foodItem.serving_qty?.recommended ?? 0.0))) ?? 0.0
            units = Double(foodItem.serving_weight_grams?.recommended ?? 0.0)
            editedQuantity = Double(qty ?? "\(serving)")!
            if foodItem.createdBy == CreatedByTrainee.lowercased() {
                if editedQuantity != 0 && editedQuantity >=  0.5 {
                    editedQuantity = editedQuantity - 0.5
                }
                if editedQuantity == 0 || editedQuantity < 0.5 {
                    self.dietviewDelegate?.deleteFoodItem(dietSelection: self.dietSelection, foodItems: foodItem)
                }
            }else {
                if editedQuantity != 0.5 {
                    editedQuantity = editedQuantity - 0.5
                }

            }
            if serving != 0.0 {
                let calories : Double = Double(Double(foodItem.nf_calories!.recommended) / serving * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }else {
                let calories : Double = Double(Double(foodItem.nf_calories!.recommended) * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }
            if units == 0.0 {
                cell.qtyLbl.text = String(format: "%.2f", editedQuantity)
            }else {
                cell.qtyLbl.text = String(format: "%.2f Serving (%.2f grms)", editedQuantity,units)
            }
            
        }
        


         return false
    }
    func addAction(action: UIContextualAction, sourceView: UIView,indexPath: IndexPath) -> Bool {
        let foodItem = self.foodItemsArr![indexPath.row]
        var serving = 0.0
        var units = 0.0
        let cell = self.foodTblView.cellForRow(at: indexPath) as! DietListTableViewCell
        let qty = cell.accessibilityValue
        if foodItem.foodStatus == WOStatus.complete {
            serving = Double(foodItem.serving_qty?.consumed ?? 0.0)
            units = Double(foodItem.serving_weight_grams?.consumed ?? 0.0)
            editedQuantity = Double(qty ?? "\(serving)")!
           // editedQuantity = editedQuantity + Double(foodItem.serving_qty?.recommended ?? 0.0)
            editedQuantity = editedQuantity + 0.5
           // cell.qtyLbl.text = "\(editedQuantity) Serving (\(units) grms)"
           // cell.qtyLbl.text = String(format: "%.2f Serving (%.2f grms)", editedQuantity,units)
            if serving != 0.0 {
                let calories : Double = Double(Double(foodItem.nf_calories!.consumed) / serving * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }else {
                let calories : Double = Double(Double(foodItem.nf_calories!.consumed) * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }
        }else {
            serving = Double(foodItem.serving_qty?.recommended ?? 0.0)
            units = Double(foodItem.serving_weight_grams?.recommended ?? 0.0)
            editedQuantity = Double(qty ?? "\(serving)")!
          //  editedQuantity = editedQuantity +  serving
            editedQuantity = editedQuantity +  0.5
           // cell.qtyLbl.text = "\(editedQuantity) Serving (\(units) grms)"
           // cell.qtyLbl.text = String(format: "%.2f Serving (%.2f grms)", editedQuantity,units)
            if serving != 0.0 {
                let calories : Double = Double(Double(foodItem.nf_calories!.recommended) / serving * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }else {
                let calories : Double = Double(Double(foodItem.nf_calories!.recommended) * editedQuantity)
                cell.calLbl.text = String(format:"%.2f kcal",calories)
                cell.accessibilityValue = "\(editedQuantity)"
            }
            
        }
        if units == 0.0 {
            cell.qtyLbl.text = String(format: "%.2f", editedQuantity)
        }else {
            cell.qtyLbl.text = String(format: "%.2f Serving (%.2f grms)", editedQuantity,units)
        }

        return false
    }
    
}
