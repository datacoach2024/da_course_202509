import streamlit as st
import plotly
import plotly.express as px
import pandas as pd


st.set_page_config(layout='wide')

st.title('My Dashboard')


st.header('A header')
st.subheader('A subheader')

st.write('Hello world!')

st.markdown('**Some** `text`')

tips = plotly.data.tips()


gender_options = tips['sex'].unique()
smoker_options = tips['smoker'].unique()
time_options = tips['time'].unique()
day_options = ['All',] + list(tips['day'].unique())
bill_limits = tips['total_bill'].agg(['min', 'max'])


with st.sidebar:
    gender_selected = st.multiselect(
        'Select gender',
        options=gender_options,
        default=gender_options
    )

    smoker_selected = st.multiselect(
        'Select smoker',
        options=smoker_options,
        default=smoker_options
    )

    time_selected = st.multiselect(
        'Select time',
        options=time_options,
        default=time_options
    )

    day_selected = st.radio(
        'Select day(s)',
        options=day_options,
        index=0
    )

    bill_range_selected = st.slider(
        'Select total_bill range',
        min_value=bill_limits[0],
        max_value=bill_limits[1],
        value=list(bill_limits)
    )


gender_filter = f"sex.isin({gender_selected})"
smoker_filter = f"smoker.isin({smoker_selected})"
time_filter = f"time.isin({time_selected})"
day_filter = f"day {'!=' if day_selected=='All' else '=='} '{day_selected}'"
total_bill_filter = f"total_bill.between({bill_range_selected[0]}, {bill_range_selected[1]})"

composite_filter = f"{gender_filter} and {smoker_filter} and {time_filter} and {day_filter} and {total_bill_filter}"

tips_filtered = tips.query(composite_filter)


col1, col2 = st.columns([.4, .6], gap='large')

with col1:
    st.dataframe(tips_filtered, hide_index=True)


scatter_fig = px.scatter(
    data_frame=tips_filtered,
    x='total_bill',
    y='tip'
)

with col2:
    st.plotly_chart(scatter_fig)