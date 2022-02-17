//
//  CharacterCustomCell.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import UIKit

class CharacterCustomCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
