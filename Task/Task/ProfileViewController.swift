import UIKit

class ProfileViewController: UIViewController {
    
    var email = String()
    var name = String()
    var surname = String()
    
    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.image = UIImage(named: name)
        }
    }
    
    @IBOutlet weak var emailLabel: UILabel!{
        didSet{
            emailLabel.text = email
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.text = name
        }
    }
    
    @IBOutlet weak var surnameLabel: UILabel!{
        didSet{
            surnameLabel.text = surname
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitButtonDidTap(_ sender: Any) {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:"user")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
        
        mainVC.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(mainVC,  animated: true)        
    }
    
    override func viewDidDisappear(_ animated: Bool) {

    }
}
