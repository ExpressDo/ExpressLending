// Lending App

// Define the contract
contract ExpressLending:

    // State variables
    lender: address
    borrower: address
    collateralAsset: string
    loanAmount: Uint128
    interestRate: Uint128
    isLoanRepaid: bool

    // Event to log loan initiation
    LoanInitiated: event({lender: indexed(address), borrower: indexed(address), collateralAsset: string, loanAmount: uint128, interestRate: uint128})

    // Event to log loan repayment
    LoanRepaid: event({from: indexed(address), to: indexed(address), amount: uint128})

    // Initialize the lending app
    init(borrowerAddress: address, collateral: string, amount: Uint128, rate: Uint128):
        lender = msg.sender
        borrower = borrowerAddress
        collateralAsset = collateral
        loanAmount = amount
        interestRate = rate
        isLoanRepaid = false

        // Log the loan initiation
        log LoanInitiated({lender: lender, borrower: borrower, collateralAsset: collateral, loanAmount: amount, interestRate: rate})

    // Function to repay the loan
    function repayLoan() payable:
        // Ensure only the borrower can repay the loan
        require(msg.sender == borrower, "Unauthorized")

        // Calculate the total amount to repay (loan amount + interest)
        Uint128 totalAmountToRepay = add(loanAmount, calculateInterest())

        // Ensure the repayment amount is correct
        require(msg.value == totalAmountToRepay, "Incorrect repayment amount")

        // Transfer funds to the lender
        send(lender, msg.value)

        // Log the
