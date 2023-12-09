#!/usr/bin/env python3

# How to export notes to CSV:
# https://yandexbookmate.userecho.com/communities/4/topics/143-vyigruzka-tsitat-i-zametok-v-csv-format

import sys
import csv

def reverse_order(file_path):
    with open(file_path, "r", encoding="utf-8") as csvfile:
        reader = csv.reader(csvfile, delimiter=",")
        data = list(reader)

    for i in range(len(data) - 1, 0, -1):
        row = data[i]
        print(row[2])
        print("")

if len(sys.argv) != 2:
    print("Usage: ./bookmate_quotes.py filename.csv")
    sys.exit(1)

if __name__ == "__main__":
    file_path = sys.argv[1]
    reverse_order(file_path)
