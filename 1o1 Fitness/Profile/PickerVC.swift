//
//  PickerVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 02/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol SelectedValuesFromPickerDelegate {
    func selectedActivity(index:Int, value:String)
    func noOfMealsday(mealsNo:String)
    
}
protocol FoodQuantityChangedDelegate {
    func foodQtyChanged(measures:AlternateMeasures)
}
enum PopType {
    case morePicker
    case activityPicker
    case foodQuantity
}

class PickerVC: UIViewController {
    fileprivate let titles = ["1", "2", "3","4","5","6"]

    @IBOutlet weak var seperatorLbl: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var activityTblView: UITableView!
    @IBOutlet weak var customPicker: UIPickerView!
    var pickerDelegate: SelectedValuesFromPickerDelegate?
    var foodPickerDelegate: FoodQuantityChangedDelegate?
    var popType: PopType = .morePicker
    var selectedMeals = ""
    var selectedMeasures :AlternateMeasures?
    var foodQtyArr : [AlternateMeasures]?
    var textActivityArr : Array = ["Sedentary","Lightly active","Moderately active","Very active","Extra active"]
    let activityArr : Array = ["gsedentary","glightly","gmoderate","gactive","gextra"]
           let activityNames : Array = ["Sedentary (little or no exercise)","Lightly active (light exercise/sports 1-3 days/week)","Moderately active (moderate exercise/sports 3-5 days/week)","Very active (hard exercise/sports 6-7 days a week)","Extra active (very hard exercise/sports & a physical job)"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // self.customPicker.toolbarDelegate = self
         self.customPicker.reloadAllComponents()
         self.activityTblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.activityTblView.backgroundColor = .clear
       // self.view.roundCorners(corners: [.topLeft,.topRight], radius: 40)
        self.view.dropShadow(color: UIColor.white, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
        if self.popType == .morePicker {
           
            customPicker.selectRow(Int(self.selectedMeals)! - 1, inComponent:0, animated:true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        switch self.popType {
        case .morePicker:
            self.customPicker.isHidden = false
            self.activityTblView.isHidden = true
            self.doneBtn.isHidden = false
            self.cancelBtn.isHidden = false
             self.backBtn.isHidden = true
            self.arrowImgView.isHidden = false
            self.seperatorLbl.isHidden = false
        case .activityPicker:
            self.customPicker.isHidden = true
            self.activityTblView.isHidden = false
            self.doneBtn.isHidden = true
            self.cancelBtn.isHidden = true
             self.backBtn.isHidden = false
            self.arrowImgView.isHidden = true
            self.seperatorLbl.isHidden = true
        case .foodQuantity:
            self.selectedMeasures = self.foodQtyArr?[0]
            self.customPicker.isHidden = false
            self.activityTblView.isHidden = true
            self.doneBtn.isHidden = false
            self.cancelBtn.isHidden = false
             self.backBtn.isHidden = true
            self.arrowImgView.isHidden = false
            self.seperatorLbl.isHidden = false
        default:
            self.customPicker.isHidden = false
        }
    }
    

    @IBAction func backBtnTapped(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtnTapped(_ sender: Any) {
        switch self.popType {
        case .foodQuantity:
            self.foodPickerDelegate?.foodQtyChanged(measures:  self.selectedMeasures!)
        default:
            self.pickerDelegate?.noOfMealsday(mealsNo: self.selectedMeals)

        }
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PickerVC: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.customPicker.selectedRow(inComponent: 0)
        self.customPicker.selectRow(row, inComponent: 0, animated: false)
//        self.textView.text = self.titles[row]
//        self.textField.resignFirstResponder()
    }

    func didTapCancel() {
//        self.textField.text = nil
//        self.textField.resignFirstResponder()
         self.dismiss(animated: true, completion: nil)
    }
}
extension PickerVC: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.popType {
        case .foodQuantity:
            return self.foodQtyArr?.count ?? 0
        default:
            return self.titles.count
        }
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch self.popType {
        case .foodQuantity:
            let measure = self.foodQtyArr?[row]
            return measure?.measure ?? ""
        default:
            return self.titles[row]
        }
            
       
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.popType {
        case .foodQuantity:
            let measure = self.foodQtyArr?[row]
            self.selectedMeasures = measure
            self.selectedMeals =  measure?.measure ?? ""
        default:
            self.selectedMeals = self.titles[row]
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        switch self.popType {
        case .foodQuantity:
            let measure = self.foodQtyArr?[row]
            let titleData = measure?.measure ?? ""
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            return myTitle
        default:
            let titleData = self.titles[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

            return myTitle
        }
        
        
    }
}
extension PickerVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else {
                return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage(named: activityArr[indexPath.row])
        cell.textLabel?.text = activityNames[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Lato-Semibold", size: 8.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pickerDelegate?.selectedActivity(index: indexPath.row, value: textActivityArr[indexPath.row])
    }
    
    
}
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = 3
        self.layer.cornerRadius = 20
      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
