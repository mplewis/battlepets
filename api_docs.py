# Install the Python Requests library:
# `pip install requests`

import requests
import json


def leaderboard():
    # Leaderboard - top ten pets, sorted by win count
    # GET https://battlepets-mplewis.herokuapp.com/

    try:
        response = requests.get(
            url="https://battlepets-mplewis.herokuapp.com/",
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


def create_new_pet():
    # Create New Pet
    # POST https://battlepets-mplewis.herokuapp.com/pets

    try:
        response = requests.post(
            url="https://battlepets-mplewis.herokuapp.com/pets",
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


def list_all_pets():
    # List All Pets
    # GET https://battlepets-mplewis.herokuapp.com/pets

    try:
        response = requests.get(
            url="https://battlepets-mplewis.herokuapp.com/pets",
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


def send_request():
    # Train Pet
    # POST https://battlepets-mplewis.herokuapp.com/pets/1/train

    try:
        response = requests.post(
            url="https://battlepets-mplewis.herokuapp.com/pets/1/train",
            headers={
                "Content-Type": "application/json",
            },
            data=json.dumps({
                # Training types: sprinting, lifting, hunting
                # See training.yml
                "training": {"type": "sprinting"}
            })
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


def run_contest():
    # Run a Contest
    # POST https://battlepets-mplewis.herokuapp.com/matches

    try:
        response = requests.post(
            url="https://battlepets-mplewis.herokuapp.com/matches",
            headers={
                "Content-Type": "application/json",
            },
            data=json.dumps({
                "pets": [
                    # ID of every pet to participate
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                    "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"
                ],
                # Contest types: speed, power, evasion
                # See contest.yml
                "type": "speed"
            })
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


def get_pet_info():
    # Get Info on Pet
    # GET https://battlepets-mplewis.herokuapp.com/pets/1

    try:
        response = requests.get(
            url="https://battlepets-mplewis.herokuapp.com/pets/1",
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')
