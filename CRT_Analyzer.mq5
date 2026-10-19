
#property strict
#property version "1.00"
#property description "CRT Analyzer - demo development"

input ENUM_TIMEFRAMES CRT_Timeframe = PERIOD_H1;
input int RangeCandle = 2;

string Pairs[] = {"EURUSD", "GBPUSD", "USDJPY"};

datetime LastChecked[3] = {0, 0, 0};

void OnTick()
{
   for(int i = 0; i < ArraySize(Pairs); i++)
   {
      string symbol = Pairs[i];

      if(!SymbolSelect(symbol, true))
         continue;

      datetime candleTime =
         iTime(symbol, CRT_Timeframe, 1);

      if(candleTime == 0 || candleTime == LastChecked[i])
         continue;

      LastChecked[i] = candleTime;

      double rangeHigh =
         iHigh(symbol, CRT_Timeframe, RangeCandle);

      double rangeLow =
         iLow(symbol, CRT_Timeframe, RangeCandle);

      double candleHigh =
         iHigh(symbol, CRT_Timeframe, 1);

      double candleLow =
         iLow(symbol, CRT_Timeframe, 1);

      double candleClose =
         iClose(symbol, CRT_Timeframe, 1);

      bool sweptHigh =
         candleHigh > rangeHigh &&
         candleClose < rangeHigh;

      bool sweptLow =
         candleLow < rangeLow &&
         candleClose > rangeLow;

      if(sweptHigh)
         Print(symbol, ": Possible high sweep");

      if(sweptLow)
         Print(symbol, ": Possible low sweep");
   }
}
