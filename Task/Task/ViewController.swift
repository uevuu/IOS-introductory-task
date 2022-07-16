import UIKit


class User: NSObject, NSCoding {
    
    let email: String
    let password: String
    let name: String
    let surname: String
    
    init(email: String, password: String, name: String, surname: String) {
        self.email = email
        self.password = password
        self.name = name
        self.surname = surname
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: "email")
        coder.encode(password, forKey: "password")
        coder.encode(name, forKey: "name")
        coder.encode(surname, forKey: "surname")
    }
    
    required init?(coder: NSCoder) {
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
    }
}

let users = [
    User(email:"nikita@mail.ru", password:"Nikita111", name:"Никита", surname:"Никитин"),
    User(email:"vlad@mail.ru", password:"Vlad111", name:"Влад", surname:"Владов"),
    User(email:"danil@mail.ru", password:"Danil111", name:"Данил", surname:"Данилов"),
    User(email:"rishat@mail.ru", password:"Rishat111", name:"Ришат", surname:"Ришатов"),
    User(email:"marat@mail.ru", password:"Marat111", name:"Марат", surname:"Маратов"),
]


class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserData.user != nil {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)

            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
            
            profileVC.email = UserData.user.email
            profileVC.name = UserData.user.name
            profileVC.surname = UserData.user.surname
            
            navigationController?.pushViewController(profileVC,  animated: true)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true;

        navigationController?.navigationBar.prefersLargeTitles = true
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func okButtonDidTap(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let data = getUser(email: email)
        
        if (password.count >= 6 && data.1 && password.lowercased() != password && checkPassword(password: password) && data.0.password == password) {
            let user = data.0
            
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            
            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
            
            profileVC.email = user.email
            profileVC.name = user.name
            profileVC.surname = user.surname
            
            UserData.user = user
            
            navigationController?.pushViewController(profileVC,  animated: true)
        }
    else {
        guard let errorVC = storyboard?.instantiateViewController(withIdentifier: "ErrorViewController") else { return }
        present(errorVC,  animated: true)
        passwordTextField.text = ""
        emailTextField.text = ""
    }
}


func checkPassword(password: String) -> Bool{
    // Проверяет пароль на наличе хотя бы одной цифры и одной строчной английской буквы
    let nums = "0123456789"
    let letters = "qwertyuiopasdfghjklzxcvbnm"
    var haveNum = false
    var haveLetter = false
    
    for i in nums{
        if password.contains(i){
            haveNum = true
            break
        }
    }
    
    if haveNum{
        for i in letters{
            if password.contains(i){
                haveLetter = true
                break
            }
        }
    }
    
    return haveNum && haveLetter
}

func checkEmail(email: String) -> Bool{
    // Проверяте формат email
    let emailPattern = #"^\S+@\S+\.\S+$"#
    let result = email.range(of: emailPattern,  options: .regularExpression)
    return (result != nil)
}

func getUser(email: String) -> (User, Bool){
    // Наличие пользователя в массиве
    for user in users{
        if user.email == email{
            return (user, true)
        }
    }
    return (User(email: "", password: "", name: "", surname: ""), false)
}
}
