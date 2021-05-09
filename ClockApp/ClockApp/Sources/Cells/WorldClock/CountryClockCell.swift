//
//  CountryClockCell.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/29.
//

import UIKit

class CountryClockCell: UITableViewCell {
    static let identifier = "CountryClockCell"

    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
