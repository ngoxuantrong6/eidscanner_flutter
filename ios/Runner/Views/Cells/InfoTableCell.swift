import UIKit

class InfoTableCell: UITableViewCell {

	@IBOutlet weak private var _titleLbl: UILabel!
	@IBOutlet weak private var _infoLbl: UILabel!

	// --------------------------------------
	// MARK: Class
	// --------------------------------------

	static var height : CGFloat {
		return 60.0
	}

	// --------------------------------------
	// MARK: Life Cycle
	// --------------------------------------

	override public func awakeFromNib() {
		super.awakeFromNib()
	}

	// --------------------------------------
	// MARK: Public
	// --------------------------------------

	func setup(title: String?, info: String?, colorCode: UIColor?, showDisclosure: Bool) {
		_infoLbl.textColor = colorCode != nil ? colorCode : ColorBrand.gtelBrandBlack
		_titleLbl.text = !Utils.stringIsNullOrEmpty(title) ? title : "-"
		_infoLbl.text = !Utils.stringIsNullOrEmpty(info) ? info : "-"
		accessoryType = showDisclosure ? .disclosureIndicator : .none
	}

}
