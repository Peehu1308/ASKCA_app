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

def _get_api_client():
    api_key=os.getenv("API_KEY")
    api_secret=os.getenv("API_SECRET")
    # request_id=os.getenv("REQUEST_ID")
    ini_path=os.getenv("NUVAMA_INI_PATH")
    
    if not all([api_key,api_secret,
                # ini_path
                ]):
        raise RuntimeError("Missing env variables")
    with open("request_id.txt")as f:
        request_id=f.read().strip()
    return APIConnect(api_key,api_secret,request_id,
                           True,

                           )
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
        api_connect = _get_api_client()

        print("---- TRADE REQUEST ----")
        print("Symbol:", symbol)
        print("Exchange:", exchange)
        print("Side:", side)
        print("Qty:", quantity)
        print("OrderType:", order_type)
        print("Validity:", validity)
        print("Price:", limit_price)
        print("Product:", product_code)

        response = api_connect.PlaceTrade(
            Trading_Symbol=symbol,
            Exchange=ExchangeEnum[exchange],
            Action=ActionEnum[side],
            Duration=DurationEnum[validity],
            Order_Type=OrderTypeEnum[order_type],
            Quantity=quantity,
            Streaming_Symbol=streaming_symbol,
            Limit_Price = str(limit_price) if order_type == "LIMIT" else "0",
            Disclosed_Quantity="0",
            TriggerPrice="0",
            ProductCode=ProductCodeENum[product_code]
        )

        print("---- BROKER RESPONSE ----")
        print(response)

        return response

    except KeyError as e:
        return {"error": f"Invalid enum val: {str(e)}"}
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