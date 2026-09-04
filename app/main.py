from fastapi import FastAPI


app = FastAPI(title="Lecture 1 Codespaces POC")


@app.get("/")
def home() -> dict[str, str]:
    return {
        "message": "The FastAPI server is running inside the remote Linux environment."
    }


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
