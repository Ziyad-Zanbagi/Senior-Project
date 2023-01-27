import base64
import time
import requests
import re
from PIL import Image
import pytesseract

allergies = {
    "peanuts": {
        "causes": ["فول السوداني", "زبدة الفول السوداني"]
    },
    "milk": {
        "causes": ["حليب", "الحليب"]
    },
    "fish": {
        "causes": ["السمك", "سمك", "اسماك"]
    },
    "strawberry": {
        "causes": ["الفراولة", "فراولة"]
    },
    "eggs": {
        "causes": ["البيض", "بيض"]
    },
    "wheat": {
        "causes": ["فمح", "القمح"]
    },
    "mango": {
        "causes": ["مانجو", "المانجو"]
    },
    "chocolate": {
        "causes": ["شوكولاته", "الشوكولاته", "كاكاو", "كوكوا"]
    },

}
# url hosted in local device by node.js
api_url = "https://36d1-31-166-28-3.in.ngrok.io/posts"


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
        print("code will begin with task id")
        # if task is to do ***

        # if task is to scan an image
        # if user_request["task_id"] == 2:
        #     print("proceeding with task number 2")
        #     image_string = user_request["image"]
        #     # turn the image from string into bytes
        #     image_bytes = bytes(image_string, 'utf-8')
        #     image_64_decode = base64.b64decode(image_bytes)
        #     image_result = open('scan.png', 'wb')
        #     # create a writable image and write the decoding result
        #     image_result.write(image_64_decode)
        # todo
        # write OCR and begin OCR

        # allergies = ["الفول السوداني", "حليب", "سمكة", "الفراولة", "بيض", "قمح", "مانجو", "شوكولاتة"]
        user_allergy = []
        for key in user_request:
            if key == "id":
                user_id = user_request["id"]
            elif key == "image":
                image_string = user_request["image"]
                # turn the image from string into bytes
                image_bytes = bytes(image_string, 'utf-8')
                image_64_decode = base64.b64decode(image_bytes)
                image_result = open('test.png', 'wb')
                # create a writable image and write the decoding result
                image_result.write(image_64_decode)

            else:
                if user_request[key]:
                    user_allergy.append(key)
        print(user_allergy)
        print(user_id)
        allergic_found = []

        # if allergen in allergies:
        #     print(allergies[allergen]["causes"][0])
        # else:
        #     print("it does not exists")
        pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
        image = pytesseract.image_to_string(Image.open('test.png'), lang='ara')

        ocr_text = list(re.split(r"[-«»;ء؛,.\s]\s*", image))
        print(ocr_text)
        for allergen in user_allergy:
            for causes in allergies[allergen]["causes"]:
                if causes in ocr_text:
                    print(allergen)
                    allergic = True
                    allergic_found.append(allergen)
        print(f"allergic found {allergic_found}")

    else:
        print("list is empty")


while (True):
    # code for the server to run indefinitely and check for tasks
    # that will be sent from the front-end
    print("working")
    checkRequest(allergies)
    time.sleep(10)
