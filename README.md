# Result

![alt text](https://github.com/salah-mohammed/TestAccountKit/blob/master/TestAccountKitExample/ezgif-7-1816e37ad4d8.gif?raw=true)

# TestAccountKit

TestAccountKit used for manage your accounts that used for login to your system .
# Advantages
* Don't write your your account in login screen to enter to your system, you can choose it from saved list.
* Our System can dealing with systems that have username to login or phone number or email to login.
* Configuration is too easy.


# How used (configuration): 
# Pod install
```ruby
pod 'TestAccountKit',:git => "https://github.com/salah-mohammed/TestAccountKit.git"
 
```
- Second

if your login screen login with username and password.
```swift

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtUserName.text ?? "").count == 0 {
                TestAccountManager.shared.development.show({ (item) -> String in
                    return "(\(item.accountDescription ?? "")) \(item.username ?? "")"
                }, selectedObject: { object in
        self.txtUserName.text=object.username
        self.txtPassword.text=object.password

                     self.login()
                } )
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }

 ```
 
if your login screen login with email and password.
 
 ```swift

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtEmail.text ?? "").count == 0 {
                    TestAccountManager.shared.development.show(selectedObject: { object in
                    self.txtEmail.text = object.email ?? "";
                    self.txtPassword.text = object.password ?? "";
                    self.login()
                } )
                
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }

```
if your login screen login with phone number .

 ```swift

    @IBAction func btnLogin(_ sender: Any) {
           #if DEBUG
               if (self.txtPhoneNumber.text ?? "").count == 0 {
                TestAccountManager.shared.development.show({ (item) -> String in
                    return "(\(item.accountDescription ?? "")) \(item.phoneNumber ?? "")"
                }, selectedObject:  { object in
                               self.txtPhoneNumber.text = object.phoneNumber ?? "";
                               self.login()
                          })
                
           }else{
               self.login()
           }
           #else
                self.login()
           #endif
    }
    func login(){
        
    }

 ```

if you want to set background image for Navigation bar and set title color for it.

 ```swift
 class ForthViewController: UIViewController,NavigationDelegate {

    var navigationData: NavigationData=NavigationData.init(NavigationManager.NavigationStyle.custom(NavigationManager.BarColor.backgroundImage(UIImage.init(named:"navigationImage")!), titleColor: UIColor.white))
    
        public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
 ```
- Thired

if you want to set default style 'if Viewcontroller not implement NavigationInfoDelegate'
```swift
NavigationManager.shared.defaultData = NavigationData.init(NavigationManager.NavigationStyle.custom(NavigationManager.BarColor.customColor(UIColor.blue), titleColor:  UIColor.white))

 ```
# Configure Successfully

# Developer's information to communicate

- salah.mohamed_1995@hotmail.com
- https://www.facebook.com/salah.shaker.7
