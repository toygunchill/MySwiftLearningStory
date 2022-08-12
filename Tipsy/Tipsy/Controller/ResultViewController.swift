import UIKit

class ResultViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    //MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = res
        settingsLabel.text = "Split between \(person) people, with \(tip)% tip."
    }
    //MARK: - Properties
    var tip = 10
    var res = "0.0"
    var person = 2
    //MARK: - IBActions
    @IBAction func recalculatedPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
