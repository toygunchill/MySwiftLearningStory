import UIKit

class CalculateViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightLabel: UILabel!
    //MARK: - Properties
    var calculatorBrain = CalculatorBrain()
    var bmiValue = "0.0"
    //MARK: - IBActions
    @IBAction func hSlider(_ sender: UISlider) {
        let h = String(format: "%.2f",sender.value)
        heightLabel.text = "\(h)m"
    }
    @IBAction func wSlider(_ sender: UISlider) {
        let w = String(format: "%.0f",sender.value)
        weightLabel.text = "\(w)kg"
    }
    @IBAction func calculateButton(_ sender: UIButton) {
        let h = heightSlider.value
        let w = weightSlider.value
        calculatorBrain.calculateBMI(h: h, w: w)
        self.performSegue(withIdentifier: "goToSecond", sender: self)  // self. yapmasakta olur
    }
    //MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecond"{
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
}

