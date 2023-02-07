import requests

api_url = "https://8bdc-31-166-28-3.in.ngrok.io/tasks"
response = requests.get(api_url)
tasks = response.json()
while tasks:
    user_request = tasks.pop(0)
    requests.delete((api_url + f"/{user_request['id']}"))
