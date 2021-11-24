"""
Combined the services from James Mejia and Jessica Dutton into one server file.
This way I can access both services from the localhost at the same time.
"""


from bs4 import BeautifulSoup
from flask import Flask, render_template, request
import requests
import json
from requests.api import get
from selenium import webdriver
from werkzeug.serving import WSGIRequestHandler

app = Flask(__name__)


# Author: James Mejia
# Price Finding Service

@app.route("/", methods=["GET", "POST"])
def index():
    """
    Function that handles page and form actions in index.html
    """
    author = request.args.get('author')
    title = request.args.get("title")

    # Author and Title Request
    if request.method == "GET" and author is not None and title is not None:
        return render_template("results.html", results=barns_and_noble(title, author))

    # Title Request
    elif request.method == "GET" and author is None and title is not None:
        return render_template("results.html", results=barns_and_noble(title, author=None))

    # Return original index.html
    else:
        return render_template("index.html")


def barns_and_noble(title, author):

    # Initial Search
    if author is None:
        title = title.replace(' ', '+')
        author = ""
    else:
        author = author.replace(' ', '+')
        title = title.replace(' ', '+')

    main_search_url = "https://www.bookfinder.com/search/?author=" + author + "&title=" + title + "&lang=en&isbn=&new_used=*&destination=us&currency=USD&mode=basic&st=sr&ac=qr"

    loaded_page = requests.get(main_search_url)
    if loaded_page.status_code == 200:
        soup = BeautifulSoup(loaded_page.content, "html.parser")
        if "Sorry, we found no matching results at this time" not in soup.text:
            book_options = soup.find_all("ul", class_="select-titlenames")
            price_list_url = book_options[0].find("a").get("href")

            price_page = requests.get(price_list_url)
            if price_page.status_code == 200:
                soup = BeautifulSoup(price_page.content, "html.parser")

                # Scrap Data for first row of data
                results = []
                prices = soup.find_all("tr", class_="results-table-first-LogoRow has-data")
                for g in prices:
                    seller = g.find("img").get("title")
                    link = g.find("a").get("href")
                    for p in g.find_all("span", class_="results-price"):
                        item = {
                            "seller": seller,
                            "price": p.text,
                            "Buy Now Link": link
                        }
                        results.append(item)

                # Scrap Data for remaining rows of data
                prices.clear()
                prices = soup.find_all("tr", class_="results-table-LogoRow has-data")
                for g in prices:
                    seller = g.find("img").get("title")
                    link = g.find("a").get("href")
                    for p in g.find_all("span", class_="results-price"):
                        item = {
                            "seller": seller,
                            "price": p.text,
                            "Buy Now Link": link
                        }
                        results.append(item)
                return json.dumps(results)
            else:
                return("error encountered while loading price page")
        else:
            return(title + " Could Not Be Found!")
    else:
        return("error encountered while loading search page")


# Jessica Dutton
# OSU CS 361
# Image Scraping Service

@app.route('/postmethod', methods=['POST'])
def postmethod():
    data = request.get_json()
    data = json.loads(data)
    print ('DATA', data)
    for i in data:
        key = i
    return getImageUrl(data[key])

def getImageUrl(keyword):
    print('KEYWORD', keyword)
    

    searchWords = ""

    if keyword == [""] or keyword == [" "] or not keyword:
        return "ERROR: Please submit at least one keyword"

    else:
        for i in keyword:
            searchWords += i
            searchWords += " "

    from selenium.webdriver.chrome.options import Options

    # use headless browser to prevent browser pop up

    options = Options()
    options.add_argument('--headless')
    options.add_argument('--window-size=1920,1080')  
    
    driver = webdriver.Chrome(chrome_options= options)

    driver.get("https://www.bing.com/images")                           # go to Bing images
    driver.find_element_by_name("q").send_keys(keyword)                 # input keyword(s)
    driver.implicitly_wait(10)
    driver.find_element_by_id("sb_search").click()                      # search
    driver.implicitly_wait(10)

    lst = driver.find_element_by_id("mmComponent_images_2")             # find images in first list on Bing
    images = lst.find_elements_by_tag_name("li")

    images[0].click()                                                   # first image
    driver.implicitly_wait(10)
                            
    response = requests.get(driver.current_url  )                       # use beautiful soup to obtain image url
    
    soup = BeautifulSoup(response.text, 'html.parser')
    img_tags = soup.find_all('img')

    urls = [img['src'] for img in img_tags]
    image_url = urls[0]


    driver.close()    

    return ''+image_url


if __name__ == "__main__":
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(debug=True)

