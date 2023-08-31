import csv
from eth_account import Account

def generate_account_for_sgqrid(sgqrid):
    # Generate a new Ethereum account
    acct = Account.create()

    # Get the address and private key
    address = acct.address
    private_key = acct._private_key.hex()

    return sgqrid, address, private_key

def generate_accounts_from_csv(input_file, output_file):
    with open(input_file, mode='r') as input_csv, open(output_file, mode='w', newline='') as output_csv:
        reader = csv.reader(input_csv)
        writer = csv.writer(output_csv)
        writer.writerow(["SGQRID", "Address", "Private Key"])

        next(reader)  # Skip the header row
        for row in reader:
            sgqrid = row[0]
            account_info = generate_account_for_sgqrid(sgqrid)
            writer.writerow(account_info)

if __name__ == "__main__":
    input_csv_file = "sgqrid.csv"  # Replace with the path to your input CSV file
    output_csv_file = "accounts.csv"  # Replace with the desired output CSV file name
    generate_accounts_from_csv(input_csv_file, output_csv_file)
