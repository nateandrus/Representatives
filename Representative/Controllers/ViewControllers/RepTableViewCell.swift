//
//  RepTableViewCell.swift
//  Representative
//
//  Created by Nathan Andrus on 2/7/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class RepTableViewCell: UITableViewCell {

    //LandingPad
    var representativeLanding: Representative? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    func updateViews() {
        guard let newRep = representativeLanding else { return }
        nameLabel.text = newRep.name
        partyLabel.text = newRep.party
        districtLabel.text = newRep.district
        phoneLabel.text = newRep.phone
        websiteLabel.text = newRep.link
    }
}
