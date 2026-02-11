import time
from trading.nuvama_client import _get_api_client

latest_ticks = {}

def start_market_stream(symbols):
    api = _get_api_client()

    # start quote socket (DO NOT PASS CALLBACK)
    api.initQuotesStreaming()

    while True:
        try:
            feed = api._APIConnect__feedObj

            # just store raw object safely
            if feed:
                latest_ticks["raw"] = str(feed)

            time.sleep(1)

        except Exception as e:
            print("Market fetch error:", e)
            time.sleep(2)

    api.initQuotesStreaming()