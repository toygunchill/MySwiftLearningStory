import UIKit

class CalculatorViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var splitNumberLevel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    //MARK: - Properties
    var tip = 0.1
    var bill = 0.0
    var personNum = 2
    var finalRes = "0.0"
    //MARK: - IBActions
    @IBAction func tipChanged(_ sender: UIButton) {
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        zeroPctButton.isSelected = false
        sender.isSelected = true
        let buttonTitle = sender.currentTitle!
        let buttonPercent = String(buttonTitle.dropLast())
        let buttonNumber = Double(buttonPercent)!
        tip = buttonNumber / 100
        billTextField.endEditing(true)
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        personNum = Int(sender.value)
        splitNumberLevel.text = personNum.description  // String(format: "%.0f", sender.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        bill = Double(billTextField.text!) ?? 0.0
        if billTextField.text != ""{
            let perPerson = (bill + (bill*tip)) / Double(personNum)
            finalRes = String(format: "%.2f" ,perPerson)
        }
        self.performSegue(withIdentifier: "goToRes", sender: self)
    }
    //MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRes" {
            let descriptionVC = segue.destination as! ResultViewController
            descriptionVC.res = finalRes
            descriptionVC.tip = Int(tip * 100)
            descriptionVC.person = personNum
        }
    }
    
}

