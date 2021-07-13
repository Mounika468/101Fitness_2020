//
//  TrainerVideos.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 07/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol TrainerVideosViewDelegate {
    func videoSelected(urlString: String?)
    func youTubeVideoSelected(urlString: String)
}
class TrainerVideos: UIView {

    @IBOutlet weak var videosCV: UICollectionView! {
        didSet {
            videosCV.showsVerticalScrollIndicator = false
            videosCV.showsHorizontalScrollIndicator = false
        }
    }
    @IBOutlet var contentView: UIView!
    var videoDelegate : TrainerVideosViewDelegate?
    var videosArr : [Any]?
    
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
         Bundle.main.loadNibNamed("TrainerVideos", owner: self, options: nil)
         addSubview(contentView)
         contentView.frame = self.bounds
         contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//         let nib = UINib(nibName: "MeatCollectionViewCell", bundle: nil)
//         self.videosCV.register(nib, forCellWithReuseIdentifier:"meatCV")
        let trainerNib = UINib(nibName: "HomeTrainerCollectionViewCell", bundle: nil)
              self.videosCV.register(trainerNib, forCellWithReuseIdentifier:"HomeProfileCV")
         let flowLayoutVertical = UICollectionViewFlowLayout()
         flowLayoutVertical.scrollDirection = .vertical
         self.videosCV.collectionViewLayout = flowLayoutVertical
     }
     func loadVideosList() {
         self.videosCV.reloadData()
     }

}
extension TrainerVideos: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosArr?.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProfileCV", for: indexPath) as! HomeTrainerCollectionViewCell
        cell.backgroundColor = UIColor.clear
        // Get stored fitness type
        if let fitnessType = UserDefaults.standard.string(forKey: "FitnessType") {
            if fitnessType == "Yoga" {
                let fitnessVideo = self.videosArr as! [TrainerYogaVideos]
                let videoInfo = fitnessVideo[indexPath.row].asanaVideo!
                cell.profileImgView.sd_setImage(with: URL(string: videoInfo.videoThumbnailPath!)!, completed: nil)
                cell.ratingBtn.setImage(UIImage(named: ""), for: .normal)
                cell.ratingBtn.isHidden = true
                cell.nameLbl.text = fitnessVideo[indexPath.row].asanaTitle!
            } else {
                let fitnessVideo = self.videosArr as! [TrainerVideoList]
                let videoInfo = fitnessVideo[indexPath.row].exerciseVideo!
                cell.profileImgView.sd_setImage(with: URL(string: videoInfo.videoThumbnailPath!)!, completed: nil)
                cell.ratingBtn.setImage(UIImage(named: ""), for: .normal)
                cell.ratingBtn.isHidden = true
                cell.nameLbl.text = fitnessVideo[indexPath.row].exerciseName!
            }
        } else {
            let fitnessVideo = self.videosArr as! [TrainerVideoList]
            let videoInfo = fitnessVideo[indexPath.row].exerciseVideo!
            cell.profileImgView.sd_setImage(with: URL(string: videoInfo.videoThumbnailPath!)!, completed: nil)
            cell.ratingBtn.setImage(UIImage(named: ""), for: .normal)
            cell.ratingBtn.isHidden = true
            cell.nameLbl.text = fitnessVideo[indexPath.row].exerciseName!
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let noOfCellsInRow = 2

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
               flowLayout.scrollDirection = .vertical
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: 118)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get stored fitness type
        if let fitnessType = UserDefaults.standard.string(forKey: "FitnessType") {
            if fitnessType == "Yoga" {
                let fitnessVideo = self.videosArr as! [TrainerYogaVideos]
                let videoInfo = fitnessVideo[indexPath.row].asanaVideo!
                if videoInfo.videoMp4Destination?.count == 0 {
                    videoDelegate?.youTubeVideoSelected(urlString:videoInfo.asanaVideoSource)
                }else {
                    videoDelegate?.videoSelected(urlString:videoInfo.videoMp4Destination!)
                }
            } else {
                let fitnessVideo = self.videosArr as! [TrainerVideoList]
                let videoInfo = fitnessVideo[indexPath.row].exerciseVideo!
                if videoInfo.videoMp4Destination?.count == 0 {
                    videoDelegate?.youTubeVideoSelected(urlString:videoInfo.exerciseVideoSource!)
                }else {
                    videoDelegate?.videoSelected(urlString:videoInfo.videoMp4Destination!)
                }
            }
            
        } else {
            let fitnessVideo = self.videosArr as! [TrainerVideoList]
            let videoInfo = fitnessVideo[indexPath.row].exerciseVideo!
            if videoInfo.videoMp4Destination?.count == 0 {
                videoDelegate?.youTubeVideoSelected(urlString:videoInfo.exerciseVideoSource!)
            }else {
                videoDelegate?.videoSelected(urlString:videoInfo.videoMp4Destination!)
            }
        }
    }

}
