module my_first_package::Hello {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    
    // Public fonksiyon herkes tarafından çağrılabilir
    public fun say_hello(): vector<u8> {
        b"Hello, Sui!"
    }
    
    // Sadece sahibinin görebileceği mesaj objesi
    public struct PrivateMessage has key, store {
        id: UID,
        message: vector<u8>,
        owner: address
    }
    
    // say_hello() fonksiyonunu çağırıp sonucu private object olarak saklar
    public entry fun create_private_hello(ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        let hello_message = say_hello(); // Mevcut fonksiyonunu çağır
        
        let private_msg = PrivateMessage {
            id: object::new(ctx),
            message: hello_message,
            owner: sender
        };
        
        // Mesajı sadece çağıran kişiye transfer et
        transfer::transfer(private_msg, sender);
    }
    
    // Sadece sahip mesajını okuyabilir
    public fun read_my_message(msg: &PrivateMessage): vector<u8> {
        msg.message
    }
    
    // Sahiplik kontrolü yapan fonksiyon
    public fun is_owner(msg: &PrivateMessage, user: address): bool {
        msg.owner == user
    }
}