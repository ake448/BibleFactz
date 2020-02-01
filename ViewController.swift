//
//  ViewController.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//
//
//  ViewController.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var factsButton: UIButton!
    @IBOutlet weak var readerButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var bookLabel: UILabel!
    
    var fakeData = [String]()
    var bible: Wrapper = Wrapper()
    var selectedRow = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confButtons()
        makeBgImage()
        DispatchQueue.global(qos: .background).async {
            self.bible.getData()
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        bookLabel.isHidden = true
    }
    
    @IBAction func toReaderView(_ sender: UIButton) {
        if selectedRow == ""{
            bookLabel.isHidden = false
            bookLabel.text = "Choose a Book below."
        } else {
            performSegue(withIdentifier: "toReader", sender: self)
        }
    }//end of IBAction
    
    @IBAction func toFacts(_ sender: Any) {
        if selectedRow == ""{
            bookLabel.isHidden = false
            bookLabel.text = "Choose a Book below."
        } else {
            performSegue(withIdentifier: "facts", sender: self)
        }
    }

    func confButtons(){
        factsButton.layer.cornerRadius = 4.0
        factsButton.layer.borderWidth = 2
        factsButton.layer.borderColor = UIColor.red.cgColor
        readerButton.layer.cornerRadius = 4.0
        readerButton.layer.borderWidth = 2
        readerButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    func makeBgImage(){
        let bgImgView = UIImageView(image: UIImage(named: "bookImg"))
        bgImgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(bgImgView)
        
        bgImgView.contentMode = .scaleAspectFill
        
        bgImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImgView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        bgImgView.alpha = 0.09
        self.view.sendSubviewToBack(bgImgView)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bible.bookNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bible.bookNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = bible.bookNames[row]
        bookLabel.isHidden = false
        bookLabel.text = selectedRow
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReader"{
            let vc = segue.destination as! ReaderViewController
            vc.title = selectedRow
            
            let book = bible.map[selectedRow]
            vc.book = book
        } else if segue.identifier == "facts"{
            let vc = segue.destination as! FactsViewController
            vc.title = selectedRow
            
            let book = bible.map[selectedRow]
            vc.book = book
        }//end of if
    }
    
}
