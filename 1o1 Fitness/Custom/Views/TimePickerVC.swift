//
//  TimePickerVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 08/08/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit
protocol TimePickerDelegate {
    func timeSelected(time:String)
}
class TimePickerVC: UIViewController {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    var timePickerDelegate: TimePickerDelegate?
    var selectedTime: String = ""
    var isFromDone : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       timePicker.setValue(UIColor.white, forKeyPath: "textColor")
       // timePicker.locale = Locale.init(identifier: "en_gb")
    }
    
    override func viewDidAppear(_ animated: Bool) {
                    super.viewDidAppear(animated)
                    
                    
                }
          
          
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillDisappear(_ animated: Bool) {
        if self.isFromDone {
              self.timePickerDelegate?.timeSelected(time: self.selectedTime)
        }
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.isFromDone = false
         self.dismiss(animated: false, completion: nil)
    }
    @IBAction func doneBtnTapped(_ sender: Any) {
     let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let formatter = DateFormatter()
                   formatter.timeStyle = .short
        
        let selectedTime = (self.timeConversion24(time12: (formatter.string(from: self.timePicker.date))))
        self.selectedTime = selectedTime
        self.isFromDone = true
            self.dismiss(animated: false, completion: nil)
        }
    
    func timeConversion24(time12: String) -> String {
        let dateAsString = time12
        let df = DateFormatter()
        df.dateFormat = "hh:mma"

        let date = df.date(from: dateAsString)
        df.dateFormat = "HH:mm"

        let time24 = df.string(from: date!)
        print(time24)
        return time24
    }
    
}
