//
//  Chapter.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/13/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import Foundation

struct Chapter: Codable {
    let chapter: String
    let verses: [Verse]
}
