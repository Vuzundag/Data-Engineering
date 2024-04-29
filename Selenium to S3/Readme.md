# Web Scraper to Load CSV into S3 Bucket

## Project Overview
This project involves using Selenium to scrape data from the Charities Bureau Website, which includes important information about charitable organizations operating in New York State. The primary objective is to parse a table from the website, extract relevant data, and store it as a CSV file in an AWS S3 bucket. The project is divided into two main parts: creating a basic scraper to load data into an S3 bucket and then enhancing the scraper to handle pagination and compile comprehensive results.

## Prerequisites
To run the scripts included in this repository, you will need the following installed on your system:

Python 3
AWS CLI
boto3 (AWS SDK for Python)
Selenium
Pandas (for data manipulation)
Time (for handling delays in script execution)
Google Chrome and Chrome WebDriver

## Files
charities_scraper.ipynb: The Jupyter notebook containing the scraping script.
README.md: Describes the project setup, architecture, and usage instructions.

## Usage
Set Up Your S3 Bucket: Create an S3 bucket through the AWS Management Console and configure its access settings to public. Update the charities_scraper.ipynb script with the name of your bucket.
Run the Web Scraper: Execute the script in charities_scraper.ipynb to scrape the website and load the output CSV file directly into the configured S3 bucket.
Iterate Through Pagination: Modify the script to navigate through all pages of the website, compile the data into a single DataFrame, and upload the complete CSV to the S3 bucket.
