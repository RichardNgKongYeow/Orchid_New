import csv
import random

def random_date():
    # Generate a random date within the year 2001 to 2023 (you can modify the range if needed)
    year = random.randint(2001, 2023)
    month = random.randint(1, 12)
    day = random.randint(1, 28)  # Limit to 28 days for simplicity (adjust if needed)
    return f"{year:02d}{month:02d}{day:02d}"

def generate_sgqrid(n):
    with open('sgqrid.csv', mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["SGQRID"])

        for _ in range(n):
            creation_date = random_date()
            hex_counter = format(random.randint(0, 0xFFFFFF), '06X')
            sgqrid = f"{creation_date}{hex_counter}"
            writer.writerow([sgqrid])

if __name__ == "__main__":
    N = 1000  # Number of rows to generate
    generate_sgqrid(N)
