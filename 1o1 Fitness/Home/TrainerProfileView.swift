//
//  TrainerProfileView.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 07/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol TrainerProfileViewDelegate {
    func certificateSelected(urlString: String?)
    func playButtonTapped()
}
class TrainerProfileView: UIView {

    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var certCV: UICollectionView! {
        didSet {
            certCV.showsVerticalScrollIndicator = false
            certCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet var contentView: UIView!
    var profileDelegate : TrainerProfileViewDelegate?
    var certArray : [Certification]?
   
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
        Bundle.main.loadNibNamed("TrainerProfileView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.nameLbl.textColor = AppColours.appGreen
        self.aboutLbl.textColor = UIColor.white
        let nib = UINib(nibName: "CertCollectionViewCell", bundle: nil)
        self.certCV.register(nib, forCellWithReuseIdentifier:"certCV")
        let flowLayoutVertical = UICollectionViewFlowLayout()
        flowLayoutVertical.scrollDirection = .horizontal
        self.certCV.collectionViewLayout = flowLayoutVertical
        self.contentView.bringSubviewToFront(self.playBtn)
        self.bringSubviewToFront(self.playBtn)
       // self.imgView.isHidden = true
        self.imgView.layer.borderColor = UIColor.clear.cgColor
        self.imgView.layer.borderWidth = 0.5
         self.imgView.layer.cornerRadius = 10
    }
    func setupCertificatesView() {
        self.certCV.reloadData()
         self.contentView.bringSubviewToFront(self.playBtn)
        self.bringSubviewToFront(self.playBtn)
    }
    func setRatings(rating:String) {
     self.ratingBtn.setTitle(rating, for: .normal)
    }
    @IBAction func playButtonTapped(_ sender: Any) {
        self.profileDelegate?.playButtonTapped()
    }
}
extension TrainerProfileView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return certArray?.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certCV", for: indexPath) as! CertCollectionViewCell
        let certificate = certArray![indexPath.row]
        cell.certLbl.text = certificate.name ?? ""
        cell.certLbl.textColor = AppColours.textGreen
                   return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 60)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            let noOfCellsInRow = 2
//
//            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//               flowLayout.scrollDirection = .vertical
//            let totalSpace = flowLayout.sectionInset.left
//                + flowLayout.sectionInset.right
//                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
//
//            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
//
//            return CGSize(width: size, height: 60)
//    }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let certificate = self.certArray![indexPath.row]
    profileDelegate?.certificateSelected(urlString:certificate.certificateDestinationUploadUrl)
    }

}
