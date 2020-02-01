//
//  Book.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import Foundation

struct Book: Codable {
    let book: String
    let chapters: [Chapter]
    
    func get(chapter: Int, verse: Int) -> String{
        return chapters[chapter - 1].verses[verse - 1].text
    }
    
    func getWholeChapter(chapter: Int) ->String{
        var string = ""
        for verse in chapters[chapter - 1].verses{
            string += verse.text
            string += "\n"
        }
        
        return string
    }
    
    func getWordCount() -> String{
        var wordCountt = 0
        for chapter in chapters{
            for verse in chapter.verses{
                let sentence = verse.text
                    let words =  sentence.split { !$0.isLetter }
                    wordCountt += words.count
            }
        
        }
        return "\(wordCountt)"
    }
}
