//
//  FactsViewController.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/20/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var name4: UILabel!
    @IBOutlet weak var name5: UILabel!
    @IBOutlet weak var name6: UILabel!
    
    @IBOutlet weak var factsLabel: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    
    var book: Book?
    var names: NotableNames?
    var nameLabels: [UILabel?] = []
    var dict = [String:Int]()
    var facts = Facts()//?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFile(fileName: "Facts")
    
        wordCountLabel.text = book?.getWordCount()
        print(facts.map?.count)
        if let facts = facts.map{
            factsLabel.text = facts[Int.random(in: 0..<55)]
        }
        if let book = self.book{
            names = NotableNames(book: book)
        }
        
        nameLabels.append(name1)
        nameLabels.append(name2)
        nameLabels.append(name3)
        nameLabels.append(name4)
        nameLabels.append(name5)
        nameLabels.append(name6)
        
        populateDictionary()
        labelTopNames()
    }//end of viewDidLoad
    
    func populateDictionary(){
        for chapter in book!.chapters{
            for verse in chapter.verses{
                for name in names!.names{
                    let str = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let occ = verse.text.components(separatedBy: str).count - 1
                    dict[str] = dict[str, default: 0] + occ
                }
            }
        }
    }// end of func
    
    
    
    func labelTopNames(){
        if let arr = names?.getTopNames(dict: dict) {
            for i in 0...nameLabels.count - 1{
                nameLabels[i]!.text = arr[i]
            }
        }
    }//end of func

    func readFile(fileName: String){
        let url = Bundle.main.url(forResource: fileName, withExtension: "txt")!
        let jsonData = try? JSONDecoder().decode(Facts.self, from: Data(contentsOf: url))
        
        facts = jsonData! //bang!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
