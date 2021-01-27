//
//  DietPlanViewController.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class DietPlanViewController: UIViewController {
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var jugImgView: UIImageView!
    
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var drinkValueLbl: UILabel!
    @IBOutlet weak var drinkTargetLbl: UILabel!
    @IBOutlet weak var waterBgView: UIView!
    @IBOutlet weak var waterLbl: UILabel!
    @IBOutlet weak var dietCV: UICollectionView! {
        didSet {
            dietCV.showsVerticalScrollIndicator = false
            dietCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var dietLbl: UILabel!
    @IBOutlet weak var semiCircleView: SemiCircleView!
    
    var dietArray : Array = ["Breakfast","Lunch","Snacks","Dinner"]
    
     var dietImages : Array = ["breakfast","lunch","diet","dinner"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        navigationView.titleLbl.text = "Diet Plan"
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        
        let nib = UINib(nibName: "HeaderCollectionViewCell", bundle: nil)
        self.dietCV.register(nib, forCellWithReuseIdentifier:"headerCV")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.dietCV.collectionViewLayout = flowLayout
        self.waterBgView.backgroundColor = UIColor.init(red: 41/255, green: 37/255, blue: 37/255, alpha: 1.0)
        self.waterBgView.layer.cornerRadius = 10
        self.waterBgView.clipsToBounds = true
        self.waterBgView.layer.borderWidth = 1
        self.waterBgView.layer.borderColor = UIColor.init(red: 41/255, green: 37/255, blue: 37/255, alpha: 1.0).cgColor
        
        self.semiCircleView.exploreBtn.isHidden = true
    }
    @IBAction func minusBtnTapped(_ sender: Any) {
    }
    @IBAction func detailsBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Water", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "waterVC") as! WaterViewController
                       //controller.trainersInfo = self.trainersInfo
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func plusBtnTapped(_ sender: Any) {
    }
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
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
extension DietPlanViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dietArray.count
           
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCV", for: indexPath) as! HeaderCollectionViewCell
       // cell.headerLbl.text = self.dietArray[indexPath.row]
        cell.imgView.image = UIImage(named: self.dietImages[indexPath.row])
                   return cell
          
       
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let noOfCellsInRow = 4
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                           + flowLayout.sectionInset.right
                           + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: 90)
                // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "DietList", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DietListVC") as! DietListViewController
                       //controller.trainersInfo = self.trainersInfo
        self.navigationController?.pushViewController(controller, animated: true)

    }
   
}

