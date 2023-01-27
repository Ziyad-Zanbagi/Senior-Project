import requests
import base64
api_url = "http://localhost:3000/tasks/"
#api_url = "http://localhost:3000

with open("images/dew.png", "rb") as image_file:
    encoded_string = base64.b64encode(image_file.read())
print(encoded_string)
encoded_string = encoded_string.decode('utf-8')


todo = {"uid": "sHk8cUucnNZ4Aqd4pWJ2JP3IsPo2", "request_title": "detect allergy", "success": False, "task_id": 2, "image": encoded_string}

response = requests.post(api_url, json=todo)
print(response.json())
print(response.status_code)
print(response.headers["Content-Type"])