//
//  ViewController.swift
//  DemoApp
//
//  Created by Heeseung Seo on 29/03/2019.
//  Copyright © 2019 Seorenn. All rights reserved.
//

import Cocoa
import SRTextInputSourceManager

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    lazy var inputSources: [SRTextInputSource] = {
        return SRTextInputSourceManager.shared.inputSources.filter { $0.isSelectCapable && $0.isEnabled && $0.isInputable }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SRTextInputSourceManager.shared.inputSourceSelected = { () in
            guard let currentInputSource = SRTextInputSourceManager.shared.activatingInputSource else { return }
            print("Current Input Source: \(currentInputSource)")
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return inputSources.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnIdentifier = tableColumn?.identifier.rawValue else {
            assertionFailure()
            return nil
        }

        let item = inputSources[row]

        if columnIdentifier == "nameColumn" {
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "nameCell"), owner: nil) as! NSTableCellView
            cell.textField?.stringValue = item.localizedName

            if let image = item.iconImage {
                image.isTemplate = false
                cell.imageView?.image = image
            } else if let image = item.alternativeIconImage {
                image.isTemplate = true
                cell.imageView?.image = image
            }

            return cell
        } else if columnIdentifier == "bundleIdentifierColumn" {
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "bundleIdentifierCell"), owner: nil) as! NSTableCellView
            cell.textField?.stringValue = item.identifier
            return cell
        } else if columnIdentifier == "typeColumn" {
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "typeCell"), owner: nil) as! NSTableCellView
            cell.textField?.stringValue = item.type
            return cell
        } else {
            return nil
        }
    }
}
