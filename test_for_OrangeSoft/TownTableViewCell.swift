//
//  TownTableViewCell.swift
//  test_for_OrangeSoft
//
//  Created by elf on 26.09.2021.
//

import UIKit

class TownTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var cityCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
