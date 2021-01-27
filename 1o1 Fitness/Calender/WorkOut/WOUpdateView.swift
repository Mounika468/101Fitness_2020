//
//  WOUpdateView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 20/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol SetsUpdateDelegate {
    func setUpdated(set: Sets)
}
class WOUpdateView: UIView {

    @IBOutlet weak var updateTableView: UITableView!
    @IBOutlet var contentView: UIView!
    var setsUpdateDelagate : SetsUpdateDelegate?
    var setsArray : [Sets]?
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
            Bundle.main.loadNibNamed("WOUpdate", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            contentView.backgroundColor = UIColor.clear
            let nib = UINib(nibName: "SetsTableViewCell", bundle: nil)
            self.updateTableView.register(nib, forCellReuseIdentifier: "setsCell")
            
    }
    func reloadTable() {
        DispatchQueue.main.async {
             self.updateTableView.reloadData()
        }
       
    }
}
extension WOUpdateView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setsArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "setsCell")
            as? SetsTableViewCell
            else {
                return UITableViewCell()
        }
        let set = self.setsArray![indexPath.row]
        cell.recomSet.text = String(describing: indexPath.row + 1)
        cell.recReps.text = String(describing: set.reputationValue!.actual)
        cell.recWeight.text = String(describing: set.maxWeights!.actual)
        cell.recRest.text = String(describing: set.restPeriod!.actual)
        cell.repTxtField.text = String(describing: set.reputationValue!.completed)
        cell.compSet.text = String(describing: indexPath.row + 1)
         cell.weightTxtField.text = String(describing: set.maxWeights!.completed)
         cell.restTxtField.text = String(describing: set.restPeriod!.completed)
         cell.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : SetsHeaderView = SetsHeaderView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80))
        return headerView
    }
}
