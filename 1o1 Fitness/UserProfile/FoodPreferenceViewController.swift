//
//  FoodPreferenceViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class FoodPreferenceViewController: UIViewController {
    
    @IBOutlet weak var foodTypeCV: UICollectionView! {
        didSet {
            foodTypeCV.showsVerticalScrollIndicator = false
            foodTypeCV.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var mealsCV: UICollectionView! {
        didSet {
            mealsCV.showsVerticalScrollIndicator = false
            mealsCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    var foodTypesArr : Array = ["Veg","Vegan","Non Veg","Jain","Eggetarian"]
    var mealsArr : Array = ["1 meal","4 meals","2 meals","5+ meals","3 meals"]
    var selectedIndexPath: IndexPath?
    var isNonVegSelected : Bool = false
    var isMeatChoiceDone : Bool = false
    var selectedFoodType = ""
    var selectedMeals = ""
    var meatSelectedArr :[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headerView.countLbl.text = "9 / 11"
        bottomView.bottonDelegate = self
        
        let timeNib = UINib(nibName: "SingleSelectionCV", bundle: nil)
        self.foodTypeCV.register(timeNib, forCellWithReuseIdentifier:"singleCV")
        let timeFlowLayout = UICollectionViewFlowLayout()
        timeFlowLayout.scrollDirection = .horizontal
        self.foodTypeCV.collectionViewLayout = timeFlowLayout
        
        self.mealsCV.register(timeNib, forCellWithReuseIdentifier:"singleCV")
        self.mealsCV.collectionViewLayout = timeFlowLayout
        
    }
    
    
    
}
extension FoodPreferenceViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case self.mealsCV:
        return self.mealsArr.count
        case self.foodTypeCV:
            return self.foodTypesArr.count
    default:
        return 1
    }
}
func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    switch collectionView {
    case self.foodTypeCV:
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCV", for: indexPath) as! SingleSelectionCV
         cell.singleBtn.text = self.foodTypesArr[indexPath.row]
        // cell.singleBtn.setTitle(self.foodTypesArr[indexPath.row], for: .normal)
        // cell.singleBtn.tag = 999 + indexPath.row
               return cell
        case self.mealsCV:
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleCV", for: indexPath) as! SingleSelectionCV
       // cell.singleBtn.setTitle(self.mealsArr[indexPath.row], for: .normal)
       // cell.singleBtn.tag = 9999 + indexPath.row
       cell.singleBtn.text = self.mealsArr[indexPath.row]

               return cell
    default:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meatCV", for: indexPath) as! MeatCollectionViewCell
       
               return cell
    }
    
   
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 35)
        // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    switch collectionView {
    case self.foodTypeCV:
      
        let cell = collectionView.cellForItem(at: indexPath) as! SingleSelectionCV
        cell.singleBtn.layer.backgroundColor = AppColours.appGreen.cgColor
                   self.selectedIndexPath = indexPath
        self.selectedFoodType = foodTypesArr[indexPath.row]
        if "Non Veg" == foodTypesArr[indexPath.row] {
            self.showFoodPreferences()
        }
    case self.mealsCV:
       let cell = collectionView.cellForItem(at: indexPath) as! SingleSelectionCV
       cell.singleBtn.layer.backgroundColor = AppColours.appGreen.cgColor
        self.selectedIndexPath = indexPath
       self.selectedMeals = mealsArr[indexPath.row]
        self.selectedMeals = String(self.selectedMeals.prefix(1)) as String
       //self.mealsCV.reloadItems(at: [indexPath])
    default:
        print("default statement")
    }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        switch collectionView {
           case self.foodTypeCV:
             let cell = collectionView.cellForItem(at: indexPath) as! SingleSelectionCV
             cell.singleBtn.layer.backgroundColor = UIColor.clear.cgColor
             self.selectedIndexPath = nil
            self.selectedFoodType = ""
          
           case self.mealsCV:
              let cell = collectionView.cellForItem(at: indexPath) as! SingleSelectionCV
            cell.singleBtn.layer.backgroundColor = UIColor.clear.cgColor
            self.selectedIndexPath = nil
          //  self.mealsCV.reloadItems(at: [indexPath])
            self.selectedMeals = ""
           default:
               print("default statement")
           }
        
    }
    func showFoodPreferences() {
        let storyboard = UIStoryboard(name: "MeatChoiceVC", bundle: nil)
                   let alertVC = storyboard.instantiateViewController(withIdentifier: "meatChoiceVC") as! MeatChoiceViewController
                   alertVC.delegate = self
                   alertVC.modalPresentationStyle = .custom
                   present(alertVC, animated: false, completion: nil)
    }
}

extension FoodPreferenceViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if self.selectedMeals.count > 0 && self.selectedFoodType.count > 0 {
            var nonveg = self.isMeatChoiceDone ? self.meatSelectedArr : []
            if self.selectedFoodType.lowercased() != "non veg" {
                nonveg = []
            }
            TraineeInfo.details.food_preference = ["food_type": [self.selectedFoodType.lowercased()],"non_veg_preference": nonveg,"no_of_meals_day": self.selectedMeals]
            let storyboard = UIStoryboard(name: "HabitsVC", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "habitVC")
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            presentAlertWithTitle(title: "", message: "Please select your food preferences", options: "OK") { (option) in
                             }
        }
//
//"food_preference": {
//   "food_type": [
//
//   ],
//   "non_veg_preference": [
//
//   ],
//   "no_of_meals_day": "ee"
// },
    }
}

extension FoodPreferenceViewController : MeatChoiceDelegate {
    func meatSelected(meat: [String]) {
        self.isMeatChoiceDone = true
        self.meatSelectedArr = meat
    }
}
