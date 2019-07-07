//
//  NoteExtension.swift
//  Notes_project
//
//  Created by Днепров Данила on 04/07/2019.
//  Copyright © 2019 Днепров Данила. All rights reserved.
//

import Foundation
import UIKit

extension Note{
    // функция для разбора json объекта
    static func parse(json: [String: Any]) -> Note?{
        /// достаем uid, title, content и color
        let uid = json["uid"] as? String ?? ""
        let title = json["title"] as? String ?? ""
        let content = json["content"] as?  String ?? ""
        let color = UIColor.white
        
        /// достаем важность
        var importance = Importance.usual
        if let imp = json["importance"] as? String{
            importance = Importance(rawValue: imp)!
        }
        
        /// достаем дату
        var selfDestructionDate: Date? = nil
        if let dateStr = json["selfDestructionDate"] as? String {
            let dtf = DateFormatter()
            dtf.timeZone = .current
            dtf.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            selfDestructionDate = dtf.date(from: dateStr)
        }
        
        
        // возвращаем полученный объект
        return Note(uid: uid,
                        title: title,
                        content: content,
                        color: color,
                        importance: importance,
                        selfDestructionDate: selfDestructionDate
                        )
        }
    
    
    
    
    
    // вычислимое свойство для формирования json
    var json: [String: Any]{
        get{
            var json = [String: Any]()
            json["uid"] = self.uid
            json["title"] = self.title
            json["content"] = self.content

            /// если не белый то сохраняем
            if (UIColor.white != self.color){
                var color = [String: Float]()
                let rgba = self.color.rgba
                color["red"] = Float(rgba.red)
                color["green"] = Float(rgba.green)
                color["blue"] = Float(rgba.blue)
                color["alpha"] = Float(rgba.alpha)
                json["color"] = color
            }
            
            // если важность «обычная», НЕ сохраняет её в json.
            if (Importance.usual != self.importance){
                json["impotance"] = self.importance.rawValue
            }
            
            // сохраняем дату
            if let date = self.selfDestructionDate {
                let dtf = DateFormatter()
                dtf.timeZone = .current
                dtf.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                json["selfDestructionDate"] = dtf.string(from: date)
            }
            
            return json
        }
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
