//
//  ReaderViewController.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import UIKit
import AVFoundation

class ReaderViewController: UITableViewController, ModalDelegate {
    
    var text: String?
    var book: Book?
    var num = 0
    var selectedRow: Int?
    let synth = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Num: \(num)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Chapter \(num + 1)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRow{
            return 205
        } else {
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book!.chapters[num].verses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as! ContentCell
        
        let counter = indexPath.row + 1
        
        cell.verseLabel.text = book?.chapters[num].verses[indexPath.row].text
        
        cell.voiceButton.tag = indexPath.row
        
        //incrementing numbers for chapterLabel
        cell.chapterLabel.text = "Verse \(counter)"
        
        return cell
    }
    
    @IBAction func speakVerse(_ sender: UIButton) {
        if let myText = book?.chapters[num].verses[sender.tag].text{
            let utterance = AVSpeechUtterance(string: myText)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.45
            
            sender.isSelected = true
            
            if synth.isSpeaking == false {
                synth.speak(utterance)
            } else {
                sender.isSelected = false
                synth.stopSpeaking(at: AVSpeechBoundary.immediate)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContentCell
        
        if selectedRow == indexPath.row{
            cell.verseLabel.sizeToFit()
            selectedRow = nil
            print("Number of Lines: \(cell.verseLabel.numberOfLines)")
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            cell.verseLabel.sizeToFit()
            cell.verseLabel.numberOfLines = 0
            selectedRow = indexPath.row
            print("Row Selected: \(indexPath.row)")
            print("Number of Lines(w): \(cell.verseLabel.numberOfLines)")
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookModal"{
            let vc = segue.destination as! ModalViewController
            if let count = book?.chapters.count{
                vc.max = Double(count)
                vc.delegate = self
            }
            if let view = vc.view{
                view.backgroundColor = .clear
                if let imgView = vc.self.imgView{
                    view.sendSubviewToBack(imgView)
                    imgView.layer.cornerRadius = 5.0
                }
                print("passed")
            }
        }
    }//end of prepare(_:,_:)
    
    func changeChapter(chapter: Int) {
        num = chapter
        print(num)
        tableView.reloadData()
    }
}

protocol ModalDelegate {
    func changeChapter(chapter: Int)
}

