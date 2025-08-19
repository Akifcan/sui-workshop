module my_first_package::my_car {
    use 0x1::ascii::String;
    use sui::tx_context::sender;

    public struct NFT has key, store {
        id: UID,
        name: String,
        url: String,
    }

    public entry fun mint(name: String, url: String, ctx: &mut TxContext) {
        let nft = NFT {
            id: object::new(ctx),
            name,
            url,
        };
        transfer::transfer(nft, sender(ctx))
    }
}
