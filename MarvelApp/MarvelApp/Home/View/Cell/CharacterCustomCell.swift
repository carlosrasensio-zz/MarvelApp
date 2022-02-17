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

    override func awakeFromNib() {
        super.awakeFromNib()
        setCustomCell()
    }

    func setCustomCell() {
        self.titleLabel.backgroundColor = .red
        self.titleLabel.alpha = 0.5
        self.titleLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
