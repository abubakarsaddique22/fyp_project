import subprocess
import threading
import uvicorn

# Start Streamlit
def run_streamlit():
    subprocess.Popen(["streamlit", "run", "Analysis_app.py"])

# Start FastAPI
def run_fastapi():
    uvicorn.run("main:app", host="0.0.0.0", port=10000)

# Run both
if __name__ == "__main__":
    threading.Thread(target=run_streamlit).start()
    run_fastapi()
