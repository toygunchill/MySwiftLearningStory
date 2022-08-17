import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    @IBOutlet weak var diceImageViewOne: UIImageView!
    //MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        //WHO            WHAT    VALUE
        diceImageViewOne.image = #imageLiteral(resourceName: "DiceThree")
        diceImageViewTwo.image = #imageLiteral(resourceName: "DiceFive")
        //diceImageViewOne.alpha = 0.5
    }
    //MARK: - IBActions
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let diceArray = [ #imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix") ] //asla değiştirmeyeceğiz o yüzden let yaptık.
        diceImageViewOne.image = diceArray[Int.random(in: 0...5)] // burada direkt istenen aralıkta rastgele sayı seçtik ve bu sayı dizide ki elemanı temsil etti.
        diceImageViewTwo.image = diceArray.randomElement() // burada direkt rastgele eleman seçtik
    }
}

