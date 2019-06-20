//
//  ContentCell.swift
//  CustomHeaderAndSectionedTableViewWithRxSwift
//
//  Created by 하윤 on 20/06/2019.
//  Copyright © 2019 Supa HaYun. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var lbl_toDo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
