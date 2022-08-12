import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    //MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    //MARK: - Properties
    var storyBrain = StoryBrain()
    //MARK: - IBActions
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        storyBrain.nextSt(userChoice: sender.currentTitle!)
        updateUI()
    }
    //MARK: - Functions
    func updateUI(){
        storyLabel.text = storyBrain.getStoryText()
        choice1Button.setTitle(storyBrain.getChoiceOne(), for: .normal)
        choice2Button.setTitle(storyBrain.getChoiceTwo(), for: .normal)
    }
}

