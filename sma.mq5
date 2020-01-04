#property indicator_chart_window

#property indicator_buffers 1
#property indicator_plots   1

#property indicator_label1 "SMA"
#property indicator_type1  DRAW_LINE
#property indicator_color1 clrRed
#property indicator_style1 STYLE_SOLID
#property indicator_width1 2

input int PERIOD = 12;

double sma[];

int OnInit()
{
	SetIndexBuffer(0, sma, INDICATOR_DATA);

	PlotIndexSetString(0, PLOT_LABEL, "SMA(" + IntegerToString(PERIOD) + ")");

	return INIT_SUCCEEDED;
}

int OnCalculate(const int       TOTAL,
		const int       PREV,
		const datetime &T[],
		const double   &O[],
		const double   &H[],
		const double   &L[],
		const double   &C[],
		const long     &TICK_VOL[],
		const long     &VOL[],
		const int      &SP[])
{
	sma(C, TOTAL, PREV);

	return TOTAL;
}

void sma(const double &C[], const int TOTAL, const int PREV)
{
	int BEGIN;

	if (PREV == 0) {
		BEGIN = 0;
	} else {
		BEGIN = PREV - 1;
	}

	for (int i = BEGIN; i < TOTAL; i++) {
		double sum = 0.0;
		for (int j = i - (PERIOD - 1); j <= i; j++) {
			if (j < 0) {
				sum += C[0];
			} else {
				sum += C[j];
			}
		}
		sma[i] = sum / PERIOD;
	}
}
