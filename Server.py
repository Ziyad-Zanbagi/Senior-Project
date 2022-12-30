import base64
import time

import requests

# url hosted in local device by node.js
api_url = "http://localhost:3000/tasks"

def checkRequest():

    response = requests.get(api_url)
    tasks = response.json()
    # check if there are any elements in the
    # task dictionary
    if tasks:
        # get first element of list
        new_task = tasks.pop(0)
        new_task_id = new_task["id"]
        # get task id of the new task from list of tasks
        requests.delete((api_url+f"/{new_task_id}"))
        print(tasks)
        print(new_task)
        print("code will begin with task id")
        # if task is to do ***
        if new_task["task_id"] == 1:
            print("proceeding with task number 1")

        # if task is to scan an image
        elif new_task["task_id"] == 2:
            print("proceeding with task number 2")
            image_string = new_task["image"]
            # turn the image from string into bytes
            image_bytes = bytes(image_string, 'utf-8')
            image_64_decode = base64.b64decode(image_bytes)
            image_result = open('scan.png', 'wb')
            # create a writable image and write the decoding result
            image_result.write(image_64_decode)
            # todo
            # write OCR and begin OCR

        print(response.status_code)
    else:
        print("list is empty")

while(True):
    # code for the server to run indefinitely and check for tasks
    # that will be sent from the front-end
    print("working")
    checkRequest()
    time.sleep(10)