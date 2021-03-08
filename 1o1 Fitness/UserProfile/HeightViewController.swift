//
//  HeightViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 11/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol HeightBackButtonTapDelegate {
    func updateHeightForProfile()
}
class HeightViewController: UIViewController {

    @IBOutlet weak var feetLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet  var priHeightConstraint: NSLayoutConstraint!
    @IBOutlet  var secHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var cmBtn: UIButton!
    @IBOutlet weak var ftBtn: UIButton!
    @IBOutlet weak var bottomView: ProfileBottomView!
    @IBOutlet weak var headerView: ProfileHeaderView!
    @IBOutlet weak var headerLbl: UILabel!
    var navigationType: NavigationType = .profileNormal
    var heightDelegate : HeightBackButtonTapDelegate?
     var scrollView = UIScrollView()
     var weightVal = 0.0
     var metric = ""
    var isOffsetSet : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.countLbl.text = "5 / 11"
        bottomView.bottonDelegate = self
        weightLbl.textColor = AppColours.appGreen

        // Do any additional setup after loading the view.
        verticalScrollView()
        self.ftBtn.layer.cornerRadius = 10
               self.ftBtn.layer.borderWidth = 1
               self.ftBtn.layer.borderColor = AppColours.appGreen.cgColor
               
               
               self.cmBtn.layer.cornerRadius = 10
               self.cmBtn.layer.borderWidth = 1
               self.cmBtn.layer.borderColor = AppColours.appGreen.cgColor
               
    }
    override func viewDidAppear(_ animated: Bool) {
        
         
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           switch self.navigationType {
           case .profileNormal:
               self.headerView.isHidden = false
               self.bottomView.isHidden = false
               self.backBtn.isHidden = true
            self.doneBtn.isHidden = true
//               secHeightConstraint.isActive = false
//               priHeightConstraint.isActive = true
               self.secHeightConstraint.priority = UILayoutPriority(rawValue: 500)
               self.priHeightConstraint.priority = UILayoutPriority(rawValue: 999)
              self.ftBtn.isSelected = true
               self.ftBtn.setTitleColor(AppColours.appYellow, for: .normal)
              self.metric = "feet"
           case .profileMenu:
               self.headerView.isHidden = true
               self.bottomView.isHidden = true
               self.backBtn.isHidden = false
            self.doneBtn.isHidden = false
               self.priHeightConstraint.priority = UILayoutPriority(rawValue: 500)
               self.secHeightConstraint.priority = UILayoutPriority(rawValue: 999)
//               priHeightConstraint.isActive = false
//               secHeightConstraint.isActive = true
                self.view.dropShadow(color: UIColor.white, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
               if self.metric == "feet" {
                self.ftBtnTapped(self.ftBtn as Any)
               }else{
                self.cmBtnTapped(self.cmBtn as Any)
               }
            
           default:
               print(")")
           }
       }
  
   
    @IBAction func doneBtnTapped(_ sender: Any) {
        if self.weightVal != nil &&  self.weightVal > 0{
            var val = self.weightVal
            if self.metric == "feet" {
                val = (1000*(self.weightVal * 0.0304084)/1000)
            }
            
            let dict : [String : Any] = ["height": self.feetLbl.text ?? "" ,"metric": "feet"]
            TraineeInfo.details.height = dict
            TraineeDetails.traineeDetails?.trainee_height = Trainee_Height(height: Double(self.feetLbl.text!), metric: self.metric)
            self.heightDelegate?.updateHeightForProfile()
            self.dismiss(animated: true, completion: nil)
        }
        else {
        presentAlertWithTitle(title: "", message: "Please select height", options: "OK") { (option) in

                  }
        }
    }
    @IBAction func backBtnTapped(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
       
    }
    @IBAction func cmBtnTapped(_ sender: Any) {
        if self.cmBtn.isSelected  {
             self.cmBtn.isSelected = false
            self.cmBtn.setTitleColor(UIColor.white, for: .normal)
            self.ftBtn.isSelected = true
            let height =  Double(self.weightVal / 30.48)
            self.ftBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.metric = "feet"
        }
        else {
            self.cmBtn.isSelected = true
            self.ftBtn.isSelected = false
            self.weightLbl.text = String(format: "%.2f", self.weightVal)
            let feet = self.weightVal * 0.0328084
                 let feetShow = Int(floor(feet))
                 let feetRest: Double = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
                 let inches = Int(floor(feetRest * 12))
            feetLbl.text =  "\(feetShow).\(inches)"
            self.cmBtn.setTitleColor(AppColours.appYellow, for: .normal)
             self.ftBtn.setTitleColor(UIColor.white, for: .normal)
            self.metric = "cm"
        }
        if self.navigationType == .profileMenu && self.isOffsetSet == false {
             let offsetY = CGFloat(self.weightVal * 10) - scrollView.contentInset.top
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.origin.x, y: offsetY), animated: true)
            self.isOffsetSet = true
        }
    }
    @IBAction func ftBtnTapped(_ sender: Any) {
        if self.ftBtn.isSelected  {
            self.ftBtn.isSelected = false
            self.ftBtn.setTitleColor(UIColor.white, for: .normal)
             self.cmBtn.isSelected = true
            self.weightLbl.text = String(format: "%.2f", self.weightVal)
            self.cmBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.metric = "cm"
        }
        else {
            self.ftBtn.isSelected = true
            self.cmBtn.isSelected = false
           // let height =  Double(self.weightVal / 30.48)
            let feet = self.weightVal
            feetLbl.text =  String(format: "%.2f", self.weightVal)
            self.ftBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.cmBtn.setTitleColor(UIColor.white, for: .normal)
            self.metric = "feet"
            let fts =    Double(1000 * (feet * 30.4084) / 1000)
                       self.weightVal = fts
            self.weightLbl.text = String(format: "%.2f", self.weightVal)
//            if self.navigationType == .profileMenu && self.isOffsetSet == false {
//                
//                let offsetY = (CGFloat(self.weightVal) + self.scrollView.contentInset.top) * 10
//                scrollView.setContentOffset(CGPoint(x: scrollView.frame.origin.x, y: offsetY), animated: true)
//                self.isOffsetSet = true
//            }
        }
        
    }
    func verticalScrollView()
    {
       
       scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:(view.frame.midX) - 20).isActive = true
       scrollView.topAnchor.constraint(equalTo: headerLbl.topAnchor, constant: 40).isActive = true
     //  scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
       scrollView.heightAnchor.constraint(equalToConstant: 280).isActive = true
         scrollView.widthAnchor.constraint(equalToConstant: 100).isActive = true
       // scrollView = UIScrollView(frame: CGRect(x: Int(self.view.frame.midX) - 20, y: Int(self.headerLbl.frame.maxY) + 30, width: 100, height: 280))
        
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: Int(scrollView.frame.minX), y: Int(scrollView.frame.midY), width: 80, height: 1)
        imageView.backgroundColor = AppColours.textGreen
       // self.view.addSubview(imageView)
        
        weightLbl.frame = CGRect(x: Int(imageView.frame.maxX) + 10, y: Int(imageView.frame.minY) - 20 , width: 100, height: 30)
        weightLbl.textAlignment = .center
        weightLbl.textColor = AppColours.appGreen
        weightLbl.font = UIFont(name: "Lato-Regular", size: 12.0)
        
        
        feetLbl.frame = CGRect(x: Int(imageView.frame.minX) - 10, y: Int(imageView.frame.minY) - 20 , width: 100, height: 30)
        feetLbl.textAlignment = .center
        feetLbl.textColor = AppColours.appGreen
        feetLbl.font = UIFont(name: "Lato-Regular", size: 12.0)
       //  self.view.addSubview(weightLbl)
        
        
//        let imageName = "arrow"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: 10, y: 120, width: 80, height: 5)
//        self.view.addSubview(imageView)
        var origin  = 0
        for i in 1...400 {
            let view = UIView()
            view.backgroundColor = .lightGray
            
            if i % 5 == 0 {
                view.frame = CGRect(x: 0, y: origin, width: 60, height: 2)
                
            } else {
                view.frame = CGRect(x: 0, y: origin , width: 30, height: 2)
            }
            scrollView.addSubview(view)
            origin = Int(view.frame.maxY) + 5
        }
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: 100, height: origin + 100)
         scrollView.delegate = self
    }
}
extension HeightViewController: UIScrollViewDelegate {
    
    // this is for exactly stop on line
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var offset = targetContentOffset.pointee
        let index = (offset.y + scrollView.contentInset.top) / 10
        let roundedIndex = (index)
        
        offset = CGPoint(x: -scrollView.contentInset.left, y: roundedIndex * 10 - scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let offset = scrollView.contentOffset
         let index = (offset.y + scrollView.contentInset.top) / 10
         let roundedIndex = (index)
         
        let selectedNumber = roundedIndex <= 0 ? 0 : Double(roundedIndex)
            let feet = selectedNumber * 0.0304084
                 let feetShow = Int(floor(feet))
                 let feetRest: Double = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
                 let inches = Int(floor(feetRest * 12))
            
        feetLbl.text =  "\(feetShow).\(inches)"
        weightLbl.text =  String(format: "%.2f", selectedNumber)
         self.weightVal = Double((1000 * selectedNumber)/1000)
    }
   
}
extension HeightViewController : BottomViewDelegate {
    func leftBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func rightBtnTapped() {
        if self.weightVal != nil &&  self.weightVal > 0{
            let dict : [String : Any] = ["height": self.feetLbl.text ?? "" ,"metric": "feet"]
            TraineeInfo.details.height = dict
                   let storyboard = UIStoryboard(name: "ActivityVC", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "activityVC")
                   self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
        presentAlertWithTitle(title: "", message: "Please select height", options: "OK") { (option) in

                  }
        }
       
    }
}
