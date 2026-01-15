import streamlit as st
import plotly
import plotly.express as px
import pandas as pd

st.set_page_config(layout='wide')

st.title("Big Tech Companies Stocks Prices")

stocks = plotly.data.stocks()
stocks_melted = pd.melt(
    frame=stocks,
    id_vars='date',
    var_name='company',
    value_name='stock_price'
)

date_limits = stocks_melted['date'].agg(['min', 'max'])
company_options = stocks_melted['company'].unique()


with st.sidebar:
    period_selected = st.date_input(
        'Select period',
        min_value=date_limits[0],
        max_value=date_limits[1],
        value=list(date_limits)
    )

    companies_selected = st.multiselect(
        'Select company',
        options=company_options,
        default=company_options
    )



if len(list(period_selected)) == 2:
    period_filter = f"date.between('{period_selected[0]}', '{period_selected[1]}')"
else:
    period_filter = f"date == '{period_selected[0]}'"

companies_filter = f"company.isin({companies_selected})"


composite_filter = f"{period_filter} and {companies_filter}"

stocks_filtered = stocks_melted.query(composite_filter)

st.dataframe(stocks_filtered, hide_index=True)

line_fig = px.line(
    data_frame=stocks_filtered,
    x='date',
    y='stock_price',
    color='company'
)

st.plotly_chart(line_fig)