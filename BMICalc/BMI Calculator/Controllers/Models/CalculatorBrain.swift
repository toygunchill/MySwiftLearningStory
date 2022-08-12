import UIKit

//MARK: - CalculatorBrain
struct CalculatorBrain{
    //MARK: - Properties
    var bmi : BMI?
    //MARK: - Functions
    mutating func calculateBMI(h : Float , w : Float) {
        
        let bmiVal = w/pow(h,2)
        if bmiVal < 18.5 {
            bmi = BMI(value: bmiVal, advice: "Eat more pies!", color: UIColor.blue)
        }else if bmiVal < 24.9 {
            bmi = BMI(value: bmiVal, advice: "Fit as a fiddle!", color: UIColor.green)
        }else {
            bmi = BMI(value: bmiVal, advice: "Eat less pies", color: UIColor.red)
        }
    }
    func getBMIValue() -> String {
        let bmiValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiValue
    }
    func getColor() -> UIColor {
        let color = bmi?.color ?? UIColor.white
        return color
    }
    func getAdvice() -> String? {
        let advice = bmi?.advice ?? "No advice."
        return advice
    }
}
