import Foundation

//MARK: - Protocols / CoinManagerDelegate
protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
//MARK: - CoinManager
struct CoinManager {
    //MARK: - Properties
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "77F5DA9B-814A-43AF-BEB6-763DE59AFEF3#"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    //MARK: - Functions
    func getCoinPrice(for currency: String){
           let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
           
           if let url = URL(string: urlString) {
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                       self.delegate?.didFailWithError(error: error!)
                       return
                   }
                   if let safeData = data {
                       if let bitcoinPrice = self.parseJSON(safeData){
                           let priceString = String(format: "%.2f", bitcoinPrice)
                           self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                       }
                   }
               }
               task.resume()
        }
    }
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
