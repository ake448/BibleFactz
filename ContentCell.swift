//
//  ContentCell.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var verseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
