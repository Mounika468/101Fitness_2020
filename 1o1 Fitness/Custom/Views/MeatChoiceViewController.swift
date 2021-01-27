//
//  MeatChoiceViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 06/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol MeatChoiceDelegate {
    func meatSelected(meat: [String])
}
enum MeatSelection {
     case chicken
     case pork
     case beef
     case sheep
     case fish
     case all
    case noChicken
    case noPork
    case noBeef
    case noSheep
    case noFish
    case none
}
class MeatChoiceViewController: UIViewController {

    @IBOutlet weak var bgView: CardView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var porkBtn: UIButton!
    @IBOutlet weak var sheepBtn: UIButton!
    @IBOutlet weak var fishBtn: UIButton!
    @IBOutlet weak var beefBtn: UIButton!
    @IBOutlet weak var chickenBtn: UIButton!
    
    var delegate: MeatChoiceDelegate?
    var selectedMeatArr : [String] = []
     var navigationType : NavigationType = .profileNormal
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMeatView()
        bgView.layer.cornerRadius = 20
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        self.okBtn.setTitleColor(AppColours.textGreen, for: .normal)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
              super.viewDidAppear(animated)
              
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
                  self.bgView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
                  self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
                  
              }, completion: nil)
              
          }
    
    func setUpMeatView() {
        view.addSubview(bgView)
       
        bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8).isActive = true
        if self.navigationType == .profileMenu {
             self.setupBtnImages()
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func okBtnTapped(_ sender: Any) {
        if self.selectedMeatArr.count != 0 {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
                      self.bgView.transform = CGAffineTransform.identity
                      self.view.backgroundColor = UIColor(white: 0, alpha: 0.0)
                  }) { (completed) in
                    self.delegate?.meatSelected(meat: self.selectedMeatArr)
                      self.dismiss(animated: false, completion: nil)
                  }
        }
    }
    @IBAction func allBtnTapped(_ sender: Any) {
        if self.allBtn.isSelected {
            self.allBtn.isSelected = false
            self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
             self.porkBtn.isSelected = false
             self.porkBtn.setImage(UIImage(named: "gpig"), for: .normal)
              self.sheepBtn.isSelected = false
            self.sheepBtn.setImage(UIImage(named: "ggoat"), for: .normal)
            self.fishBtn.isSelected = false
            self.fishBtn.setImage(UIImage(named: "gfish"), for: .normal)
            self.beefBtn.isSelected = false
            self.beefBtn.setImage(UIImage(named: "gbeef"), for: .normal)
            self.chickenBtn.isSelected = false
            self.chickenBtn.setImage(UIImage(named: "gchicken"), for: .normal)
             self.processMeatSelection(selection: .none)
        }else {
            self.allBtn.isSelected = true
            self.allBtn.setImage(UIImage(named: "scheck"), for: .normal)
            self.porkBtn.isSelected = true
                       self.porkBtn.setImage(UIImage(named: "cpig"), for: .normal)
            self.sheepBtn.isSelected = true
                       self.sheepBtn.setImage(UIImage(named: "cgoat"), for: .normal)
            self.fishBtn.isSelected = true
                       self.fishBtn.setImage(UIImage(named: "cfish"), for: .normal)
            self.beefBtn.isSelected = true
            self.beefBtn.setImage(UIImage(named: "cbeef"), for: .normal)
            self.chickenBtn.isSelected = true
            self.chickenBtn.setImage(UIImage(named: "cchicken"), for: .normal)
            self.processMeatSelection(selection: .all)
        }
    }
    @IBAction func porkBtnTapped(_ sender: Any) {
        if self.porkBtn.isSelected {
            self.porkBtn.isSelected = false
            self.porkBtn.setImage(UIImage(named: "gpig"), for: .normal)
             self.processMeatSelection(selection: .noPork)
            self.allBtn.isSelected = false
                       self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }else {
            self.porkBtn.isSelected = true
            self.porkBtn.setImage(UIImage(named: "cpig"), for: .normal)
            self.processMeatSelection(selection: .pork)
           
        }
    }
    @IBAction func sheepbtnTapped(_ sender: Any) {
        if self.sheepBtn.isSelected {
            self.sheepBtn.isSelected = false
            self.sheepBtn.setImage(UIImage(named: "ggoat"), for: .normal)
             self.processMeatSelection(selection: .noSheep)
            self.allBtn.isSelected = false
            self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }else {
            self.sheepBtn.isSelected = true
            self.sheepBtn.setImage(UIImage(named: "cgoat"), for: .normal)
             self.processMeatSelection(selection: .sheep)
            
        }
    }
    @IBAction func fishBtnTapped(_ sender: Any) {
       if self.fishBtn.isSelected {
            self.fishBtn.isSelected = false
            self.fishBtn.setImage(UIImage(named: "gfish"), for: .normal)
         self.processMeatSelection(selection: .noFish)
        self.allBtn.isSelected = false
        self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }else {
            self.fishBtn.isSelected = true
            self.fishBtn.setImage(UIImage(named: "cfish"), for: .normal)
         self.processMeatSelection(selection: .fish)
        
        }
    }
    @IBAction func beefBtnTapped(_ sender: Any) {
        if self.beefBtn.isSelected {
            self.beefBtn.isSelected = false
            self.beefBtn.setImage(UIImage(named: "gbeef"), for: .normal)
             self.processMeatSelection(selection: .noBeef)
            self.allBtn.isSelected = false
                       self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }else {
            self.beefBtn.isSelected = true
            self.beefBtn.setImage(UIImage(named: "cbeef"), for: .normal)
             self.processMeatSelection(selection: .beef)
           
        }
    }
    @IBAction func chickenBtnTapped(_ sender: Any) {
        if self.chickenBtn.isSelected {
            self.chickenBtn.isSelected = false
            self.chickenBtn.setImage(UIImage(named: "gchicken"), for: .normal)
             self.processMeatSelection(selection: .noChicken)
            self.allBtn.isSelected = false
            self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }else {
            self.chickenBtn.isSelected = true
            self.chickenBtn.setImage(UIImage(named: "cchicken"), for: .normal)
             self.processMeatSelection(selection: .chicken)
            
        }
    }
    
    func processMeatSelection(selection: MeatSelection) {
       
        switch selection {
        case .chicken:
            self.selectedMeatArr.append("chicken")
        case .pork:
            self.selectedMeatArr.append("pork")
        case .beef:
            self.selectedMeatArr.append("beef")
        case .sheep:
            self.selectedMeatArr.append("sheep")
        case .fish:
            self.selectedMeatArr.append("fish")
        case .all:
            if self.selectedMeatArr.count > 0 {
                       self.selectedMeatArr.removeAll()
                   }
            self.selectedMeatArr = ["chicken","pork","beef","sheep","fish"]
        case .noChicken:
            self.selectedMeatArr = self.selectedMeatArr.filter(){$0 != "chicken"}
        case .noPork:
            self.selectedMeatArr = self.selectedMeatArr.filter(){$0 != "pork"}
        case .noBeef:
            self.selectedMeatArr = self.selectedMeatArr.filter(){$0 != "beef"}
        case .noSheep:
            self.selectedMeatArr = self.selectedMeatArr.filter(){$0 != "sheep"}
        case .noFish:
            self.selectedMeatArr = self.selectedMeatArr.filter(){$0 != "fish"}
        case .none:
            if self.selectedMeatArr.count > 0 {
                       self.selectedMeatArr.removeAll()
                   }
        default:
            if self.selectedMeatArr.count > 0 {
                       self.selectedMeatArr.removeAll()
                   }
        }
        if self.selectedMeatArr.count == 5 {
            self.allBtn.isSelected = true
                       self.allBtn.setImage(UIImage(named: "scheck"), for: .normal)
        }else {
            self.allBtn.isSelected = false
            self.allBtn.setImage(UIImage(named: "ucheck"), for: .normal)
        }
    }
    
    func setupBtnImages(){
        if self.selectedMeatArr.count == 5 {
            self.allBtn.isSelected = true
            self.allBtn.setImage(UIImage(named: "scheck"), for: .normal)
            self.porkBtn.isSelected = true
                       self.porkBtn.setImage(UIImage(named: "cpig"), for: .normal)
            self.sheepBtn.isSelected = true
                       self.sheepBtn.setImage(UIImage(named: "cgoat"), for: .normal)
            self.fishBtn.isSelected = true
                       self.fishBtn.setImage(UIImage(named: "cfish"), for: .normal)
            self.beefBtn.isSelected = true
            self.beefBtn.setImage(UIImage(named: "cbeef"), for: .normal)
            self.chickenBtn.isSelected = true
            self.chickenBtn.setImage(UIImage(named: "cchicken"), for: .normal)
            self.processMeatSelection(selection: .all)
        }else  {
            if self.selectedMeatArr.contains("chicken") {
                self.chickenBtn.isSelected = true
                self.chickenBtn.setImage(UIImage(named: "cchicken"), for: .normal)
                 self.processMeatSelection(selection: .chicken)
            }
            if self.selectedMeatArr.contains("fish") {
                self.fishBtn.isSelected = true
                self.fishBtn.setImage(UIImage(named: "cfish"), for: .normal)
             self.processMeatSelection(selection: .fish)
            }
            if self.selectedMeatArr.contains("pig") {
                self.porkBtn.isSelected = true
                self.porkBtn.setImage(UIImage(named: "cpig"), for: .normal)
                self.processMeatSelection(selection: .pork)
            }
            if self.selectedMeatArr.contains("sheep") {
                self.sheepBtn.isSelected = true
                self.sheepBtn.setImage(UIImage(named: "cgoat"), for: .normal)
                 self.processMeatSelection(selection: .sheep)
            }
            if self.selectedMeatArr.contains("beef") {
                self.beefBtn.isSelected = true
                self.beefBtn.setImage(UIImage(named: "cbeef"), for: .normal)
                 self.processMeatSelection(selection: .beef)
            }
        }
    }
}
