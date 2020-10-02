//
//  ABCViewController.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//

import UIKit

class ABCViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var aTextView: UITextView!
    
    @IBOutlet weak var bTextView: UITextView!
    
    @IBOutlet weak var cTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeHideKeyboard()
        
        titleTextField.placeholder = generateTitle()
        aTextView.placeholder = "Type your thoughts"
        bTextView.placeholder = "Type your thoughts"
        cTextView.placeholder = "Type your thoughts"
    }
    
    
    @IBAction func createAndSaveDiaryItem(_ sender: UIButton)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }

        // 1
        let managedContext = appDelegate.persistentContainer.viewContext

        // 2
        let entity = DiaryModel.createEntity(in_context: managedContext)!
        let diaryItem =  DiaryModel(entity: entity, insertInto: managedContext)
        
        // 3
        if let text = titleTextField.text, text.isEmpty
        {
            titleTextField.text = titleTextField.placeholder
        }
        diaryItem.title = titleTextField.text
        
        //sistemare sta porcata
        diaryItem.a = aTextView.text
        diaryItem.b = bTextView.text
        diaryItem.c = cTextView.text

        // 4
        do {
            try managedContext.save()
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    private func generateTitle() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let result = formatter.string(from: date)
        
        return "New ABC Notes - " + result
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

extension ABCViewController {
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
}
