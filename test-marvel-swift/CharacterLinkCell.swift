//
//  CharacterLinkCell.swift
//  test-marvel-swift
//
//  Created by Sergey Sedov on 17/03/16.
//  Copyright © 2016 Sergey Sedov. All rights reserved.
//

import UIKit

class CharacterLinkCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(link: Link) {
        self.nameLabel.text = link.type.name
    }

}
