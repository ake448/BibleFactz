//
//  NotableNames.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/20/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import Foundation
struct NotableNames {
    let nameString = """
    Aaron
    Abel
    Abraham
    Adam
    Andrew
    Asher
    Barak
    Barnabas
    Bartholomew
    Benjamin
    Dan
    David
    Elijah
    Elon
    Ephraim
    Ezekiel
    Gabriel
    Gad
    Gideon
    Hillel
    Hiram
    Immanuel
    Isaac
    Ishmael
    Israel
    Jabin
    Jacob
    James
    Jared
    Jesse
    Jesus
    Jethro
    Joel
    John
    Jonathan
    Jokim
    Joseph
    Joshua
    Josiah
    Judah
    Levi
    Lucas
    Luke
    Mark
    Matthew
    Malachi
    Meshach
    Micah
    Moses
    Noah
    Paul
    Peter
    Philip
    Reuben
    Rufus
    Samson
    Saul
    Samuel
    Seth
    Silas
    Simon
    Solomon
    Stephen
    Thaddeus
    Thomas
    Timothy
    Zacharias
            Abigail
            Ada
            Ahlai
            Angel
            Anna
            Apphia
            Atarah
            Athaliah
            Bathsheba
            Bilhah
            Candace
            Chloe
            Claudia
            Damaris
            Deborah
            Delilah
            Diana
            Dinah
            Elizabeth
            Esther
            Eunice
            Eve
            Hagar
            Hannah
            Huldah
            Jedidah
            Jezebel
            Joanna
            Judith
            Julia
            Leah
            Lois
            Lydia
            Martha
            Mary
            Michaiah
            Milcah
            Miriam
            Naarah
            Naomi
            Oprah
            Phebe
            Priscilla
            Rachel
            Rebecca
            Ruth
            Salome
            Sapphira
            Sarai
            Sherah
            Susanna
            Tabitha
            Tamar
            Tirza
            Vashti
            Zilpah
    """
    
    var book: Book?
    var names = [String]()
    
    init(book: Book) {
        self.book = book
        names = nameString.components(separatedBy: "\n")
    }
    
    func searchNames(_ verseText:String, _ name:String) -> Int{
        let array = verseText.components(separatedBy: " ")
        var newArray = [String]()
        for i in array{
            var str = i
            //remove punctuation from scan
            if i.last!.isPunctuation{
                str.removeLast()
                newArray.append(str)
            } else {
                newArray.append(str)
            }
        }
        let nameCount = newArray.filter{$0.lowercased() == name.lowercased()}.count
        return nameCount
    }
    
    func getNameDictionary() -> [String:Int] {
        var dict = Dictionary<String, Int>()
        for chapter in book!.chapters{
            for verse in chapter.verses{
                for name in names{
                    dict[name] = searchNames(verse.text, name)
                }
            }
        }
        return dict
    }
    
    func getTopNames(dict: [String:Int]) -> [String] {
        var arr = [String]()
        var tempDict = dict
        for _ in 0...5{
            let max = tempDict.values.max()
            let keyArr = (tempDict as NSDictionary).allKeys(for: max!)
            let key = keyArr.first as! String
            arr.append(key)
            print("Max: \(max!), Key: \(key)")
            tempDict.removeValue(forKey: key)
        }
        return arr
    }

    
    
}
