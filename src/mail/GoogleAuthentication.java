package mail;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        passAuth = new PasswordAuthentication("zndn887", "iakqwplqjneozgwj");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}
