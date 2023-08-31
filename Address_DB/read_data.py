import utils



def extract_columns(data:list,column_no:int)->list:
    column_data = []
    for row in data:
        column_data.append(row[column_no])

    return column_data


if __name__ == "__main__":
    data = utils.read_csv("accounts")
    sgqrids = extract_columns(data,0)
    addresses = extract_columns(data,1)
    # print(sgqrids)

    formatted_addresses = [address[2:] for address in addresses]
    utils.write_to_json(formatted_addresses,"formatted_addresses.json")
