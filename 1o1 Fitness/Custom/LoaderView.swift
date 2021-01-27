//
//  LoaderView.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 27/12/19.
//  Copyright © 2019 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import UIKit
public class LoadingOverlay{

    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var bgView = UIView()

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    public func showOverlay(view: UIView) {

        bgView.frame = view.frame
        bgView.backgroundColor = UIColor.clear
        bgView.addSubview(overlayView)
        bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.center = view.center
        overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
        overlayView.backgroundColor = UIColor.gray
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            // Fallback on earlier versions
            activityIndicator.style = .gray
        }
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)

        overlayView.addSubview(activityIndicator)
        view.addSubview(bgView)
        self.activityIndicator.startAnimating()

    }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        bgView.removeFromSuperview()
    }
}

//LoadingOverlay.shared.showOverlay(view: UIApplication.shared.keyWindow!)

