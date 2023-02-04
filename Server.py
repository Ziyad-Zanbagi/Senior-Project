import base64
import time
import requests
import re
from PIL import Image
import pytesseract

# this is a dictionary of allergies and their causes
allergies = {
    "peanuts": {
        "causes": ["فول السوداني", "زبدة الفول السوداني"],
        "arabic_allergy": "فول السوداني"
    },
    "milk": {
        "causes": ["حليب", "الحليب"],
        "arabic_allergy": "حليب"
    },
    "fish": {
        "causes": ["السمك", "سمك", "اسماك"],
        "arabic_allergy": "سمك"
    },
    "strawberry": {
        "causes": ["الفراولة", "فراولة"],
        "arabic_allergy": "قراولة"
    },
    "eggs": {
        "causes": ["البيض", "بيض"],
        "arabic_allergy": "بيض"
    },
    "wheat": {
        "causes": ["فمح", "القمح"],
        "arabic_allergy": "قمح"
    },
    "mango": {
        "causes": ["مانجو", "المانجو"],
        "arabic_allergy": "مانجو"
    },
    "chocolate": {
        "causes": ["شوكولاته", "الشوكولاته", "كاكاو", "كوكوا"],
        "arabic_allergy": "شوكولاته"
    },
    "lactose": {
        "causes": ["جينة"],
        "arabic_allergy": "لاكتوز"
    },
    "nuts": {
        "causes": ["فستق", "لوز","كاجو"],
        "arabic_allergy": "مكسرات"
    },

}
# url hosted in local device by node.js
api_url = "https://d977-2a02-9b0-402b-d298-10c9-2e2f-13a9-243a.eu.ngrok.io/posts"


def checkRequest(allergies):
    response = requests.get(api_url)
    tasks = response.json()
    # check if there are any elements in the
    # task dictionary
    if tasks:
        # get first element of list
        user_request = tasks.pop(0)

        # get task id of the new task from list of tasks
        requests.delete((api_url + f"/{user_request['id']}"))

        print(tasks)
        print(user_request)
        # split requests based on key that came from user request
        # the request contains an id,image, and all allergies
        user_allergy = []
        for key in user_request:
            # if the key was id it will take the value and put in another variable
            if key == "id":
                user_id = user_request["id"]
            # if the key was image it will extract the base64 code and convert it into image
            elif key == "image":
                image_string = user_request["image"]
                # turn the image from string into bytes
                image_bytes = bytes(image_string, 'utf-8')
                image_64_decode = base64.b64decode(image_bytes)
                image_result = open('test.png', 'wb')
                # create a writable image and write the decoding result
                image_result.write(image_64_decode)
            # if the above condition were not met, it will check if the allergy is true and put it into a list
            else:

                if user_request[key] == "true":
                    print(user_request[key])
                    user_allergy.append(key)
        #  here it will start the OCR function
        allergic_found = []
        # the line below needed for the OCR
        pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
        # it will extract img we decoded above to extract the text and put it into a list via split
        image = pytesseract.image_to_string(Image.open('test.png'), lang='ara')

        ocr_text = list(re.split(r"[-«»;ء؛,.\s]\s*", image))
        print(ocr_text)
        # here it will start the classification function
        # it will move through all the user allergies and check what causes that allergy
        allergic = False
        for allergen in user_allergy:
            for causes in allergies[allergen]["causes"]:
                # it will compare every word that came from the image and check if it matches the causes
                if causes in ocr_text:
                    print(allergen)
                    allergic = True
                    # if it does it will put what allergy it was in a list
                    allergic_found.append(allergen +" / "+allergies[allergen]["arabic_allergy"])
        print(f"allergic found {allergic_found}")
        # final step it will post the result back to the front-end
        todo = {"id": user_id, "allergies": allergic_found, "allergic": allergic}
        print("sending back to front-end")
        url_back = "https://d977-2a02-9b0-402b-d298-10c9-2e2f-13a9-243a.eu.ngrok.io/tasks"
        response = requests.post(url_back, json=todo)

        time.sleep(30)
        print("request is done. deleting request from json")
        requests.delete((url_back + f"/{user_id}"))
    else:
        print("list is empty")

while (True):
    # code for the server to run indefinitely and check for tasks
    # that will be sent from the front-end
    print("working")
    checkRequest(allergies)
    time.sleep(8)
