import os
from dotenv import load_dotenv
import uuid
from APIConnect.APIConnect import APIConnect
import json
from constants.exchange import ExchangeEnum
from constants.order_type import OrderTypeEnum
from constants.product_code import ProductCodeENum
from constants.duration import DurationEnum
from constants.action import ActionEnum


load_dotenv()
api_client = None

def _get_api_client():
    global api_client

    if api_client:
        return api_client

    api_key = os.getenv("API_KEY")
    api_secret = os.getenv("API_SECRET")

    with open("request_id.txt") as f:
        request_id = f.read().strip()

    api_client = APIConnect(api_key, api_secret, request_id, True)
    return api_client

# def _get_api_client():
#     api_key=os.getenv("API_KEY")
#     api_secret=os.getenv("API_SECRET")
#     # request_id=os.getenv("REQUEST_ID")
#     ini_path=os.getenv("NUVAMA_INI_PATH")
    
#     if not all([api_key,api_secret,
#                 # ini_path
#                 ]):
#         raise RuntimeError("Missing env variables")
#     with open("request_id.txt")as f:
#         request_id=f.read().strip()
#     return APIConnect(api_key,api_secret,request_id,
#                            True,

#                            )
def place_trade(
    symbol,
    exchange,
    side,
    quantity,
    order_type,
    validity,
    streaming_symbol,
    limit_price,
    product_code
):
    try:
        api = _get_api_client()

        print("\n---- TRADE REQUEST ----")
        print(symbol, exchange, side, quantity, order_type, limit_price)

        if order_type == "LIMIT" and limit_price <= 0:
            return {"error": "Limit price required for LIMIT order"}

        response = api.PlaceTrade(
            Trading_Symbol=symbol,
            Exchange=ExchangeEnum[exchange],
            Action=ActionEnum[side],
            Duration=DurationEnum[validity],
            Order_Type=OrderTypeEnum[order_type],
            Quantity=quantity,
            Streaming_Symbol=streaming_symbol,
            Limit_Price=str(limit_price),
            Disclosed_Quantity="0",
            TriggerPrice="0",
            ProductCode=ProductCodeENum[product_code]
        )

        print("---- BROKER RESPONSE ----")
        print("RAW:", response)
        print("LEN:", len(response))

        if not response:
            return {
                "error": "Broker returned empty response",
                "possible_reasons": [
                    "Session expired",
                    "Market closed",
                    "Invalid price",
                    "Invalid streaming symbol"
                ]
            }

        return response

    except SystemExit:
        return {"error": "Session expired. Re-login required."}

    except Exception as e:
        return {"error": str(e)}

# def place_trade(
#     symbol,
#     exchange,
#     side,
#     quantity,
#     order_type,
#     validity,
#     streaming_symbol,
#     limit_price,
#     product_code
# ):
#     try:
#         api_connect=_get_api_client()
    
#         response=api_connect.PlaceTrade(
#                                     Trading_Symbol=symbol,
#                                     Exchange=ExchangeEnum[exchange],
#                                     Action=ActionEnum[side],
#                                     Duration=DurationEnum[validity],
#                                     Order_Type=OrderTypeEnum[order_type],
#                                     Quantity=quantity,
#                                     Streaming_Symbol=streaming_symbol,
#                                     Limit_Price=str(limit_price),
#                                     Disclosed_Quantity="0",
#                                     TriggerPrice="0",
#                                     ProductCode=ProductCodeENum[product_code]
#                                     )
    
#         return response
#     except KeyError as e:
#         return {"error":f"Invalid enum val:{str(e)}"}
#     except Exception as e:
#         return {"error":str(e)}

def get_orders():
    try:
        api_connect=_get_api_client()
        raw=api_connect.OrderBook()
        return json.loads(raw)
    except SystemExit:
        return {
            "error": "Session expired",
            "action": "Please re-login via /login"
        }
        
    except Exception as e:
        return {
            "error": "OrderBook failed",
            "details": str(e)
        }
    

def get_trades():
    try:
        api_connect = _get_api_client()
        res = api_connect.TradeBook()
        print("TRADE BOOK:", res)
        return res

    except SystemExit:
        return {
            "error": "Session expired",
            "action": "Please re-login via /login"
        }

    except Exception as e:
        return {
            "error": "OrderBook failed",
            "details": str(e)
        }


# def get_trades():
#     try:
#         api_connect=_get_api_client()
#         return api_connect.TradeBook()
#         print("TRADE HIT")
#         print("Payload:", payload)

#         order = broker.place_order(...)
#         print("Order response:", order)

#         return order
#     except SystemExit:
#         return {
#             "error": "Session expired",
#             "action": "Please re-login via /login"
#         }
        
#     except Exception as e:
#         return {
#             "error": "OrderBook failed",
#             "details": str(e)
#         }