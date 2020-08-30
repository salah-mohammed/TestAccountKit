# Result

![alt text](https://github.com/salah-mohammed/TestAccountKit/blob/master/TestAccountKitExample/ezgif-7-1816e37ad4d8.gif?raw=true)

# TestAccountKit

TestAccountKit used for manage your accounts that used for login to your system .
# Advantages
* Don't write your account in login screen to enter to your system, you can choose it from saved list.
* The system can be used if the login screen by username or email or phonenumber.
* Configuration is too easy.


# How used (configuration): 
# Pod install
```ruby
pod 'TestAccountKit',:git => "https://github.com/salah-mohammed/TestAccountKit.git"
 
```
- First
add plist file it must be like this schema files https://github.com/salah-mohammed/TestAccountKit/blob/master/TestAccountKitExample/Plist/TestAccountListProducation.plist
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


# Configure Successfully

# Developer's information to communicate

- salah.mohamed_1995@hotmail.com
- https://www.facebook.com/salah.shaker.7
