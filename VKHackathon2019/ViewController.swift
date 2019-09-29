//
//  ViewController.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 27/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

struct Emoji {
    var id: Int
    var title: String
    var Image: String
}

class ViewController: UIViewController {
    
    var selectedEmoji = [Emoji]()
    let availableEmoji: [Emoji] = [
        Emoji(id: 0, title: "Романтика", Image: "❤️"),
        Emoji(id: 1, title: "Еда", Image: "😋"),
        Emoji(id: 2, title: "Солнце", Image: "😎"),
        Emoji(id: 3, title: "Развлечения", Image: "😂"),
        Emoji(id: 4, title: "Шалость", Image: "😈"),
        Emoji(id: 5, title: "Для пар", Image: "💑"),
        Emoji(id: 6, title: "История", Image: "💂"),
        Emoji(id: 7, title: "Пески", Image: "🌵"),
        Emoji(id: 8, title: "Жара", Image: "🔥"),
        Emoji(id: 9, title: "Пляж", Image: "🏝"),
        Emoji(id: 10, title: "Пицца", Image: "🍕"),
        Emoji(id: 11, title: "Паста", Image: "🍝"),
        Emoji(id: 12, title: "Африка", Image: "🐫"),
        Emoji(id: 13, title: "Картошка", Image: "🥔"),
        Emoji(id: 14, title: "Карнавал", Image: "🌈"),
        Emoji(id: 15, title: "Азия", Image: "🍣"),
        Emoji(id: 16, title: "Пиво", Image: "🍻"),
        Emoji(id: 17, title: "Семья", Image: "👨‍👩‍👧‍👦"),
        Emoji(id: 17, title: "Кофе", Image: "☕️"),
        Emoji(id: 17, title: "Архитектура", Image: "🏛️"),
        Emoji(id: 17, title: "Солнце", Image: "☀️"),
        Emoji(id: 17, title: "Море", Image: "🐬"),
        Emoji(id: 17, title: "Замки", Image: "🏰"),
        Emoji(id: 17, title: "Закуски", Image: "🥨"),
        Emoji(id: 17, title: "Мясо", Image: "🍗"),
        Emoji(id: 17, title: "Вино", Image: "🍷"),
        Emoji(id: 17, title: "Небоскребы", Image: "🏙"),
        Emoji(id: 17, title: "Статуи", Image: "🗽"),
        Emoji(id: 17, title: "Мосты", Image: "🌉"),
        Emoji(id: 17, title: "Фаст-фуд", Image: "🍔"),
        Emoji(id: 17, title: "Авто", Image: "🚕"),
        Emoji(id: 17, title: "Дожди", Image: "🌧️")

    ]

    @IBOutlet weak var emojiesCollectionView: UICollectionView!
    @IBOutlet weak var selectedCollectionView: UICollectionView!
    @IBOutlet weak var emojiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiesCollectionView.delegate = self
        emojiesCollectionView.dataSource = self
        selectedCollectionView.delegate = self
        selectedCollectionView.dataSource = self
        
        emojiView.layer.shadowColor = UIColor(red: 100/195, green: 100/195, blue: 100/195, alpha: 0.3).cgColor
        emojiView.layer.shadowOpacity = 1
        emojiView.layer.shadowOffset = .zero
        emojiView.layer.shadowRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func nextAction(_ sender: Any) {
        if selectedEmoji.count > 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
            vc.emojies = selectedEmoji
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert(title: "Ошибка", message: "Выберите хотя бы одну эмоцию")
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ClearCellDelegate {
    func didClickToClearButton() {
        selectedEmoji.removeAll()
        selectedCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == emojiesCollectionView {
            return availableEmoji.count
        } else {
            return selectedEmoji.count == 0 ? 0 : selectedEmoji.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == emojiesCollectionView {
            let item = availableEmoji[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmojiViewCell
            cell.emojiImageView.text = item.Image
            cell.emojiTitleLabel.text = item.title.lowercased()
            return cell
        } else {
            if selectedEmoji.count == indexPath.row {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clearCell", for: indexPath) as! ClearCell
                cell.delegate = self
                return cell
            } else {
                let item = selectedEmoji[indexPath.row]
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmojiViewCell
                cell.emojiImageView.text = item.Image
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == emojiesCollectionView {
            var f = false
            let id = availableEmoji[indexPath.row].id
            for item in selectedEmoji {
                f = id == item.id
            }
            if !f {
                if selectedEmoji.count < 4 {
                    selectedEmoji.append(availableEmoji[indexPath.row])
                    selectedCollectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == selectedCollectionView {
            let totalCellWidth = 36 * selectedEmoji.count
            let totalSpacingWidth = 40 * (selectedEmoji.count - 1)

            let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset

            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
