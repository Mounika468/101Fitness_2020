//
//  CardioUpdateVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 05/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class CardioUpdateVC: UIViewController {
var xBarHeight :CGFloat  = 0.0
    @IBOutlet weak var compTxtField: UITextField!
    var navigationView = NavigationView()
    @IBOutlet weak var recomLbl: UILabel!
    var cardio: Cardio?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
               let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
               navigationView.titleLbl.text = "Cardio Update"
               navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               navigationView.saveBtn.isHidden = false
               navigationView.saveBtn .addTarget(self, action: #selector(saveBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
               self.navigationController?.isNavigationBarHidden = true
        let actual = String(describing: (cardio?.distance?.actual)!)
        let completed = String(describing: (cardio?.distance?.completed)!)
        recomLbl.text = actual
        compTxtField.text = completed
          self.hideKeyboardWhenTappedAround()
    }
    
    @objc func backBtnTapped(sender : UIButton){
           self.dismiss(animated: true, completion: {
           })
       }
       @objc func saveBtnTapped(sender : UIButton){
           self.dismiss(animated: true, completion: {
            self.updateCardioAPICall()
           })
       }
    // MARK: - API Call
    func updateCardioAPICall() {
          self.hideKeyboardWhenTappedAround()
        if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
            ProgramDetails.programDetails.subId = id
        }
      let programId = UserDefaults.standard.string(forKey:  ProgramDetails.programDetails.subId)
         // let programId = UserDefaults.standard.string(forKey: UserDefaultsKeys.programId)
        let display = DisplayVal(actual: cardio?.distance?.actual ?? 0, completed: Int(compTxtField.text!))
        let cardioVal = CardioUpdatePostBoday(program_id: programId!, date:  Date.getDateInFormat(format: "dd/MM/yyyy", date: ProgramDetails.programDetails.selectedWODate), trainee_id: UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!, cardioDistanceSet: display,cardioStatus: WOStatus.inProgress)
    
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(cardioVal)
        WOUpdateCalls.setsUpdatePost(parameters: [:], header: [:], dataParams: jsonData, successHandler:
            { [weak self] dayWorks in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name:NSNotification.Name(rawValue: WorkOutsUpdatedNotification), object: dayWorks)
                }
        }, errorHandler: {  error in
            print(" error \(error)")
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        })
    }
  
}
extension CardioUpdateVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}


