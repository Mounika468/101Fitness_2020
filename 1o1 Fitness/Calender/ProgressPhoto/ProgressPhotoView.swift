//
//  ProgressPhotoView.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 24/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol ProgressPhotoViewDelegate {
func addPhotoBtnTapped()
    func deletePhotoTapped(photo:ProgressPhoto)
    func viewPhotoTapped(photo:ProgressPhoto)
}
class ProgressPhotoView: UIView {

    @IBOutlet weak var photosCV: UICollectionView! {
        didSet {
            photosCV.showsVerticalScrollIndicator = false
            photosCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet var contentView: UIView!
    var progressPhotoDelegate: ProgressPhotoViewDelegate?
     var photosArr : [ProgressPhoto]?
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
              Bundle.main.loadNibNamed("ProgressPhotoView", owner: self, options: nil)
              addSubview(contentView)
              contentView.frame = self.bounds
              contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.addPhotoBtn.layer.cornerRadius = 10
            self.addPhotoBtn.layer.borderColor = AppColours.topBarGreen.cgColor
            self.addPhotoBtn.layer.borderWidth = 0.5
      
              let nib1 = UINib(nibName: "ProgressCollectionViewCell", bundle: nil)
              self.photosCV.register(nib1, forCellWithReuseIdentifier: "progressCVCell")
            let flowLayoutVertical = UICollectionViewFlowLayout()
            flowLayoutVertical.scrollDirection = .vertical
            self.photosCV.collectionViewLayout = flowLayoutVertical
    }
    func refreshViews() {
        self.photosCV.reloadData()
    }

    @IBAction func addPhotoBtnTapped(_ sender: Any) {
        self.progressPhotoDelegate?.addPhotoBtnTapped()
    }
}
extension ProgressPhotoView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.photosArr?.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCVCell", for: indexPath) as! ProgressCollectionViewCell
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.backgroundColor = UIColor.init(red: 41/255, green: 37/255, blue: 37/255, alpha: 1.0).cgColor
        cell.contentView.layer.masksToBounds = false
       let photo = self.photosArr![indexPath.row]
              let imageInfo = photo.imgUrl ?? ""
              if imageInfo.count > 0 {
                  //cell.profileImgView.loadImage(url:URL(string: imageInfo)!)
                  cell.imgView.sd_setImage(with: URL(string: imageInfo)!, completed: nil)
              }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped(sender:)), for: .touchUpInside)
        return cell
        
        
    }
    @objc func deleteBtnTapped(sender : UIButton){
        self.progressPhotoDelegate?.deletePhotoTapped(photo:self.photosArr![sender.tag])

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .vertical
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 100)
        
        
        // return CGSize.init(width: collectionView.frame.width/7 - 5, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.progressPhotoDelegate?.viewPhotoTapped(photo:self.photosArr![indexPath.row])
          
    }
}

