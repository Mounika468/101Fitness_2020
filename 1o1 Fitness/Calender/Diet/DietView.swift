//
//  DietView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 18/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import KYCircularProgress
//protocol dietSelectionDelegate {
//    func selectedDietOption()
//}
//enum DietSelection {
//    case breakFast
//    case lunch
//    case dinner
//    case snack1
//    case snack2
//}
class DietView: UIView {
    @IBOutlet weak var waterView: WaterView!
    
    @IBOutlet weak var dinnerBtn: UIButton!
    @IBOutlet weak var snackBtn: UIButton!
    @IBOutlet weak var lunchBtn: UIButton!
    @IBOutlet weak var bfBtn: UIButton!
    @IBOutlet weak var dietTblHeight: NSLayoutConstraint!
    @IBOutlet weak var dietTableView: UITableView!
    @IBOutlet weak var addFoodBtn: UIButton!
    @IBOutlet weak var actCalLbl: UILabel!
    @IBOutlet weak var totlCalLbl: UILabel!
    @IBOutlet weak var mealNameLbl: UILabel!
    @IBOutlet weak var semiCircle: UIView!
    private var halfCircularProgress: KYCircularProgress!
    private var halfCircularProgress1: KYCircularProgress!
    private var halfCircularProgress2: KYCircularProgress!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var semiCircelView: SemiCircleView!
     var headersImages : Array = ["breakfast","fruit","evening","dinner"]
    var diet : Diet?
     var foodItemsArr : [NutritionixFoodItems]?
    var dietSelection : DietSelection = .breakFast
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
        Bundle.main.loadNibNamed("DietView", owner: self, options: nil)
        addSubview(bgView)
        bgView.frame = self.bounds
        bgView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
       self.waterView.layer.cornerRadius = 10
              self.waterView.clipsToBounds = true
        self.waterView.layer.borderWidth = 0.5
              self.waterView.layer.borderColor = AppColours.lineColor.cgColor
        
        self.semiCircle.layer.cornerRadius = 10
                     self.semiCircle.clipsToBounds = true
        self.semiCircle.layer.borderWidth = 0.5
        self.semiCircle.layer.borderColor = AppColours.lineColor.cgColor
        configureHalfCircularProgress()
        self.mealNameLbl.textColor = .white
        self.totlCalLbl.textColor = AppColours.appYellow
        self.actCalLbl.textColor = AppColours.appGreen
        self.addFoodBtn.setTitleColor(AppColours.graphBlue, for: .normal)
        let nib1 = UINib(nibName: "DietListTableViewCell", bundle: nil)
               self.dietTableView.register(nib1, forCellReuseIdentifier: "dietListCell")
     //   self.dietTblHeight.constant = self.dietTableView.contentSize.height
        self.dietTableView.tableFooterView = UIView()
        // self.dietTableView.estimatedRowHeight = CGFloat(500.0)
       //  self.dietTableView.rowHeight = UITableView.automaticDimension
        // self.dietTableView.alwaysBounceVertical = false
    }
     private func configureHalfCircularProgress() {
            halfCircularProgress = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: semiCircle.frame.width, height: semiCircle.frame.height), showGuide: true)
            let center = CGPoint(x: semiCircle.frame.width / 2 - 30, y: semiCircle.frame.height / 2 + 30)
            halfCircularProgress.path = UIBezierPath(arcCenter: center, radius: CGFloat((halfCircularProgress.frame).width/3), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            halfCircularProgress.strokeStart = 0.5
        halfCircularProgress.colors = [AppColours.graphBlue]
        halfCircularProgress.guideColor = .white
           halfCircularProgress.backgroundColor = UIColor.clear
            halfCircularProgress.progress = 0.7
        halfCircularProgress.guideLineWidth = 5.0
          halfCircularProgress.lineWidth = 5.0
            semiCircle.addSubview(halfCircularProgress)
            
            
            
            halfCircularProgress1 = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: semiCircle.frame.width, height: semiCircle.frame.height), showGuide: true)
                   let center1 = CGPoint(x: semiCircle.frame.width / 2 - 30, y: semiCircle.frame.height / 2 + 30)
        halfCircularProgress1.path = UIBezierPath(arcCenter: center1, radius: CGFloat((halfCircularProgress.frame).width/3.7), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
                   halfCircularProgress1.strokeStart = 0.5
                   halfCircularProgress1.colors = [AppColours.graphYello]
        halfCircularProgress1.guideColor = .white
             semiCircle.addSubview(halfCircularProgress1)
         halfCircularProgress1.guideLineWidth = 5.0
          halfCircularProgress1.lineWidth = 5.0
            halfCircularProgress1.backgroundColor = UIColor.clear
             halfCircularProgress1.progress = 0.6
            
            halfCircularProgress2 = KYCircularProgress(frame: CGRect(x: 0, y: 0, width: semiCircle.frame.width, height: semiCircle.frame.height), showGuide: true)
                   let center2 = CGPoint(x: semiCircle.frame.width / 2 - 30, y: semiCircle.frame.height / 2 + 30)
            halfCircularProgress2.path = UIBezierPath(arcCenter: center2, radius: CGFloat((halfCircularProgress.frame).width/4.5), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
                   halfCircularProgress2.strokeStart = 0.5
                   halfCircularProgress2.colors = [AppColours.appGreen]
        halfCircularProgress2.guideColor = .white
             semiCircle.addSubview(halfCircularProgress2)
            halfCircularProgress2.backgroundColor = UIColor.clear
             halfCircularProgress2.progress = 0.8
         halfCircularProgress2.guideLineWidth = 5.0
        halfCircularProgress2.lineWidth = 5.0
                    let labelWidth = CGFloat(80.0)
                   let textLabel = UILabel(frame: CGRect(x: (halfCircularProgress2.frame.width / 2) - labelWidth , y: (halfCircularProgress2.frame.height ) / 2, width: labelWidth, height: 15.0))
                   textLabel.font = UIFont(name: "Lato-Regular", size: 8)
                   textLabel.textAlignment = .center
                   textLabel.textColor = AppColours.appGreen
                   textLabel.alpha = 1
                   textLabel.text = "800 cal"
                   halfCircularProgress2.addSubview(textLabel)
        
        }
    @IBAction func addFoodBtnTapped(_ sender: Any) {
    }
    func reloadDietView() {
        self.numberOfRows()
        self.dietTableView.reloadData()
      //  self.dietTblHeight.constant = self.dietTableView.contentSize.height
    }
    func numberOfRows() {
        switch self.dietSelection {
        case .breakFast:
            self.foodItemsArr = self.diet?.mealplan?.breakfast?.foodItems
        case .lunch:
             self.foodItemsArr = self.diet?.mealplan?.lunch?.foodItems
        case .dinner:
             self.foodItemsArr = self.diet?.mealplan?.dinner?.foodItems
        case .snack1:
             self.foodItemsArr = self.diet?.mealplan?.snacks?.foodItems
//        case .snack2:
//             self.foodItemsArr = self.diet?.mealplan?.snacks_2?.foodItems
        default:
             self.foodItemsArr = self.diet?.mealplan?.snacks_2?.foodItems
        }
    }
    @IBAction func dinnerBtnTapped(_ sender: Any) {
        self.refreshView(dietSelection: .dinner)
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
    func refreshView(dietSelection : DietSelection) {
        switch dietSelection {
        case .breakFast:
             self.dietSelection = .breakFast
            self.lunchViewDisplay(isActive: false)
            self.snackViewDisplay(isActive: false)
            self.bfViewDisplay(isActive: true)
            self.dinnerViewDisplay(isActive: false)
           
        case .lunch:
             self.dietSelection = .lunch
            self.lunchViewDisplay(isActive: true)
            self.snackViewDisplay(isActive: false)
            self.bfViewDisplay(isActive: false)
            self.dinnerViewDisplay(isActive: false)
           
        case .snack1:
            self.dietSelection = .snack1
            self.lunchViewDisplay(isActive: false)
            self.snackViewDisplay(isActive: true)
            self.bfViewDisplay(isActive: false)
            self.dinnerViewDisplay(isActive: false)
            
        case .dinner:
            self.dietSelection = .dinner
            self.lunchViewDisplay(isActive: false)
            self.snackViewDisplay(isActive: false)
            self.bfViewDisplay(isActive: false)
            self.dinnerViewDisplay(isActive: true)
            
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
           
            self.bfBtn.setImage(UIImage(named: "breakfast"), for: .normal)
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
            self.lunchBtn.setImage(UIImage(named: "fruit"), for: .normal)
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
            self.snackBtn.setImage(UIImage(named: "evening"), for: .normal)
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
            self.dinnerBtn.setImage(UIImage(named: "dinner"), for: .normal)
           self.reloadDietView()
        }
    }
}
extension DietView: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return 100
        return UITableView.automaticDimension
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.foodItemsArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dietListCell")
            as? DietListTableViewCell
            else {
                return UITableViewCell()
        }
        let foodItem = self.foodItemsArr![indexPath.row]
        if  foodItem.imgUrl != nil {
            cell.imgView.loadImage(url: URL(string: foodItem.imgUrl!)!)
        }
        cell.foodName.text = foodItem.food_name!
      //  cell.timeBtn.setTitle(foodItem.time, for: .normal)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    
   
}
extension DietView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return headersImages.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCV", for: indexPath) as! HeaderCollectionViewCell
             cell.imgView.image = UIImage(named: headersImages[indexPath.row])
                   return cell

        
       
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 60)
        
        // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.dietSelection = .breakFast
        case 1:
            self.dietSelection = .lunch
        case 2:
            self.dietSelection = .snack1
        case 3:
            self.dietSelection = .dinner
        case 4:
            self.dietSelection = .snack1
        default:
            self.dietSelection = .breakFast
        }
        self.reloadDietView()

    }
    
   

   
}
