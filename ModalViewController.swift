//
//  ModalViewController.swift
//  BibleFactz
//
//  Created by Anton Elisee on 1/12/20.
//  Copyright © 2020 Anton Elisee. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var max: Double!
    var delegate: ModalDelegate?
    var chapter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.maximumValue = max ?? 20
        if let mx = max{
            print("Max: \(mx)")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        chapter = Int(stepper.value)
        chapterLabel.text = (chapter + 1).description
    }
    
    @IBAction func doneButton(_ sender: Any) {
        //connect controller to here
        /*if let presenter = presentingViewController as? ReaderViewController{
            if let text = chapterLabel.text{
                presenter.num = Int(text) ?? 1
            }
            presenter.dismiss(animated: true, completion: nil)
        }*/
        if let delegate = self.delegate{
            delegate.changeChapter(chapter: chapter)
            print("Delegate ran")
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
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
