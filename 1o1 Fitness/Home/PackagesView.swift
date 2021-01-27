//
//  PackagesView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 29/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol PackagesViewDelegate {
    func packageSelected(packageInfo: Any?)
    func displayPhoneNumberAlert()
}
class PackagesView: UIView {
    @IBOutlet weak var packageTableView: UITableView!
    @IBOutlet var contentView: UIView!
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var packageDelegate : PackagesViewDelegate?
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    let kHeaderSectionTag: Int = 6900;
    var country = ""
  var packagesArr :TrainerPackage?
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
           Bundle.main.loadNibNamed("PackagesView", owner: self, options: nil)
           addSubview(contentView)
           contentView.frame = self.bounds
           contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           
           let nib = UINib(nibName: "CardStyleTableViewCell", bundle: nil)
           self.packageTableView.register(nib, forCellReuseIdentifier: "cardCell")
        
        sectionNames = [ "beginer", "intermediate", "advanced" ];
        sectionItems = [ ["iPhone 5", "iPhone 5s", "iPhone 6"],
                                   ["iPad Mini", "iPad Air 2", "iPad Pro"],
                                   ["Apple Watch", "Apple Watch 2", "Apple Watch 2 (Nike)"]
                                 ];
                  self.packageTableView.tableFooterView = UIView()
        let location = LocationSingleton.sharedInstance.country ?? ""
        if location.lowercased() == "india" {
            country = "IN"
        }else if location.lowercased() == "us" || location.lowercased() == "united states" {
            country = "US"
        }else {
           let countryCode = TraineeInfo.details.country_code
           if countryCode == "+91" || countryCode == "+ 91" {
               country = "IN"
           }else if countryCode == "+1"{
               country = "US"
           }else {
            country = "NO"
           }
        }
           
       }
//       func setupCertificatesView() {
//           self.certCV.reloadData()
//       }

   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func loadPackagesList() {
        self.packageTableView.reloadData()
    }
    

}
extension PackagesView: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
           // tableView.backgroundView = nil
            return sectionNames.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)!
            messageLabel.sizeToFit()
            self.packageTableView.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            switch section {
            case 0:
                return packagesArr?.beginner?.count ?? 0
            case 1:
                return packagesArr?.intermediate?.count ?? 0
            case 2:
                return packagesArr?.advanced?.count ?? 0
            default:
                return packagesArr?.beginner?.count ?? 0
            }
        } else {
            return 0;
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 100
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.sectionNames.count != 0) {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160.0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let sectionView : SectionView = SectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 160))
        //  sectionView.lblName.text = sectionNames[section] as! String
            sectionView.tag = section
            let headerTapGesture = UITapGestureRecognizer()
            headerTapGesture.addTarget(self, action: #selector(self.sectionHeaderWasTouched(_:)))
            sectionView.addGestureRecognizer(headerTapGesture)
        if section == 1 {
            sectionView.middleTxtImgView.isHidden = false
            sectionView.middleImgView.isHidden = false
            sectionView.txtImgView.isHidden = true
            sectionView.imgView.isHidden = true
            sectionView.middleTxtImgView.image = UIImage(named: sectionNames[section] as! String)
            // sectionView.middleLbl.text = sectionNames[section] as! String
        }
        else
        {
            if section == 2 {
                //sectionView
                sectionView.imgView.image = UIImage(named: "advanced_pack")
            }
             sectionView.txtImgView.image = UIImage(named: sectionNames[section] as! String)
            sectionView.middleTxtImgView.isHidden = true
            sectionView.middleImgView.isHidden = true
            sectionView.txtImgView.isHidden = false
            sectionView.imgView.isHidden = false
        }
            return sectionView
        }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardStyleTableViewCell
        var programName = ""
        var price = ""
        
        switch indexPath.section {
        case 0:
            programName = (packagesArr?.beginner?[indexPath.row].programName) ?? ""
           switch country {
           case "IN":
            if (packagesArr?.beginner?[indexPath.row].priceInRupees) ?? 0 == 0 {
                price = String(format: "$ %.2f",(packagesArr?.beginner?[indexPath.row].priceInDollars)!)
            }else {
                price = String(format: "\u{20B9} %.2f",(packagesArr?.beginner?[indexPath.row].priceInRupees)!)
            }
           case "US":
            price = String(format: "$ %.2f",(packagesArr?.beginner?[indexPath.row].priceInDollars)!)
           default:
            price = String(format: "$ %.2f",(packagesArr?.beginner?[indexPath.row].priceInDollars)!)
           }
        case 1:
            programName = (packagesArr?.intermediate?[indexPath.row].programName) ?? ""
            switch country {
            case "IN":
             if (packagesArr?.intermediate?[indexPath.row].priceInRupees) ?? 0 == 0 {
                 price = String(format: "$ %.2f",(packagesArr?.intermediate?[indexPath.row].priceInDollars)!)
             }else {
                 price = String(format: "\u{20B9} %.2f",(packagesArr?.intermediate?[indexPath.row].priceInRupees)!)
             }
            case "US":
             price = String(format: "$ %.2f",(packagesArr?.intermediate?[indexPath.row].priceInDollars)!)
            default:
             price = String(format: "$ %.2f",(packagesArr?.intermediate?[indexPath.row].priceInDollars)!)
            }
        case 2:
            programName = (packagesArr?.advanced?[indexPath.row].programName) ?? ""
            switch country {
            case "IN":
             if (packagesArr?.advanced?[indexPath.row].priceInRupees) ?? 0 == 0 {
                 price = String(format: "$ %.2f",(packagesArr?.advanced?[indexPath.row].priceInDollars)!)
             }else {
                 price = String(format: "\u{20B9} %.2f",(packagesArr?.advanced?[indexPath.row].priceInRupees)!)
             }
            case "US":
             price = String(format: "$ %.2f",(packagesArr?.advanced?[indexPath.row].priceInDollars)!)
            default:
             price = String(format: "$ %.2f",(packagesArr?.advanced?[indexPath.row].priceInDollars)!)
            }
        default:
            programName = (packagesArr?.advanced?[indexPath.row].programName) ?? ""
            price = String(format: "%.2f", (packagesArr?.advanced?[indexPath.row].priceInRupees)!)
        }
        cell.headerLbl.text = programName
        cell.detailLbl.text = "Price: "  + price
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if TraineeInfo.details.mobile_no.count == 0 {
//            self.packageDelegate?.displayPhoneNumberAlert()
//        }else {
            var sectionData : Any?
            switch indexPath.section {
            case 0:
                sectionData = packagesArr?.beginner?[indexPath.row] as Beginner?
            case 1:
               sectionData = packagesArr?.intermediate?[indexPath.row] as Intermediate?
            case 2:
                sectionData = packagesArr?.advanced?[indexPath.row] as Advanced?
            default:
                sectionData = packagesArr?.beginner?[indexPath.row] as Beginner?
            }
            packageDelegate?.packageSelected(packageInfo: sectionData)
       // }
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let userdefaults = UserDefaults.standard
       let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin)
//            if  savedValue == UserDefaultsKeys.guestLogin {
            if TraineeInfo.details.mobile_no.count == 0 && savedValue != UserDefaultsKeys.guestLogin {
            self.packageDelegate?.displayPhoneNumberAlert()
        }else {
        let headerView = sender.view as! SectionView
        let section    = headerView.tag
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section)
            } else {
                tableViewCollapeSection(self.expandedSectionHeaderNumber)
                tableViewExpandSection(section)
            }
        }
    }
    }
    
    func tableViewCollapeSection(_ section: Int) {
        var sectionData :NSArray?
        switch section {
        case 0:
            sectionData = packagesArr?.beginner as NSArray?
        case 1:
           sectionData = packagesArr?.intermediate as NSArray?
        case 2:
            sectionData = packagesArr?.advanced as NSArray?
        default:
            sectionData = packagesArr?.beginner as NSArray?
        }
        
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData!.count == 0) {
            return;
        } else {
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData!.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.packageTableView.beginUpdates()
            self.packageTableView.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.packageTableView.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int) {
        var sectionData :NSArray?
        switch section {
        case 0:
            sectionData = packagesArr?.beginner as NSArray?
        case 1:
           sectionData = packagesArr?.intermediate as NSArray?
        case 2:
            sectionData = packagesArr?.advanced as NSArray?
        default:
            sectionData = packagesArr?.beginner as NSArray?
        }
        
        if (sectionData!.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData!.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.packageTableView.beginUpdates()
            self.packageTableView.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.packageTableView.endUpdates()
        }
    }
}
