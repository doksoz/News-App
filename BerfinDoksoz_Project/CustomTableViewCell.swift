//
//  CustomTableViewCell1.swift
//  CustomTableView2
//
//  Created by Syed Ali on 11/02/21.
//  Copyright © 2021 CTIS. All rights reserved.
//
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
