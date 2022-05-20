//
//  CollectionViewCell.swift
//  DemoFullWeatherApp
//
//  Created by KhanhVu on 3/4/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let identifer = "CollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    func config(with model: List) {
        hourLabel.text = "\(getHour(Date(timeIntervalSince1970: Double(model.dt))))"
        iconImage.image = UIImage(named: "\(model.weather[0].icon)")
        tempLabel.text = "\(Int(model.main.temp - 273))°C"
    }
    
    func getHour(_ hour: Date?) -> String {
        guard let input = hour else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
        let hourString = formatter.string(from: input)
        return hourString
    }

}
