//
//  FilterVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 09/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
//protocol selectedValuesDelegate {
//    func selectedCountryId(cname:String, id:String)
//    func selectedState(states:String)
//}
class FilterVC: UIViewController {
    var countriesArr: [CountriesInfo]?
    var statesArr : [StatesInfo]?
    var isContriesSelected: Bool = true
    var selectedCountryId = ""
  //  var delegate: selectedValuesDelegate?
    var selectedIndex : Int = 0
    var filteredArray : [CountriesInfo]?
    @IBOutlet weak var searchTxtField: UITextField! {
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            searchTxtField.leftView = leftView
            searchTxtField.leftViewMode = .always
            self.searchTxtField.attributedPlaceholder = NSAttributedString(string: "Please enter text here",
                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
           // self.searchTxtField.delegate = self
          //
            
            
        }
    }
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterTbleView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchTxtField.addTarget(self, action: #selector(UITextFieldDelegate.textFieldDidEndEditing(_:)), for: UIControl.Event.editingChanged)
        self.view.dropShadow(color: UIColor.white, opacity: 10, offSet: CGSize.init(width: 3, height: 3), radius: 3, scale: true)
        self.filterTbleView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//     if self.isContriesSelected == true {
//            self.getContries()
//        }else {
//            self.getStates(countryId: self.selectedCountryId)
//        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        if self.isContriesSelected == true {
            let country = self.countriesArr![self.selectedIndex]
           // self.delegate?.selectedCountryId(cname: country.name!, id: country.country_id!)
        }else {
             let states = self.statesArr![self.selectedIndex]
         //   self.delegate?.selectedState(states: states.name!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func valueDidModify(_ sender:UITextField){
        if countriesArr?.count ?? 0 > 0 {
        let predicate =  NSPredicate(format:"self.prodName CONTAINS [cd] %@",sender.text ?? "")
        let filteredArray = self.countriesArr!.filter{predicate.evaluate(with: $0)}
        print("filtered array \(filteredArray)")
            self.filteredArray = filteredArray
        }
    }
}

extension FilterVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if countriesArr?.count ?? 0 > 0 {

             self.filteredArray  = self.countriesArr!.filter { ($0.name as! String).range(of: textField.text!, options: [.diacriticInsensitive, .caseInsensitive]) != nil }
            print("filtered array \(filteredArray)")
            
            DispatchQueue.main.async {
                               self.filterTbleView.reloadData()
                           }
            

        }
    }

}
extension FilterVC: UITableViewDelegate, UITableViewDataSource {

 func numberOfSections(in tableView: UITableView) -> Int {
     return 1
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
    }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.isContriesSelected == true {
        if searchTxtField.text?.count ?? 0 > 0 {
            return self.filteredArray?.count ?? 0
        }
        return self.countriesArr?.count ?? 0
    }else {
        return self.statesArr?.count ?? 0
    }
    
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
    cell.backgroundColor = UIColor.black
    cell.textLabel?.textColor = .white
     if self.isContriesSelected == true {
        
        if searchTxtField.text?.count ?? 0 > 0 {
            let country = self.filteredArray![indexPath.row] as! CountriesInfo
            cell.textLabel?.text = country.name
        }else {
        let country = self.countriesArr![indexPath.row] as! CountriesInfo
        cell.textLabel?.text = country.name
        }
    }
     return cell
 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if self.isContriesSelected == true {
//            self.selectedCountryId = self.countriesArr![indexPath.row].country_id!
//        }else {
        if self.isContriesSelected == true {
             if searchTxtField.text?.count ?? 0 > 0 {
                self.searchTxtField.text = self.filteredArray![indexPath.row].name!
             }else {
                self.searchTxtField.text = self.countriesArr![indexPath.row].name!
            }
            
        }
       
            self.selectedIndex = indexPath.row
       // }
    }
 
 func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
     return 0;
 }
}

