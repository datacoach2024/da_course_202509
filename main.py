import streamlit as st

tips_pg = st.Page('./tips.py', title='👨‍🍳 Tips')
stocks_pg = st.Page('./stocks.py', title='💴 Stocks')
pages = [tips_pg, stocks_pg]


pg = st.navigation(pages=pages, position='top')
pg.run()