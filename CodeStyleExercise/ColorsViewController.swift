//
//  ColorsViewController.swift
//  CodeStyleExercise
//
//  Created by Maya Saxena on 12/14/16.
//
//

import UIKit

final class ColorsViewController: UIViewController, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var colorCountTextField: UITextField!
    
    public var colorsCount: Int? = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "ColorsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.colorCountTextField.placeholder = "12"
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsCount ?? 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ColorsCollectionViewCell
        cell.configureCellWithColor(color: .randomColor())
        
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.characters.count > 0 else { return true }
        
        let replacedTextStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if replacedTextStr.characters.count <= 2 {
            let strWithoutDecimals = string.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined()
            
            return string == strWithoutDecimals
        }
        else {
            return false
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func handleBackgroundTap(_ sender: UITapGestureRecognizer) {
        colorCountTextField.resignFirstResponder()
        colorsCount = Int(colorCountTextField.text ?? "")
    }
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        collectionView.reloadData()
    }
}

extension UIColor {
    public static func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255
        let green = CGFloat(arc4random_uniform(256)) / 255
        let blue = CGFloat(arc4random_uniform(256)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
