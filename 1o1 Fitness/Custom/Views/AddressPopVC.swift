//
//  AddressPopVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 10/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol selectedValuesDelegate {
    func selectedCountryId(cname:String, id:String)
    func selectedState(states:String)
}
class AddressPopVC: UIViewController {

    @IBOutlet weak var addTbleView: UITableView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var popUp: UIView!
    var countriesArr: [CountriesInfo]?
       var statesArr : [StatesInfo]?
       var isContriesSelected: Bool = true
       var selectedCountryId = ""
       var delegate: selectedValuesDelegate?
       var selectedIndex : Int = 0
       var filteredArray : [CountriesInfo]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        popUp.backgroundColor = .black
        popUp.layer.cornerRadius = 20
               popUp.layer.borderWidth = 0.5
        popUp.layer.borderColor = AppColours.textGreen.cgColor
        self.addTbleView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addTbleView.tableFooterView = UIView()
         setUpMeatView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
                 super.viewDidAppear(animated)
                 
                 UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
                     self.popUp.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
                     self.view.backgroundColor = UIColor(white: 0, alpha: 0.8)
                     
                 }, completion: nil)
                 
             }
       
       func setUpMeatView() {
           view.addSubview(popUp)
          
           popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
           popUp.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
         //popUp.heightAnchor.constraint(equalToConstant: view.bounds.height*0.8).isActive = true
           
           if isContriesSelected {
            self.headerLbl.text = "Countries"
            self.getContries()
           }else {
            self.headerLbl.text = "States"
            self.getStates(countryId: self.selectedCountryId)
        }
       }

   func getContries() {
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        GetLocationsAPI.getCountries(header: authenticatedHeaders, successHandler: { [weak self] countries in
            if countries != nil {
                self?.countriesArr = countries
                DispatchQueue.main.async {
                    self?.addTbleView.reloadData()
                }
            }
        }) { [weak self] error in
            print(" error \(error)")
            
        }
        
    }
    func getStates(countryId: String) {
        
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
        var authenticatedHeaders: [String: String] {
            [
                HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                HeadersKeys.contentType: HeaderValues.json
            ]
        }
        GetLocationsAPI.getStates(countriesID: countryId, header: authenticatedHeaders, successHandler: { [weak self] states in
            if states != nil {
                self?.statesArr = states
                DispatchQueue.main.async {
                    self?.addTbleView.reloadData()
                }
            }
        }) { [weak self] error in
            print(" error \(error)")
            
        }
        
    }

}
extension AddressPopVC: UITableViewDelegate, UITableViewDataSource {

 func numberOfSections(in tableView: UITableView) -> Int {
     return 1
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
    }
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isContriesSelected {
        return self.countriesArr?.count ?? 0
    }else {
        return self.statesArr?.count ?? 0
    }
    
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
    cell.backgroundColor = UIColor.black
    cell.textLabel?.textColor = .white
      cell.textLabel?.font = UIFont(name: "Lato-Semibold", size: 14.0)!
    cell.textLabel?.textAlignment = .center
    let view = UIView(frame: CGRect(x: 0, y:0 , width: cell.contentView.frame.width, height: 1))
    view.alpha = 0.5
    view.backgroundColor = .white
    cell.contentView.addSubview(view)
     if isContriesSelected {
        let country = self.countriesArr![indexPath.row]
        cell.textLabel?.text = country.name!
     }else {
        let states = self.statesArr![indexPath.row]
         cell.textLabel?.text = states.name!
     }
     return cell
 }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if isContriesSelected {
             let country = self.countriesArr![indexPath.row]
            self.selectedCountryId = country.country_id!
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveLinear, animations: {
                           self.popUp.transform = CGAffineTransform.identity
                           self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
                       }) { (completed) in
                          self.delegate?.selectedCountryId(cname: country.name!, id: self.selectedCountryId)
                           self.dismiss(animated: false, completion: nil)
                       }
          

           
         }else {
             let states = self.statesArr![indexPath.row]
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .layoutSubviews, animations: {
                self.popUp.transform = CGAffineTransform.identity
                self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
            }) { (completed) in
                 self.delegate?.selectedState(states: states.name!)
                self.dismiss(animated: false, completion: nil)
            }
           

        }
        
               

    }
 
 func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
     return 0;
 }
}
