//
//  Notifications.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 02/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
struct Notifications:Codable {
    let notificationId: String?
    let message: String?
    let userId: String?
    let notificationType: String?
    let imgPath: String?
    let notificationHeader:String?
    let read:Bool?
    let time:String?
    let active:Bool?
}
