### Imports for FastApi

from fastapi import FastAPI
from pydantic import BaseModel

### imports for predicting price

import numpy as np
import pandas as pd
import datetime
from sklearn.preprocessing import LabelEncoder, MinMaxScaler
import torch

### Importing model

from pytorch_model import UsedCarPricePredictionNN


def convert_to_float(val):
    if not pd.isnull(val):
        return float(val.split(' ')[0])
    return val

train_data = pd.read_csv("train-data.csv", na_values=["null bhp"])
train_data.drop("New_Price", axis=1, inplace=True)
train_data.drop("Unnamed: 0", axis=1, inplace=True)
train_data["Seats"].fillna(train_data["Seats"].value_counts().values[0], inplace=True)


train_data["Power"] = train_data["Power"].apply(lambda val: convert_to_float(val))
train_data["Power"].fillna(train_data["Power"].mean(), inplace=True)
train_data["Engine"] = train_data["Engine"].apply(lambda val: convert_to_float(val))
train_data["Engine"].fillna(train_data["Engine"].median(), inplace=True)
train_data["Mileage"] = train_data["Mileage"].apply(lambda val: convert_to_float(val))
train_data.dropna(inplace=True)
train_data.drop(["Name", "Location"], axis=1, inplace=True)
# train_data['Total Years'] = datetime.datetime.now().year - train_data["Year"]
# train_data.drop('Year', axis=1, inplace=True)
# train_data["Price"] = train_data["Price"] * 100000

norm = MinMaxScaler()
cont_features = ['Year', 'Kilometers_Driven', 'Mileage', 'Engine', 'Power', 'Seats']

cont_features = np.stack([train_data[i].values for i in cont_features], axis = 1)
cont_features= norm.fit_transform(cont_features)
# cont_features = torch.tensor(cont_features, dtype = torch.float)
cat_features = ['Fuel_Type', 'Transmission', 'Owner_Type']

## Fuel Type

#  CNG, Diesel, Petrol, LPG, Electric

## Transmission

#  Manual, Automatic

## Owner_Type

# 

lbl_encoders = {}
for features in cat_features:
    lbl_encoders[features] = LabelEncoder()
    train_data[features] = lbl_encoders[features].fit_transform(train_data[features])

app = FastAPI()

price_predict_model = UsedCarPricePredictionNN([4, 2, 4], 6, [100, 50], 1, p=0.4)
price_predict_model.load_state_dict(torch.load('PriceWeights.pt'))
price_predict_model.eval()


class UsedCarAttributes(BaseModel):
    fuel_type: str
    transmission: str
    owner_type: str
    km_driven: int
    mileage: float
    engine: float
    power: float
    seats: int
    year: int

@app.post("/predict")
def predict_price(attributes: UsedCarAttributes):
    cat_array = np.array([lbl_encoders["Fuel_Type"].transform(np.array([attributes.fuel_type])), lbl_encoders["Transmission"].transform(np.array([attributes.transmission])), lbl_encoders["Owner_Type"].transform(np.array([attributes.owner_type]))])
    print(cat_array)
    cat_array = torch.tensor(cat_array.reshape(1, 3), dtype=torch.int64)
    # tot_year = datetime.datetime.now().year - attributes.year
    cont_array = np.array([[attributes.year, attributes.km_driven, attributes.mileage, attributes.engine, attributes.power, attributes.seats]])
    print(cont_array)
    cont_array = norm.transform(cont_array)[0]
    print(cont_array)
    cont_array = torch.tensor(cont_array.reshape(1,6), dtype = torch.float)
    predicted_value = price_predict_model(cat_array,cont_array).item()
    return {
        "task": "Successfully Predicted",
        "predicted_value": predicted_value * 100000
    }