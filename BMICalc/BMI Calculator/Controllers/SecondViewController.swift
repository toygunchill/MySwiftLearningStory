import UIKit

class SecondViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    //MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmiValue
        view.backgroundColor = color
        adviceLabel.text = advice
    }
    //MARK: - Properties
    var bmiValue : String?
    var advice : String?
    var color : UIColor?
    //MARK: - IBActions
    @IBAction func recalculatedPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)  //self demesekte olur
    }
}
