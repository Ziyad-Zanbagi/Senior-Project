# import requests
#
# api_url = "https://8bdc-31-166-28-3.in.ngrok.io/posts"
# response = requests.get(api_url)
# tasks = response.json()
# while tasks:
#     user_request = tasks.pop(0)
#     requests.delete((api_url + f"/{user_request['id']}"))
from collections import Counter

something = ["ياحبيبي","سبرايت","هلا"]
something2 = ["هلا","ياحبيبي","سبرايت"]
if Counter(something2) == Counter(something):
    print("yesssssssssssssss")
else:
    print("nooooooooooooo")