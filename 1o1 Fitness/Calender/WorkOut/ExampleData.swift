//
//  ExampleData.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 8/1/17.
//  Copyright © 2017 Yong Su. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
public struct Item {
    var detail: String
    
    public init(detail: String) {
        self.detail = detail
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "Instructions", items: [
        Item(detail: "Apple's ultraportable laptop, trading portability for speed and connectivity.jds kojsakdje jkokf skofjeqkofjewkf ewjfkoewjfkewjfkdjwfkodw jcnfewfjokwjfkewfjwok jwekfjokewf wfndw ewfjeowkf wfnewjifhoewkf wnfjwfhiew fewnfjewhfiewjf wemfkjewhfuiewuoirwekmwkfnwejifhjewoifjw jnwejfhjoiewfkwepf hwefjewfkewl hewjwelfkwdf bewfjewlfkwe fwbfreufijerwflewkfero Apple's ultraportable laptop, trading portability for speed and connectivity.jds kojsakdje jkokf skofjeqkofjewkf ewjfkoewjfkewjfkdjwfkodw jcnfewfjokwjfkewfjwok jwekfjokewf wfndw ewfjeowkf wfnewjifhoewkf wnfjwfhiew fewnfjewhfiewjf wemfkjewhfuiewuoirwekmwkfnwejifhjewoifjw jnwejfhjoiewfkwepf hwefjewfkewl hewjwelfkwdf bewfjewlfkwe fwbfreufijerwflewkfero Apple's ultraportable laptop, trading portability for speed and connectivity.jds kojsakdje jkokf skofjeqkofjewkf ewjfkoewjfkewjfkdjwfkodw jcnfewfjokwjfkewfjwok jwekfjokewf wfndw ewfjeowkf wfnewjifhoewkf wnfjwfhiew fewnfjewhfiewjf wemfkjewhfuiewuoirwekmwkfnwejifhjewoifjw jnwejfhjoiewfkwepf hwefjewfkewl hewjwelfkwdf bewfjewlfkwe fwbfreufijerwflewkfero Apple's ultraportable laptop, trading portability for speed and connectivity.jds kojsakdje jkokf skofjeqkofjewkf ewjfkoewjfkewjfkdjwfkodw jcnfewfjokwjfkewfjwok jwekfjokewf wfndw ewfjeowkf wfnewjifhoewkf wnfjwfhiew fewnfjewhfiewjf wemfkjewhfuiewuoirwekmwkfnwejifhjewoifjw jnwejfhjoiewfkwepf hwefjewfkewl hewjwelfkwdf bewfjewlfkwe fwbfreufijerwflewkfero Apple's ultraportable laptop, trading portability for speed and connectivity.jds kojsakdje jkokf skofjeqkofjewkf ewjfkoewjfkewjfkdjwfkodw jcnfewfjokwjfkewfjwok jwekfjokewf wfndw ewfjeowkf wfnewjifhoewkf wnfjwfhiew fewnfjewhfiewjf wemfkjewhfuiewuoirwekmwkfnwejifhjewoifjw jnwejfhjoiewfkwepf hwefjewfkewl hewjwelfkwdf bewfjewlfkwe fwbfreufijerwflewkfero")
    ]),
    Section(name: "WorkOut Update", items: [
        Item(detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size.")
    ])
]
