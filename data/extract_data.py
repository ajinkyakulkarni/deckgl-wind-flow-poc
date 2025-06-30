import xarray as xr
import pandas as pd
import numpy as np

ds = xr.open_dataset("pres_prediction_init_2020-01-01T00_00_00_prediction_2020-01-01T06_00_00.nc")


u_df = ds["U"].stack(points=("lev", "lat", "lon")).to_dataframe(name="U")['U'].reset_index()
v_df = ds["V"].stack(points=("lev", "lat", "lon")).to_dataframe(name="V")['V'].reset_index()

merged_df = pd.merge(u_df, v_df, on=["lev", "lat", "lon"])
merged_df.to_csv("uv.csv")