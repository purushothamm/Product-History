pragma solidity ^0.4.17;
//pragma experimental ABIEncoderV2; //use this to return struct in future

contract ProductHistory {

    struct Transaction
    {
        string text;
        address FromAddress;
        address ToAddress;
        uint Price; //Cost of the transaction
        // add more non-key fields as needed
    }

    struct Product
    {
        string text;
        mapping(uint => Transaction) TransactionStructs; // random access by Product key and Transaction key
        uint TransactionCount; //Total transactions for the product
        // add more non-key fields as needed
    }

    mapping(string => Product) ProductStructs; // random access by product key
    string[] ProductList; // list of product keys so we can enumerate them

    function newProduct(string memory ProductKey, string memory text) public returns(bool success)
    {
        //not checking for duplicates
        ProductStructs[ProductKey].text = text;
        ProductList.push(ProductKey);
        return true;
    }

    function getProduct(string memory ProductKey)  public view returns(string wording, uint TransactionCount)
    {
        return(ProductStructs[ProductKey].text, ProductStructs[ProductKey].TransactionCount);
    }

    function addTransaction(string memory ProductKey, string memory _transactionText, address _fromAddress, address _toAddress, uint _Price) public returns(bool success)
    {
        //Update to check the owner and allow only owner to do the transaction.
        uint _TransacitonCount = ProductStructs[ProductKey].TransactionCount + 1;
        ProductStructs[ProductKey].TransactionStructs[_TransacitonCount].text = _transactionText;
        ProductStructs[ProductKey].TransactionStructs[_TransacitonCount].FromAddress = _fromAddress;
        ProductStructs[ProductKey].TransactionStructs[_TransacitonCount].ToAddress = _toAddress;
        ProductStructs[ProductKey].TransactionStructs[_TransacitonCount].Price = _Price;
        ProductStructs[ProductKey].TransactionCount = _TransacitonCount;
        // Product Price will init to 0 without our help
        return true;
    }

    function getProductTransaction(string memory ProductKey,  uint TransactionNo) public view returns(string memory ProductText, string memory TransactionText, address FromAddress, address ToAddress, uint TransacitonCost)
    {
        return(
            ProductStructs[ProductKey].text,
            ProductStructs[ProductKey].TransactionStructs[TransactionNo].text,
            ProductStructs[ProductKey].TransactionStructs[TransactionNo].FromAddress,
            ProductStructs[ProductKey].TransactionStructs[TransactionNo].ToAddress,
            ProductStructs[ProductKey].TransactionStructs[TransactionNo].Price
            //return more fields from here 
            );
    }
    
    function getTransactionCount() public view returns(uint ProductCount)
    {
        return ProductList.length;
    }

    function getProductAtIndex(uint row) public view returns(string memory productkey)
    {
        return ProductList[row];
    }

    function getProductTransactionCount(string ProductKey) public view returns(uint transactionCount)
    {
        return ProductStructs[ProductKey].TransactionCount;
    }

    //function getProductTransactionAtIndex(bytes32 ProductKey, uint transactionRow) external view returns(Transaction[] memory)
    //{
    //    return(ProductStructs[ProductKey].TransactionStructs[]);
    //}  
}
