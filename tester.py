import requests

url = 'https://api.tracker.gg/api/v2/valorant/standard/matches/riot/Odedddddd%23res?type=competitive&season=&agent=all&map=all'

response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    # Process or use the data as needed
    print(data)
else:
    print(f'Failed to fetch data . Status code: {response.status_code}')
