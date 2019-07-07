//
//  FileNotebook.swift
//  Notes_project
//
//  Created by Днепров Данила on 04/07/2019.
//  Copyright © 2019 Днепров Данила. All rights reserved.
//

import Foundation


class FileNotebook
{
    private(set) var notes: [Note] = [Note]() // закрытая для внешнего изменения, но открытая для получения коллекция Note.

    
    // функция добавления новой заметки
    public func add(_ note: Note){
        // можно добавить проверки на uid
        notes.append(note)
    }
    
    
    // функцию удаления заметки на основе uid
    public func remove(with uid: String) {
        notes.removeAll(where: { $0.uid == uid})
    }
    
    
    // функция сохранения всей записной книжки в файл
    public func saveToFile() {
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        let dirurl = path!.appendingPathComponent("notesstore")
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: dirurl.absoluteString, isDirectory: &isDir), !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(at: dirurl, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("somethin wrong")
            }
            print("Created")
        }
        let filename = dirurl.appendingPathComponent("notes.sav")
        do {
            let data = try JSONSerialization.data(withJSONObject: notes, options: [])
            try data.write(to: filename)
            print(FileManager.default.createFile(atPath: filename.absoluteString, contents: data, attributes: nil))
        } catch {
            print("somemthing wrong")
        }
    }
    
    
    // функция загрузки записной книжки из файла
    public func loadFromFile() {
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        let dirurl = path!.appendingPathComponent("notesstore")
        
        let filename = dirurl.appendingPathComponent("notes")
        do {
            let data = try Data(contentsOf: filename)
            let dict = try JSONSerialization.jsonObject(with: data, options: []) // посмотри потом эту строчку
        } catch {
            print("something wrong")
        }
    }
}
