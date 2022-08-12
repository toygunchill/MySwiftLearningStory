import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: - Lifecyles
    let eggTimes = ["Soft":300,"Medium":420,"Hard":720]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player : AVAudioPlayer!
    //MARK: - IBActions
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle! // asla başarısız olmayacağını biliyoruz.
        totalTime = eggTimes[hardness]! // asla başarısız olmayacağını biliyoruz.
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    //MARK: - Functions
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        }
        if secondsPassed == totalTime {
            timer.invalidate()
            
            titleLabel.text = "DONE!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
