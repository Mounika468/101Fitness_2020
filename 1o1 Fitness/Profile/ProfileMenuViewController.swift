//
//  ProfileMenuViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 25/06/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
import Parchment
var xBarHeight : CGFloat = 0.0

class ProfileMenuViewController: UIViewController {
    var traineeName : String = ""
//    required init?(coder: NSCoder) {
//        super.init(coder: coder, options: RoundRectPagerOption())
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.tabMenuView.roundCorners(.layerMinXMaxYCorner, radius: 30.0) test
        
       // self.dataSource = self
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false
        xBarHeight = (navigationController?.navigationBar.frame.maxY)!
        let navigationView = NavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: xBarHeight))
        navigationView.titleLbl.text = self.traineeName
        navigationView.backgroundColor = AppColours.topBarGreen
               navigationView.backBtn .addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
               self.view.addSubview(navigationView)
        //self.navigationController?.navigationBar.alpha = 0.0
       
        
        let storyboard = UIStoryboard(name: "ProfileMenuVC", bundle: nil)
           let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
           let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountViewController")
           let remindersVC = storyboard.instantiateViewController(withIdentifier: "RemindersVC")
           let supportStoryboard = UIStoryboard(name: "SupportViewController", bundle: nil)
           let settingsVC = supportStoryboard.instantiateViewController(withIdentifier: "SupportViewController")
           // Initialize a FixedPagingViewController and pass
           // in the view controllers.
           let pagingViewController = PagingViewController(viewControllers: [
             profileVC,
             accountVC,
             remindersVC,
             settingsVC
           ])
        pagingViewController.menuItemSize = .sizeToFit(minWidth: UIScreen.main.bounds.size.width/4.0, height: 60.0)
        pagingViewController.textColor = UIColor.white
        pagingViewController.font = UIFont(name: "Lato-Semibold", size: 13.0)!
        pagingViewController.borderColor = UIColor.white.withAlphaComponent(0.3)
        pagingViewController.menuBackgroundColor = UIColor.black
        pagingViewController.indicatorColor = AppColours.textGreen
        pagingViewController.selectedTextColor = UIColor.white
        pagingViewController.selectedFont = UIFont(name: "Lato-Semibold", size: 13.0)!
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view, topPosition: xBarHeight)
        pagingViewController.didMove(toParent: self)
         self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func backBtnTapped(sender : UIButton){
              self.navigationController?.popViewController(animated: true)
             }
    
}

//struct RoundRectPagerOption: PageMenuOptions {
//
//    var isInfinite: Bool = false
//
//    var tabMenuPosition: TabMenuPosition = .top
//
//    var menuItemSize: PageMenuItemSize {
//        return .sizeToFit(minWidth: UIScreen.main.bounds.size.width/4.0, height: 60.0)
//    }
//
//    var menuTitleColor: UIColor {
//        return .white
//    }
//
//    var menuTitleSelectedColor: UIColor {
//
//        return .white
//    }
//
//    var menuCursor: PageMenuCursor {
//        let bgColor: UIColor = AppColours.appGreen
//        return .underline(barColor: bgColor, height: 5.0)
//    }
//
//    var font: UIFont {
//        return .systemFont(ofSize: UIFont.systemFontSize)
//    }
//
//    var menuItemMargin: CGFloat {
//        return 0
//    }
//
//    var tabMenuBackgroundColor: UIColor {
//        return .black
//    }
//
//    var tabMenuContentInset: UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 4)
//    }
//
//    public init(isInfinite: Bool = false, tabMenuPosition: TabMenuPosition = .top) {
//        self.isInfinite = isInfinite
//        self.tabMenuPosition = tabMenuPosition
//    }
//}
extension UIView {
  
  func constrainCentered(_ subview: UIView) {
    
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    let verticalContraint = NSLayoutConstraint(
      item: subview,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0)
    
    let horizontalContraint = NSLayoutConstraint(
      item: subview,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0)
    
    let heightContraint = NSLayoutConstraint(
      item: subview,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: subview.frame.height)
    
    let widthContraint = NSLayoutConstraint(
      item: subview,
      attribute: .width,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: subview.frame.width)
    
    addConstraints([
      horizontalContraint,
      verticalContraint,
      heightContraint,
      widthContraint])
    
  }
  
    func constrainToEdges(_ subview: UIView, topPosition: CGFloat) {
    
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    let topContraint = NSLayoutConstraint(
      item: subview,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1.0,
      constant: topPosition)
    
    let bottomConstraint = NSLayoutConstraint(
      item: subview,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 0)
    
    let leadingContraint = NSLayoutConstraint(
      item: subview,
      attribute: .leading,
      relatedBy: .equal,
      toItem: self,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0)
    
    let trailingContraint = NSLayoutConstraint(
      item: subview,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: self,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0)
    
    addConstraints([
      topContraint,
      bottomConstraint,
      leadingContraint,
      trailingContraint])
  }
  
}
