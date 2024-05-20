// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20; // Aici specificam ca folosim versiunea 0.8.20 a limbajului Solidity

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol"; // Importam contractul ERC721Upgradeable
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol"; // Importam contractul ERC721URIStorageUpgradeable
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol"; // Importam contractul OwnableUpgradeable
import "@openzeppelin/contracts-upgradeable/utils/cryptography/EIP712Upgradeable.sol"; // Importam contractul EIP712Upgradeable
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721VotesUpgradeable.sol"; // Importam contractul ERC721VotesUpgradeable
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol"; // Importam contractul Initializable
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol"; // Importam contractul UUPSUpgradeable

/// @custom:security-contact securitatea@directia3.ro // Specificam adresa de email a echipei de securitate

// Contractul Exemplu este un contract care implementeaza un standard de tokenuri non-fungibile (NFT) conform specificatiilor ERC721
contract Exemplu is Initializable, ERC721Upgradeable, ERC721URIStorageUpgradeable, OwnableUpgradeable, EIP712Upgradeable, ERC721VotesUpgradeable, UUPSUpgradeable {
    uint256 private _nextTokenId; // Variabila privata care retine urmatorul ID de token disponibil

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }
    // Functia initialize este folosita pentru a initializa contractul
    function initialize(address initialOwner) initializer public { // Functia initialize este marcata cu initializer pentru a fi apelata o singura data
        __ERC721_init("Exemplu", "EXMP"); // Initializam contractul cu numele "Exemplu" si simbolul "EXMP"
        __ERC721URIStorage_init(); // Initializam contractul pentru a stoca URI-urile tokenurilor
        __Ownable_init(initialOwner); // Initializam contractul cu proprietarul initial
        __EIP712_init("Exemplu", "1"); // Initializam contractul pentru a folosi EIP712
        __ERC721Votes_init(); // Initializam contractul pentru a permite voturi
        __UUPSUpgradeable_init(); // Initializam contractul pentru a permite upgrade-uri
    }

    function _baseURI() internal pure override returns (string memory) { // Functia _baseURI returneaza baza URI-ului
        return "exemplu-uri.ro"; // Returnam baza URI-ului
    }

    function safeMint(address to, string memory uri) public onlyOwner { // Functia safeMint este folosita pentru a mintui un token si a-l transfera catre un cont
        uint256 tokenId = _nextTokenId++; // Incrementam ID-ul urmatorului token
        _safeMint(to, tokenId); // Mintuim tokenul si il transferam catre contul specificat
        _setTokenURI(tokenId, uri); // Setam URI-ul tokenului
    }

    function _authorizeUpgrade(address newImplementation) /// Functia _authorizeUpgrade este folosita pentru a autoriza un upgrade
        internal /// Functia este marcata ca interna
        onlyOwner /// Functia poate fi apelata doar de proprietar
        override /// Functia este o suprascriere
    {}

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth) /// Functia _update este folosita pentru a actualiza un token
        internal /// Functia este marcata ca interna
        override(ERC721Upgradeable, ERC721VotesUpgradeable) /// Functia este o suprascriere
        returns (address)   /// Functia returneaza un adresa
    {
        return super._update(to, tokenId, auth); /// Returnam rezultatul functiei _update din contractele mostenite
    }

    function _increaseBalance(address account, uint128 value) /// Functia _increaseBalance este folosita pentru a creste balanta unui cont
        internal /// Functia este marcata ca interna
        override(ERC721Upgradeable, ERC721VotesUpgradeable) /// Functia este o suprascriere
    {
        super._increaseBalance(account, value); /// Apelam functia _increaseBalance din contractele mostenite
    }

    function tokenURI(uint256 tokenId) /// Functia tokenURI este folosita pentru a returna URI-ul unui token
        public /// Functia este marcata ca publica
        view /// Functia este marcata ca de tip view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable) /// Functia este o suprascriere
        returns (string memory) /// Functia returneaza un string
    {
        return super.tokenURI(tokenId); /// Returnam rezultatul functiei tokenURI din contractele mostenite
    }

    function supportsInterface(bytes4 interfaceId) /// Functia supportsInterface este folosita pentru a verifica daca contractul suporta un anumit standard
        public /// Functia este marcata ca publica
        view /// Functia este marcata ca de tip view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable) /// Functia este o suprascriere
        returns (bool) /// Functia returneaza un boolean
    {
        return super.supportsInterface(interfaceId); /// Returnam rezultatul functiei supportsInterface din contractele mostenite
    }
}
