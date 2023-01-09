// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {
    // The name of the token
    string public name;
    // The symbol of the token
    string public symbol;
    // The number of decimals of the token
    uint8 public decimals;
    // The total supply of the token
    uint256 public totalSupply;
    // A mapping from addresses to their token balance
    mapping(address => uint256) public BalanceOf;
    // A mapping from addresses to their allowance
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply)  {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        BalanceOf[msg.sender] = totalSupply;
    }

    // Approves the transfer of an amount of tokens from the caller to the specified address
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    // Transfers an amount of tokens from the caller to the specified address
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_value <= BalanceOf[msg.sender], "Insufficient balance.");
        BalanceOf[msg.sender] = BalanceOf[msg.sender]-(_value);
        BalanceOf[_to] = BalanceOf[_to]+(_value);
        return true;
    }

    // Transfers an amount of tokens from the caller to the specified address, if the caller has
    // sufficient allowance
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_value <= BalanceOf[_from], "Insufficient balance.");
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance.");
        BalanceOf[_from] = BalanceOf[_from]-(_value);
        BalanceOf[_to] = BalanceOf[_to]+(_value);
        allowance[_from][msg.sender] = allowance[_from][msg.sender]-(_value);
        return true;
    }

    // Returns the balance of the specified address
    function balanceOf(address _owner) public view returns (uint256) {
        return BalanceOf[_owner];
    }
}
