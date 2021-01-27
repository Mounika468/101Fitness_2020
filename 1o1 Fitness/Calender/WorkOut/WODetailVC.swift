//
//  WODetailVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 20/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
enum SelectedSections {
    case instructionsExpanded
    case updateExpanded
    case instructionsCollapsed
    case updateCollapsed
}
class WODetailVC: UIViewController {
    @IBOutlet weak var setsView: WOUpdateView!
    @IBOutlet weak var updateArrowSeConstrain: NSLayoutConstraint!
    @IBOutlet weak var woUpdateLblPriConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    var selection : SelectedSections = .instructionsCollapsed
    var sections = sectionsData
    var expandedSectionHeaderNumber: Int = -1
       var expandedSectionHeader: UITableViewHeaderFooterView!
    var setsArray : [Sets]?
    var sectionItems: Array<Any> = []
    var sectionNames: Array<Any> = []
    let kHeaderSectionTag: Int = 6900;
    var selectedIndexPath : Int?
    var updatedRest : String?
    var updatedWeight : String?
    var updatedReps : String?
    var modifiedSets : [Sets]?
    @IBOutlet weak var tableView: UITableView!
     var navigationView = NavigationView()
     var xBarHeight :CGFloat  = 0.0
    var woExercise : WorkoutExercises?
    var prevSelectedSection : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = (navigationController?.navigationBar.frame.maxY)!
        navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.backgroundColor = AppColours.topBarGreen
        navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(navigationView)
        self.navigationController?.isNavigationBarHidden = true
      
        sectionNames = [ "Exercise Info", "Instructions", "Workout metrics" ]
        
        
        let nib = UINib(nibName: "CardStyleTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cardCell")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InstructionCell")
         self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SetsHeadercell")
//        let nib = UINib(nibName: "CardStyleTableViewCell", bundle: nil)
//        self.packageTableView.register(nib, forCellReuseIdentifier: "cardCell")
        
        let nib1 = UINib(nibName: "SetsTableViewCell", bundle: nil)
        self.tableView.register(nib1, forCellReuseIdentifier: "setsCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationView.titleLbl.text = self.woExercise?.exerciseName
        if  let videoThumNail = self.woExercise?.exerciseVideo?.videoThumbnailPath {
            self.imgView.loadImage(url: URL(string: videoThumNail)!)
        }else {
            
        }
        
    }
    @IBAction func playBtnTapped(_ sender: Any) {
        let videos = self.woExercise?.exerciseVideo?.videoMp4Destination
  
        if videos?.count == 0 {
            self.youTubeVideoSelected(urlString:(self.woExercise?.exerciseVideo?.exerciseVideoSource ?? "")!)
        }else {
            let url = NSURL(string: videos ?? "")
            let player = AVPlayer(url: url! as URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
        
       
    }
    
    @objc func backBtnTapped(sender : UIButton){
     self.navigationController?.popViewController(animated: true)
    }
//    func youTubeVideoSelected(urlString:String) {
//        let url  = NSURL(string: urlString)
//
//        if UIApplication.shared.canOpenURL(url! as URL) == true  {
//            UIApplication.shared.open(url! as URL, options: [:]) { (_) in
//
//            }
//        }
//    }
    func youTubeVideoSelected(urlString:String) {
       // let url  = NSURL(string: urlString)
        let storyboard = UIStoryboard(name: "YoutubeVideoVC", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "YoutubeVideoVC") as! YoutubeVideoVC
        let temp = urlString.components(separatedBy: "=")
        if temp.count >= 1 {
            controller.videoId = temp[1]
        }else {
            controller.videoId = ""
        }
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
  
}

extension UIView {

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        self.layer.add(animation, forKey: nil)
    }
   
}

extension WODetailVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
           // tableView.backgroundView = nil
            return sectionNames.count
        }
        return sectionNames.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            switch section {
            case 0:
                return 1
            case 1:
                return 1
            case 2:
                return (self.woExercise?.sets?.count ?? 0) + 1
            default:
                return 1
            }
        } else {
            return 0;
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
       // return UITableView.automaticDimension
        switch indexPath.section {
        case 0:
            return 200.0
        case 1:
            return  UITableView.automaticDimension
        case 2:
            if indexPath.row == 0 {
                return 80
            }
           return 70
        default:
            return 40.0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.sectionNames.count != 0) {
            return self.sectionNames[section] as? String
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let detailSection : DetailSectionHeader = DetailSectionHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
         detailSection.sectionHeaderLbl.text = sectionNames[section] as! String
            detailSection.tag = section
            let headerTapGesture = UITapGestureRecognizer()
            headerTapGesture.addTarget(self, action: #selector(self.sectionHeaderWasTouched(_:)))
            detailSection.addGestureRecognizer(headerTapGesture)
            return detailSection
        }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
             as! UITableViewCell
            let exerInfoView = ExerciseInfoView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.maxX, height: 200))
            exerInfoView.forceLbl.text = self.woExercise?.force?.name
            exerInfoView.prLevelLbl.text = self.woExercise?.force?.name
            exerInfoView.prLevelLbl.text = self.woExercise?.level?.name
             exerInfoView.mtTypeLbl.text = self.woExercise?.mechanicalType?.name
             exerInfoView.eqLbl.text = self.woExercise?.equipment?.name
            if let other = self.woExercise?.otherMuscleWorkout {
                if other.count > 0 {
                    exerInfoView.woTypeLbl.text = self.woExercise?.otherMuscleWorkout?[0].name
                                    exerInfoView.otherMuImgView1.loadImage(url: URL(string: (self.woExercise?.otherMuscleWorkout?[0].imgUrl)!)!)
                }
                if other.count > 1 {
                    exerInfoView.otherMuImgView2.loadImage(url: URL(string: (self.woExercise?.otherMuscleWorkout?[1].imgUrl)!)!)
                }
               
            }
             
            exerInfoView.mainMsImgView.loadImage(url: URL(string: (self.woExercise?.mainMuscleWorkout?.imgUrl)!)!)
           
            cell.contentView.addSubview(exerInfoView)
            return cell
        case 1:
           let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell")
           as! UITableViewCell
           cell.contentView.backgroundColor = UIColor.black
            cell.textLabel?.numberOfLines = 0
           if let instructions = self.woExercise?.instructions {
             cell.textLabel?.text = self.woExercise?.instructions
           }else {
             cell.textLabel?.text = ""
           }
          
           cell.textLabel?.font = UIFont(name: "Lato-Regular", size: 12)
           cell.textLabel?.textColor = UIColor.white
             return cell
        case 2:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SetsHeadercell")
                as! UITableViewCell
                let headerView : SetsHeaderView = SetsHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
                headerView.backgroundColor = UIColor.black
                cell.contentView.backgroundColor = UIColor.black
                cell.contentView.addSubview(headerView)
                return cell
            }else {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: "setsCell")
                  as? SetsTableViewCell
                  else {
                      return UITableViewCell()
              }
              let set = self.woExercise?.sets![indexPath.row - 1]
              cell.recomSet.text = (indexPath.row).stringValue
              cell.recReps.text = set?.reputationValue!.actual.stringValue
              cell.recWeight.text =  set?.maxWeights!.actual.stringValue
              cell.recRest.text = set?.restPeriod!.actual.stringValue
              cell.repTxtField.text = set?.reputationValue!.completed!.stringValue
              cell.compSet.text = (indexPath.row).stringValue
              cell.weightTxtField.text = set?.maxWeights!.completed!.stringValue
              cell.restTxtField.text = set?.restPeriod!.completed!.stringValue
              cell.repTxtField.tag = indexPath.row + repTag
              cell.weightTxtField.tag = indexPath.row + weightTag
              cell.restTxtField.tag = indexPath.row + restTag
              cell.repTxtField.isEnabled = false
              cell.weightTxtField.isEnabled = false
              cell.restTxtField.isEnabled = false
               cell.layoutIfNeeded()
              return cell
            }
        default:
             let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardStyleTableViewCell
             return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sectionData : Any?

        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! DetailSectionHeader
        let section    = headerView.tag
        if section != prevSelectedSection || self.prevSelectedSection != -1 {
            if let foundView = view.viewWithTag(self.prevSelectedSection) as? DetailSectionHeader {
                foundView.arrow.image = UIImage(named: "arrow")
            }
        }
        if (self.expandedSectionHeaderNumber == -1) {
            headerView.arrow.image = UIImage(named: "downArrow")
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section)
        } else {
            headerView.arrow.image = UIImage(named: "arrow")
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section)
            } else {
                 headerView.arrow.image = UIImage(named: "downArrow")
                tableViewCollapeSection(self.expandedSectionHeaderNumber)
                tableViewExpandSection(section)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int) {
        var sectionData :NSMutableArray?
        switch section {
        case 0:
            sectionData = [self.woExercise as Any]
        case 1:
            sectionData = [self.woExercise as Any]
        case 2:
             for i in 0 ..< ((self.woExercise?.sets?.count ?? 0) + 1) {
                           if i == 0{
                               sectionData = ["Test"]
                           }else {
                            sectionData?.add([self.woExercise?.sets?[i - 1] as Any])
                           }
                       }
        default:
            sectionData =  [["Test"],self.woExercise?.sets as Any]
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
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.tableView.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int) {
        var sectionData :NSMutableArray?
        switch section {
        case 0:
            sectionData = [self.woExercise as Any]
        case 1:
            sectionData = [self.woExercise as Any]
        case 2:
            
            for i in 0 ..< ((self.woExercise?.sets?.count ?? 0) + 1) {
                if i == 0{
                    sectionData = ["Test"]
                }else {
                    sectionData?.add([self.woExercise?.sets?[i - 1] as Any])
                }
            }
           
        default:
            sectionData =  [["Test"],self.woExercise?.sets as Any]
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
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.prevSelectedSection = section
            self.tableView.endUpdates()
        }
    }
    
    }

extension Int {
    var stringValue:String {
        return "\(self)"
    }
}
