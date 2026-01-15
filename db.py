import sqlalchemy as db
from sqlalchemy import URL, text
import json


def read_credentials() -> str:
    with open('credentials.json') as f:
        credentials = json.load(f)

    connection_url = URL.create(
        drivername="postgresql+psycopg2",
        username = credentials['username'],
        password = credentials['password'],
        host = credentials['host'],
        port = credentials['port']
    )

    return connection_url

def set_connection():
    connection_url = read_credentials()
    engine = db.create_engine(connection_url)
    con = engine.connect()

    return con