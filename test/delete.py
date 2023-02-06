import requests

api_url = "https://d977-2a02-9b0-402b-d298-10c9-2e2f-13a9-243a.eu.ngrok.io/tasks"
response = requests.get(api_url)
tasks = response.json()
while tasks:
    user_request = tasks.pop(0)
    requests.delete((api_url + f"/{user_request['id']}"))


# def something():
#     haha=[]
#     haha.append("lol")
#     haha.append(123)
#     print(haha)
#     return haha
#
# lol =something()
# print(lol)
# lmao =lol.pop(0)
# print(lol)
# print(lmao)