from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
#import joblib
import pickle
from fastapi.middleware.cors import CORSMiddleware

# Initialize FastAPI app
app = FastAPI()

# Enable CORS (for frontend connection)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace with ["http://localhost:3000"] for your React app
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define input data structure for real estate
class InputData(BaseModel):
    City: str
    property_type: str
    parking_spaces: int
    Bedrooms: int
    Bathrooms: int
    servant_Quarters: int
    Kitchens: int
    store_rooms: int
    age_possession: str
    area: float
    colony: str
    province: str

# preprocessor dataframe  
with open('final_data.pkl','rb') as f:
    df=pickle.load(f)

# Load model 
with open('model.pkl','rb') as f:
    model=pickle.load(f)

# preprocessor dataframe  
#with open('preprocessor.pkl','rb') as f:
    #preprocessor=pickle.load(f)
# Prediction endpoint
@app.post("/predict")
def predict(input_data: InputData):
    try:
        # Convert input to DataFrame using the provided format
        df = pd.DataFrame(data=dict(
            City=[input_data.City],
            property_type=[input_data.property_type],
            parking_spaces=[input_data.parking_spaces],
            Bedrooms=[input_data.Bedrooms],
            Bathrooms=[input_data.Bathrooms],
            servant_Quarters=[input_data.servant_Quarters],
            Kitchens=[input_data.Kitchens],
            store_rooms=[input_data.store_rooms],
            age_possession=[input_data.age_possession],
            area=[input_data.area],
            colony=[input_data.colony],
            province=[input_data.province]
        ))

        # Apply preprocessing
        # transformed_data = preprocessor.transform(df)

        # Make prediction
        prediction = model.predict(df)

        # Convert the numpy.float32 prediction to a standard Python float
        # return {"prediction": float(prediction[0])}
     # Simulate a prediction range with a 5% variation margin
        margin = 0.05  # 5% margin
        lower_bound = prediction[0] * (1 - margin)
        upper_bound = prediction[0] * (1 + margin)

        # Return the range of predicted values
        return {
            "prediction_range": f"{lower_bound:.6f} and {upper_bound:.6f}"
        }

    except Exception as e:
        return {"error": f"Error in prediction: {str(e)}"}


# # --- Input model for recommendation ---

class RecommendInput(BaseModel):
    City: str
    property_type: str
    age_possession: str
    colony: str
    price: float
    area: float

@app.post("/recommend")
def recommend(input_data: RecommendInput):
    filters = ['City', 'property_type', 'age_possession', 'colony']
    user_input = input_data.dict()
    
    for i in range(len(filters) + 1):
        temp_df = df.copy()
        for col in filters[:len(filters) - i]:
            temp_df = temp_df[temp_df[col].str.lower() == user_input[col].lower()]
        
        if not temp_df.empty:
            temp_df["score"] = (
                abs(temp_df["price"] - input_data.price) +
                abs(temp_df["area"] - input_data.area)
            )
            recommended = temp_df.sort_values("score").drop(columns=["score"]).head(5)
            return recommended.to_dict(orient="records")
    
    return {"message": "No similar properties found."}


# -------------------------------------------------------------------------
# For APi test use these fomat enter in postman or fastapi tempate 

# ---------------------------------------------------------------------------
# for price predition 

# {
#   "City": "Rawalpindi",
#   "property_type": "Houses",
#   "parking_spaces": 1,
#   "Bedrooms": 2,
#   "Bathrooms": 2,
#   "servant_Quarters": 1,
#   "Kitchens": 1,
#   "store_rooms": 1,
#   "age_possession": "Relatively New",
#   "area": 1000,
#   "colony": "Askari 14",
#   "province": "Punjab"
# }

# for recommand styem
 
# {
#      "City": "Rawalpindi",
#      "property_type": "Houses",
#      "age_possession": "Relatively New",
#      "colony": "Askari 14",
#      "area": 1000,
#      "price":1.5
# }




# ------------------------------------------------------------------------
# FastAPI run api command 
# ----------------------------------------------------------------------


# uvicorn main:app --reload



# --------------------------------------------------------
# Result for price prediction and this result show two value 
# I mean show value in range 

# -------------------------------------------------------------

# {
#     "prediction_range": "0.967425 and 1.069260"
# }



#----------------------------------------------------------
# Result for Recommand system api 

#---------------------------------------------------------

# [
    # {
    #     "City": "Lahore",
    #     "property_type": "Houses",
    #     "parking_spaces": 1,
    #     "Bedrooms": 2,
    #     "Bathrooms": 2,
    #     "servant_Quarters": 0,
    #     "Kitchens": 1,
    #     "store_rooms": 0,
    #     "price": 0.88,
    #     "age_possession": "Relatively New",
    #     "area": 1089.0,
    #     "colony": "Al Ahmad Rehman Garden Phase 2",
    #     "province": "Punjab"
    # },
#     {
#         "City": "Lahore",
#         "property_type": "Houses",
#         "parking_spaces": 1,
#         "Bedrooms": 3,
#         "Bathrooms": 4,
#         "servant_Quarters": 2,
#         "Kitchens": 2,
#         "store_rooms": 1,
#         "price": 1.15,
#         "age_possession": "Relatively New",
#         "area": 817.0,
#         "colony": "Al Ahmad Rehman Garden Phase 2",
#         "province": "Punjab"
#     },
#     {
#         "City": "Lahore",
#         "property_type": "Houses",
#         "parking_spaces": 1,
#         "Bedrooms": 3,
#         "Bathrooms": 4,
#         "servant_Quarters": 2,
#         "Kitchens": 2,
#         "store_rooms": 1,
#         "price": 1.02,
#         "age_possession": "Relatively New",
#         "area": 817.0,
#         "colony": "Al Ahmad Rehman Garden Phase 2",
#         "province": "Punjab"
#     },
#     {
#         "City": "Lahore",
#         "property_type": "Houses",
#         "parking_spaces": 1,
#         "Bedrooms": 3,
#         "Bathrooms": 4,
#         "servant_Quarters": 2,
#         "Kitchens": 2,
#         "store_rooms": 1,
#         "price": 0.85,
#         "age_possession": "Relatively New",
#         "area": 817.0,
#         "colony": "Awan Market",
#         "province": "Punjab"
#     },
#     {
#         "City": "Lahore",
#         "property_type": "Houses",
#         "parking_spaces": 1,
#         "Bedrooms": 2,
#         "Bathrooms": 2,
#         "servant_Quarters": 1,
#         "Kitchens": 2,
#         "store_rooms": 1,
#         "price": 0.65,
#         "age_possession": "Relatively New",
#         "area": 817.0,
#         "colony": "Al Ahmad Haram Garden",
#         "province": "Punjab"
#     }
# ]