//
//  BMIBMRViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 16/10/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Alamofire

class BMIBMRViewController: UIViewController {

    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var ftLbl: UIButton!
    @IBOutlet weak var cmLbl: UIButton!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var ageValLbl: UILabel!
    @IBOutlet weak var weightView: CardView!
    @IBOutlet weak var tWeightView: CardView!
    @IBOutlet weak var severView: UIView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var severLbl: UILabel!
    @IBOutlet weak var obesityLbl: UILabel!
    @IBOutlet weak var overLbl: UILabel!
    @IBOutlet weak var normalLbl: UILabel!
    @IBOutlet weak var bmiLeadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var bmiValLbl: UILabel!
    @IBOutlet weak var tweightBtn: UIButton!
    @IBOutlet weak var weightBtn: UIButton!
    @IBOutlet weak var lineView: HorizontalBar!
    @IBOutlet weak var activityCV: UICollectionView! {
        didSet {
            activityCV.showsVerticalScrollIndicator = false
            activityCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var bmrValLbl: UILabel!
    @IBOutlet weak var tWeightTxt: UITextField!
    @IBOutlet weak var tLbBtn: UIButton!
    @IBOutlet weak var tKgBtn: UIButton!
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var lbBtn: UIButton!
    @IBOutlet weak var kgBtn: UIButton!
    var weightMetric: String = ""
    var tweightMetric: String = ""
    var isFromTagetWeight: Bool = false
    var activityArr : Array = ["gsedentary","glightly","gmoderate","gactive","gextra"]
    var selActivityArr : Array = ["csedentary","clightly","cmoderate","cactive","cextra"]
   var textActivityArr : Array = ["Sedentary","Lightly active","Moderately active","Very active","Extra active"]
   //var activityNames : Array = ["Sedentary","Lightly","Moderate","Active","Extra"]
   let activityNames : Array = ["Sedentary (little or no exercise)","Lightly active (light exercise/sports 1-3 days/week)","Moderately active (moderate exercise/sports 3-5 days/week)","Very active (hard exercise/sports 6-7 days a week)","Extra active (very hard exercise/sports & a physical job)"]
    var activityLevelIndex = -1
    var weight : Double = 0.00
    var targetWeight : Double = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.navigationController?.isNavigationBarHidden = false
               let xBarHeight = navigationController?.navigationBar.frame.maxY
               let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight!))
                      navigationView.titleLbl.text = "BMI/BMR"
               navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.saveBtn.isHidden = false
        navigationView.saveBtn.setTitle("Update", for: .normal)
         navigationView.saveBtn.addTarget(self, action: #selector(addBtnTapped(sender:)), for: .touchUpInside)
                      navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
                      self.view.addSubview(navigationView)
               self.navigationController?.isNavigationBarHidden = true
        
        
      //  let lineView = HorizontalBar(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        lineView.colors = [
            UIColor(red: 139.0/255, green: 197.0/255.0, blue: 63.0/255.0, alpha: 0.55), // red
            UIColor(red: 139.0/255, green: 197.0/255.0, blue: 63.0/255.0, alpha: 1.0), // orange
            UIColor(red: 255.0/255, green: 224.0/255.0, blue: 152.0/255.0, alpha: 1.0), // purple
            UIColor(red: 255.0/255, green: 179.0/255.0, blue: 0.0/255.0, alpha: 1.0), // dark blue
            UIColor(red: 255/255, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0), // green
        ]
        lineView.values = [0.20, 0.20, 0.20, 0.20, 0.20]
        lineView.layer.cornerRadius = 20
        lineView.layer.borderColor = UIColor.clear.cgColor
        lineView.layer.borderWidth = 1
        heightView.layer.cornerRadius = 15
        heightView.layer.borderWidth = 1
        ageValLbl.layer.cornerRadius = 15
        ageValLbl.layer.borderWidth = 1
        lineView.layer.borderColor = AppColours.textGreen.cgColor
        ageValLbl.textColor = AppColours.textGreen
        heightLbl.textColor = AppColours.textGreen
        heightView.layer.borderColor = AppColours.textGreen.cgColor
        ageValLbl.layer.borderColor = AppColours.textGreen.cgColor
       // view.addSubview(lineView);
//        weightView.layer.cornerRadius = 15
//        weightView.layer.borderColor = AppColours.appGreen.cgColor
//        weightView.layer.borderWidth = 1
        
//        tWeightView.layer.cornerRadius = 15
//        tWeightView.layer.borderColor = AppColours.appGreen.cgColor
//        tWeightView.layer.borderWidth = 1
        
       // underView.backgroundColor = UIColor(red: 139.0/255, green: 197.0/255.0, blue: 63.0/255.0, alpha: 0.55)
        underView.roundCorners(corners: [.bottomLeft,.topLeft], radius: 10.0)
        severView.roundCorners(corners: [.bottomRight,.topRight], radius: 10.0)
        
        let nib = UINib(nibName: "MeatCollectionViewCell", bundle: nil)
              self.activityCV.register(nib, forCellWithReuseIdentifier:"meatCV")
        let activityLayout = UICollectionViewFlowLayout()
            activityLayout.scrollDirection = .horizontal
            self.activityCV.collectionViewLayout = activityLayout
        self.setupView()
    }
    func setupView() {
        let BMIBMRVal = TraineeDetails.traineeDetails?.bmi_bmr
        let targetWeight = (TraineeDetails.traineeDetails?.targetWeight) ?? 0
        ageValLbl.text =  "\(TraineeDetails.traineeDetails?.age ?? 0)"
        heightLbl.text = String(format: "%.2f", (TraineeDetails.traineeDetails?.trainee_height?.height ?? 0))
        if TraineeDetails.traineeDetails?.trainee_height?.metric == "cm" {
            self.cmLbl.setTitleColor(AppColours.textGreen, for: .normal)
            self.ftLbl.setTitleColor(.white, for: .normal)
        }else {
            self.cmLbl.setTitleColor(.white, for: .normal)
            self.ftLbl.setTitleColor(AppColours.textGreen, for: .normal)
        }

        self.targetWeight = Double(targetWeight)
        if self.targetWeight == 0.0 {
            self.tWeightView.layer.shadowColor = UIColor.lightText.cgColor
        }else {
            self.tWeightView.layer.shadowColor = AppColours.textGreen.cgColor
        }
        self.tweightBtn.setTitle(String(format: "%.2f", targetWeight), for: .normal)
        if BMIBMRVal != nil {
            self.bmrValLbl.textColor = AppColours.appYellow
            self.bmrValLbl.text = "\(BMIBMRVal!.bmr_value!)"
            if BMIBMRVal?.bmi_value ?? 0.0 < 18.5 {
                self.bmiValLbl.isHidden = false
                self.bmiValLbl.text = String(format: "%.0f", BMIBMRVal!.bmi_value!)
                self.normalLbl.isHidden = true
                self.overLbl.isHidden = true
                self.obesityLbl.isHidden = true
                self.severLbl.isHidden = true
                
            }else  if BMIBMRVal?.bmi_value ?? 0.0 >= 18.5 && BMIBMRVal?.bmi_value ?? 0.0 < 24.9 {
                self.bmiValLbl.isHidden = true
                self.normalLbl.text = String(format: "%.0f", BMIBMRVal!.bmi_value!)
                self.normalLbl.isHidden = false
                self.overLbl.isHidden = true
                self.obesityLbl.isHidden = true
                self.severLbl.isHidden = true
                
            }else  if BMIBMRVal?.bmi_value ?? 0.0 >= 25.0 && BMIBMRVal?.bmi_value ?? 0.0 < 29.9 {
                self.bmiValLbl.isHidden = true
                self.overLbl.text = String(format: "%.0f", BMIBMRVal!.bmi_value!)
                self.normalLbl.isHidden = true
                self.overLbl.isHidden = false
                self.obesityLbl.isHidden = true
                self.severLbl.isHidden = true
                
            }else  if BMIBMRVal?.bmi_value ?? 0.0 >= 30.0 && BMIBMRVal?.bmi_value ?? 0.0 < 35.0 {
                self.bmiValLbl.isHidden = true
                self.obesityLbl.text = String(format: "%.0f", BMIBMRVal!.bmi_value!)
                self.normalLbl.isHidden = true
                self.overLbl.isHidden = true
                self.obesityLbl.isHidden = false
                self.severLbl.isHidden = true
                
            }else {
                self.bmiValLbl.isHidden = true
                self.severLbl.text = String(format: "%.0f", BMIBMRVal!.bmi_value!)
                self.normalLbl.isHidden = true
                self.overLbl.isHidden = true
                self.obesityLbl.isHidden = true
                self.severLbl.isHidden = false
            }

        }
        
        let weight = TraineeDetails.traineeDetails?.currrent_weight
        if weight?.metric! == "kg" {
            self.kgBtn.isSelected = true
            self.kgBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
            
            self.tKgBtn.isSelected = true
            self.tKgBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.tLbBtn.isSelected = false
            self.tLbBtn.setTitleColor(UIColor.white, for: .normal)
            self.weightMetric = "kg"
            self.tweightMetric = "kg"
        }else {
            self.lbBtn.isSelected = true
            self.lbBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.kgBtn.isSelected = false
            self.kgBtn.setTitleColor(UIColor.white, for: .normal)
            
            self.tKgBtn.isSelected = false
            self.tLbBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.tLbBtn.isSelected = true
            self.tKgBtn.setTitleColor(UIColor.white, for: .normal)
             self.weightMetric = "lbs"
            self.tweightMetric = "lbs"
        }
        let weightVal = weight?.weight ?? 0.0
        self.weight = weightVal
        self.weightBtn.setTitle(String(format: "%.2f", weightVal), for: .normal)
        if  let activityLevel = TraineeDetails.traineeDetails?.activity_level?.trimmingCharacters(in: .whitespaces) {
            self.activityLevelIndex = self.textActivityArr.firstIndex(of: activityLevel) ?? 0
             TraineeInfo.details.activityLevel = activityLevel

        }
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
    @objc func addBtnTapped(sender : UIButton){
    // self.navigationController?.popViewController(animated: true)
        self.updateBMIBMR()
        
    }
    
    @IBAction func weightBtnTapped(_ sender: Any) {
        isFromTagetWeight = false
        let storyboard = UIStoryboard(name: "WeightVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "weightVC") as! WeightViewController
        controller.navigationType = .profileMenu
         controller.metric = self.weightMetric
        if self.weightMetric == "lbs" {
            controller.weightVal = self.weight/2.20
        }else {
           controller.weightVal = self.weight
        }
        controller.weightDelegate = self
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        controller.view.backgroundColor = UIColor.black
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func tWeightBtnTapped(_ sender: Any) {
        isFromTagetWeight = true
        let storyboard = UIStoryboard(name: "WeightVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "weightVC") as! WeightViewController
        controller.navigationType = .profileMenu
         controller.metric = self.tweightMetric
        if self.tweightMetric == "lbs" {
            controller.weightVal =  self.targetWeight/2.20
        }else {
           controller.weightVal = self.targetWeight
        }
        controller.isTargetWeight = true
        controller.weightDelegate = self
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        controller.view.backgroundColor = UIColor.black
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func tLbBtnTapped(_ sender: Any) {
       
        if self.tLbBtn.isSelected {
            self.tLbBtn.isSelected = false
            self.tLbBtn.setTitleColor(UIColor.white, for: .normal)
            self.tweightMetric = "kg"
            let text =  self.tweightBtn?.titleLabel?.text ?? ""
            let kgs = Double(text) ?? 0.0
            targetWeight = Double((1000 * (kgs / 2.20))/1000)
            //self.tWeightTxt.text = String(format: "%.2f", targetWeight)
            self.tweightBtn.setTitle(String(format: "%.2f", targetWeight), for: .normal)
        }else {
            self.tLbBtn.isSelected = true
            self.tLbBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.tKgBtn.isSelected = false
            self.tKgBtn.setTitleColor(UIColor.white, for: .normal)
            let text =  self.tweightBtn?.titleLabel?.text ?? ""
            let lbs = Double(text) ?? 0.0
            targetWeight = Double((1000 * (lbs * 2.20))/1000)
            self.tweightMetric = "lbs"
            //self.tWeightTxt.text = String(format: "%.2f", targetWeight)
            self.tweightBtn.setTitle(String(format: "%.2f", targetWeight), for: .normal)
        }
    }
    
    @IBAction func tKgBtnTapped(_ sender: Any) {
        if self.tKgBtn.isSelected {
            self.tKgBtn.isSelected = false
            self.tKgBtn.setTitleColor(UIColor.white, for: .normal)
            let text = self.tweightBtn?.titleLabel?.text ?? ""
            let lbs = Double(text) ?? 0.0
           self.tweightMetric = "lbs"
            targetWeight =  Double((1000 * (lbs * 2.20))/1000)
           // self.tWeightTxt.text = String(format: "%.2f", targetWeight)
            self.tweightBtn.setTitle(String(format: "%.2f", targetWeight), for: .normal)
        }else {
            self.tKgBtn.isSelected = true
            self.tKgBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.tLbBtn.isSelected = false
            self.tLbBtn.setTitleColor(UIColor.white, for: .normal)
            let text = self.tweightBtn?.titleLabel?.text ?? ""
            let kgs =  Double(text) ?? 0.0
           self.tweightMetric = "kg"
            targetWeight =  Double((1000 * (kgs / 2.20))/1000)
           // self.tWeightTxt.text = String(format: "%.2f", targetWeight)
            self.tweightBtn.setTitle(String(format: "%.2f", targetWeight), for: .normal)
        }
    }
    @IBAction func lbBtnTapped(_ sender: Any) {
        if self.lbBtn.isSelected {
            self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
            self.weightMetric = "kg"
            let text =  self.weightBtn?.titleLabel?.text ?? ""
            let kgs = Double(text) ?? 0.0
            self.weight = Double((1000 * (kgs / 2.20))/1000)
           // self.weightTxt.text = String(format: "%.2f", self.weight)
            self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
        }else {
            self.lbBtn.isSelected = true
            self.lbBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.kgBtn.isSelected = false
            self.kgBtn.setTitleColor(UIColor.white, for: .normal)
            let text =  self.weightBtn?.titleLabel?.text ?? ""
            let lbs = Double(text) ?? 0.0
            self.weight = Double((1000 * (lbs * 2.20))/1000)
            self.weightMetric = "lbs"
           // self.weightTxt.text = String(format: "%.2f", self.weight)
            self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
        }
    }
    @IBAction func kbBtnTapped(_ sender: Any) {
        if self.kgBtn.isSelected {
            self.kgBtn.isSelected = false
            self.kgBtn.setTitleColor(UIColor.white, for: .normal)
            let text = self.weightBtn?.titleLabel?.text ?? ""
            let lbs = Double(text) ?? 0.0
           self.weightMetric = "lbs"
            self.weight =  Double((1000 * (lbs * 2.20))/1000)
           // self.weightTxt.text = String(format: "%.2f", self.weight)
            self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
            
        }else {
            self.kgBtn.isSelected = true
            self.kgBtn.setTitleColor(AppColours.appYellow, for: .normal)
            self.lbBtn.isSelected = false
            self.lbBtn.setTitleColor(UIColor.white, for: .normal)
            let text = self.weightBtn?.titleLabel?.text ?? ""
            let kgs =  Double(text) ?? 0.0
           self.weightMetric = "kg"
            self.weight =  Double((1000 * (kgs / 2.20))/1000)
            //self.weightTxt.text = String(format: "%.2f", self.weight)
            self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
            //self.weightBtn.setTitle( String(format: "%.2f", self.weight), for: .normal)
        }
    }
    
    func updateBMIBMR() {
      //  TraineeDetails.traineeDetails?.targetWeight = targetWeight
        if self.tweightMetric != self.weightMetric {
            if  self.weightMetric == "kg"  {
               self.weightMetric = "lbs"
                self.weight =  Double((1000 * (self.weight * 2.20))/1000)
                
            }else {
                self.weightMetric = "kg"
                 self.weight =  Double((1000 * ( self.weight / 2.20))/1000)
            }
        }
        
        let currrent_weight : [String : Any] = ["weight": self.weight ,"metric": self.tweightMetric,"updated_on":Date.getCurrentDate()]
        let  currrent_height : [String : Any] = ["height": TraineeDetails.traineeDetails?.trainee_height?.height ,"metric": TraineeDetails.traineeDetails?.trainee_height?.metric ?? ""]
        let postBody : [String: Any] = ["first_name": TraineeDetails.traineeDetails?.first_name ?? "","last_name": TraineeDetails.traineeDetails?.last_name ?? "","currrent_weight":currrent_weight,"created_on": Date.getCurrentDate() ,"updated_on":Date.getCurrentDate(),"user_type":"registered","trainee_id":UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!,"username":TraineeInfo.details.username,"targetWeight":self.targetWeight,"trainee_height":currrent_height,"gender": TraineeDetails.traineeDetails?.gender ?? "","age":TraineeDetails.traineeDetails?.age ?? 0,"profile_submission":true]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: postBody)
       
            let window = UIApplication.shared.windows.first!
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: window)
            }
            let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
            if token == nil {
                AWSUserSingleton.shared.getUserattributes()
            }
            var authenticatedHeaders: [String: String] {
                [
                    HeadersKeys.authorization: "\(HeaderValues.token) \(token!) "
                    
                ]
            }
            
            let urlString = postTraineeDetails
            guard let url = URL(string: urlString) else {return}
            var request        = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("\(HeaderValues.token) \(token!) ", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: postBody)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
            Alamofire.request(request).responseJSON{ (response) in
                
                print("response is \(response)")
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                }
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        if let json = response.result.value as? [String: Any] {
                            print("JSON: \(json)") // serialized json response
                            do {
                                if json[ResponseKeys.data.rawValue] != nil
                                {
                                    if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                        if jsonDict != nil {
                                            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                                      options: .prettyPrinted)
                                            TraineeDetails.traineeDetails = try JSONDecoder().decode(TraineeDetails.self, from: jsonData)
                                            DispatchQueue.main.async {
                                                self.setupView()
                                            }
                                        }else {
                                            
                                        }
                                        
                                    } else {
                                         DispatchQueue.main.async {
                                        self.presentAlertWithTitle(title: "", message: "Profile Update failed", options: "OK") {_ in
                                        }
                                        }
                                    }
                                } }catch let error {
                                    DispatchQueue.main.async {
                                                       LoadingOverlay.shared.hideOverlayView()
                                        self.presentAlertWithTitle(title: "", message: "Profile Update failed", options: "OK") {_ in
                                                                           }
                                                   }
                                   
                            }
                        }
                        
                    default:
                        DispatchQueue.main.async {
                      
                        }
                    }
                }
            }
    }

}
extension BMIBMRViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.activityArr.count
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "meatCV", for: indexPath) as! MeatCollectionViewCell
        cell.imgView.image = UIImage(named: activityArr[indexPath.row])
        cell.nameLbl.text = textActivityArr[indexPath.row]
        cell.contentView.layer.cornerRadius = 0
        if indexPath.row == self.activityLevelIndex {
            cell.imgView.image = UIImage(named: selActivityArr[indexPath.row])
        }
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let noOfCellsInRow = 5
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 90)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
//        let cell = collectionView.cellForItem(at: indexPath) as! MeatCollectionViewCell
//        cell.imgView.image = UIImage(named: selActivityArr[indexPath.row])
//        if self.activityLevelIndex != -1{
//            let cell1 = collectionView.cellForItem(at: IndexPath(row: self.activityLevelIndex, section: 0)) as! MeatCollectionViewCell
//            cell1.imgView.image = UIImage(named: activityArr[self.activityLevelIndex])
//            self.activityLevelIndex = -1
//        }
//
//        TraineeInfo.details.activityLevel = self.activityNames[indexPath.row]
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! MeatCollectionViewCell
//        cell.imgView.image = UIImage(named: activityArr[indexPath.row])
//        TraineeInfo.details.activityLevel = ""
        
        
    }
}
extension BMIBMRViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            
            let maxLength = 5
             let currentString: NSString = textField.text! as NSString
             let newString: NSString =
                 currentString.replacingCharacters(in: range, with: string) as NSString
            
             return newString.length <= maxLength
     
     
    }
}
extension BMIBMRViewController :  UIViewControllerTransitioningDelegate, WeightBackButtonTapDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController:presented, presenting: presenting)
    }
    func updateWeightForProfile() {
        DispatchQueue.main.async {
            if self.isFromTagetWeight {
                let weight = TraineeDetails.traineeDetails?.targetWeight
                self.targetWeight = Double(weight ?? 0)
                 self.tweightBtn.setTitle(String(format: "%.2f", self.targetWeight), for: .normal)
            }else {
                let weight = TraineeDetails.traineeDetails?.currrent_weight
                if weight?.metric! == "kg" {
                    self.kgBtn.isSelected = true
                    self.kgBtn.setTitleColor(AppColours.appGreen, for: .normal)
                    self.lbBtn.isSelected = false
                    self.lbBtn.setTitleColor(UIColor.white, for: .normal)
                    self.weightMetric = "kg"
                }else {
                    self.lbBtn.isSelected = true
                    self.lbBtn.setTitleColor(AppColours.appGreen, for: .normal)
                    self.kgBtn.isSelected = false
                    self.kgBtn.setTitleColor(UIColor.white, for: .normal)
                     self.weightMetric = "lbs"
                }
                self.weight = (weight?.weight)!
                 self.weightBtn.setTitle(String(format: "%.2f", self.weight), for: .normal)
            }
            
        }
    }
}
