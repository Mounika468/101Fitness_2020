//
//  DietListViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 06/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DietListViewController: UIViewController {

    @IBOutlet weak var dietListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
               navigationView.titleLbl.text = "Breakfast"
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
        
        let nib = UINib(nibName: "DietListTableViewCell", bundle: nil)
        self.dietListTableView.register(nib, forCellReuseIdentifier: "dietListCell")
    }
    

    @objc func backBtnTapped(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
       }

}
extension DietListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DietListHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dietListCell")
            as? DietListTableViewCell
            else {
                return UITableViewCell()
        }
//        cell.imgView.isHidden = true
//        cell.detailLbl.isHidden = true
//        cell.headerLbl.text = activityLevel[indexPath.section]
        
        return cell
    }
    
}
