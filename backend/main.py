from trading.market_stream import start_market_stream, latest_ticks
from fastapi import FastAPI, Request, WebSocket
from pydantic import BaseModel
from trading.nuvama_client import place_trade, get_orders
from fastapi.responses import RedirectResponse
from constants.exchange import ExchangeEnum
from constants.action import ActionEnum
from constants.order_type import OrderTypeEnum
from constants.duration import DurationEnum
from constants.product_code import ProductCodeENum
import threading
import asyncio

app = FastAPI()

@app.on_event("startup")
def start_stream():
    threading.Thread(
        target=start_market_stream,
        args=(["11536_NSE"],),  # 👈 IMPORTANT: comma!
        daemon=True
    ).start()


@app.websocket("/ws/market")
async def market_ws(ws: WebSocket):
    await ws.accept()
    try:
        while True:
            if latest_ticks:
                await ws.send_json(latest_ticks)
            await asyncio.sleep(0.2)
    except Exception:
        await ws.close()


NUVAMA_LOGIN_URL = "https://www.nuvamawealth.com/api-connect/login?api_key=CqaYbN86EaiTyA"

@app.get("/login")
def login():
    return RedirectResponse(NUVAMA_LOGIN_URL)

@app.get("/callback")
def callback(request: Request):
    request_id = request.query_params.get("request_id")
    if not request_id:
        return {"error": "requestId not found"}

    with open("request_id.txt", "w") as f:
        f.write(request_id)

    return {"status": "login_success"}

@app.get("/price/{symbol}")
def price(symbol: str):
    tick = latest_ticks.get(symbol)
    if not tick:
        return {
            "error": "No live data yet",
            "hint": "Wait 1–2 seconds after startup"
        }
    return tick

@app.get("/")
def root():
    return {"status": "backend is running"}

@app.get("/orders")
def orders():
    return get_orders()

class TradeRequest(BaseModel):
    symbol: str
    exchange: ExchangeEnum
    side: ActionEnum
    quantity: int
    order_type: OrderTypeEnum
    validity: DurationEnum
    streaming_symbol: str
    limit_price: float = 0
    product_code: ProductCodeENum = ProductCodeENum.CNC

@app.post("/trade")
def trade(trade: TradeRequest):
    res = place_trade(
        symbol=trade.symbol,
        exchange=trade.exchange.value,
        side=trade.side.value,
        quantity=trade.quantity,
        validity=trade.validity.value,
        order_type=trade.order_type.value,
        streaming_symbol=trade.streaming_symbol,
        limit_price=trade.limit_price,
        product_code=trade.product_code.value
    )

    print("TRADE RESPONSE:", res)   # 👈 ADD THIS
    return res