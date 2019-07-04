//
//  Note.swift
//  Notes_project
//
//  Created by Днепров Данила on 04/07/2019.
//  Copyright © 2019 Днепров Данила. All rights reserved.
//

import Foundation
import UIKit



class Note
{
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    public enum Importance : String{
        case important = "important"
        case usual = "usual"
        case unimortante = "unimortante"
    }

    public init(uid: String = UUID().uuidString,
                title: String,
                content: String,
                color: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                importance: Importance,
                selfDestructionDate: Date? = nil){
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
}
