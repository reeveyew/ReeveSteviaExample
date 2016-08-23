
import UIKit
import SteviaLayout

class LoginView:UIView {
    
    let textField_Email = UITextField()
    let textField_Password = UITextField()
    let button_Login = UIButton()
    
    let view_CenterRect = UIView()
    
    let viewContainer_Bottom = UIView()
    let view_LeftRect = UIView()
    let view_MidRect = UIView()
    let view_RightRect = UIView()
    
    convenience init() {
        self.init(frame:CGRectZero)
        // This is only needed for live reload as injectionForXcode
        // doesn't swizzle init methods..
        render()
    }
    
    func render() {
        backgroundColor = .grayColor()
        
        //sv is .addSubview
        sv([
            textField_Email
                .placeholder("reeveyew@gmail.com")
                .style(generalTextFieldStyle),
            
            textField_Password
                .placeholder("Password")
                .style(generalTextFieldStyle)
                .style(passwordTextFieldStyle), //styles chaining is possible
            
            button_Login
                .text("Login") //replace .setTitle
                .style(buttonSytle)
                .tap(didTapButtonLogin), //replace .addTarget
                //.image("anImage") //replace .setImage
            
            //inline style like CSS
            view_CenterRect.style({ (v) in
                v.backgroundColor = .yellowColor()
            }),
            
            //setup bottom container + nested views
            viewContainer_Bottom.style({ (v) in
                v.backgroundColor = .whiteColor()
            })
                .sv(
                    view_LeftRect.style(viewHorizontallyAlignStyle),
                    view_MidRect
                        .style(viewHorizontallyAlignStyle)
                        .style { v in
                            v.backgroundColor = .redColor()
                    },
                    view_RightRect.style(viewHorizontallyAlignStyle)
                )
        ])
        
        //use layout if have subviews to setup from TOP to BOTTOM
        layout(
            0,
            |-textField_Email-| ~ 80, //the '~ 80' is shorthand for height
            0,
            |-textField_Password-| ~ 80,
            0,
            |-button_Login-| ~ 80
        )
        
        
        //Center according to parent view. //layout() is not needed
        view_CenterRect.size(100).centerVertically().centerHorizontally(20) //20 is offset
        
        //align views horizontally inside the parent container
        |viewContainer_Bottom.bottom(50)| ~ 100
            view_LeftRect.fillVertically()
            alignHorizontally(|view_LeftRect-0-view_MidRect-0-view_RightRect|)
            equalSizes(view_LeftRect, view_MidRect, view_RightRect)
        
        
        /*
        OTHER USEFUL LAYOUTS
        **/
        //button.followEdges(imageView) //The typical example of this is when we want to have a button on top of an image.
        //view.heightEqualsWidth() //Constraining a view to stay squared
        //view https://github.com/s4cha/Stevia for complete documentation
        
    }
    
    func viewHorizontallyAlignStyle(v: UIView) {
        v.backgroundColor = UIColor.brownColor()
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
    }
    
    func generalTextFieldStyle(f:UITextField) {
        f.borderStyle = .RoundedRect
        f.backgroundColor = .yellowColor()
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.returnKeyType = .Next

    }
    
    func passwordTextFieldStyle(f:UITextField) {
        f.secureTextEntry = true
        f.backgroundColor = .blueColor()
        f.returnKeyType = .Done
    }
    
    func buttonSytle(b:UIButton) {
        b.backgroundColor = UIColor.greenColor()
    }
    
    func didTapButtonLogin() {
        //Do something
    }
    
    //common functions from documentation
    
}


// Chainable syntax
//        emailField.fillH(m: 8)
//        passwordField.fillH(m: 8)
//        button.fillH()
//        for b in [emailField, passwordField, button] { b.height(80)}
//        emailField.top(100).stackV(m: 8, v: passwordField)
//        button.bottom(0)

// Visual format
//        views = [ "emailField" :emailField, "passwordField" : passwordField, "button" : button ]
//        h("|-[emailField]-|")
//        h("|-[passwordField]-|")
//        h("|[button]|")
//        v("|-100-[emailField(80)]-[passwordField(80)]-(>=8)-[button(80)]|")
