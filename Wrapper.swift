//
//  Wrapper.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import Foundation

struct Wrapper{
    
    var map: [String:Book] = [:]
    let bookString = """
    Genesis
    Exodus
    Leviticus
    Numbers
    Deuteronomy
    Joshua
    Judges
    Ruth
    1Samuel
    2Samuel
    1Kings
    2Kings
    1Chronicles
    2Chronicles
    Ezra
    Nehemiah
    Esther
    Job
    Psalms
    Proverbs
    Ecclesiastes
    SongofSolomon
    Isaiah
    Jeremiah
    Lamentations
    Ezekiel
    Daniel
    Hosea
    Joel
    Amos
    Obadiah
    Jonah
    Micah
    Nahum
    Habakkuk
    Zephaniah
    Haggai
    Zechariah
    Malachi
    Matthew
    Mark
    Luke
    John
    Acts
    Romans
    1Corinthians
    2Corinthians
    Galatians
    Ephesians
    Philippians
    Colossians
    1Thessalonians
    2Thessalonians
    1Timothy
    2Timothy
    Titus
    Philemon
    Hebrews
    James
    1Peter
    2Peter
    1John
    2John
    3John
    Jude
    Revelation
    """

    lazy var bookNames = bookString.components(separatedBy: "\n")
    
    mutating func getData(){
           for book in bookNames{
                       if let url = URL(string: "https://raw.githubusercontent.com/aruljohn/Bible-kjv/master/\(book).json") {
                           if let data = try? Data(contentsOf: url) {
                               if let jsonData = try? JSONDecoder().decode(Book.self, from: data){
                                   map[book] = jsonData
                               }
                           }
                       }
                   }
            }
    
}
