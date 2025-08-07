# FastAPI DevOps Reddit Template

A FastAPI application that demonstrates how to fetch and serve data from Reddit's r/devops subreddit.

## Features

- Fetches top 10 posts from r/devops subreddit
- RESTful API with automatic documentation
- Pydantic models for data validation
- Async HTTP client for external API calls
- Error handling and timeout management

## Installation

1. Install dependencies:
```bash
uv pip install .
```

## Running the Application

1. Start the development server:
```bash
python main.py
```

2. The API will be available at `http://localhost:8000`

## Running the Application in Docker

```bash
docker build -t <account>/devops_reddit_scrapper .
docker run --name reddit-scraper-container -p8000:8000 <account>/devops_reddit_scrapper
docker pull <account>/devops_reddit_scrapper
```

## API Endpoints

- `GET /` - Root endpoint with API information
- `GET /devops/top?limit=10` - Fetch top posts from r/devops (limit: 1-25)
- `GET /docs` - Interactive API documentation (Swagger UI)
- `GET /redoc` - Alternative API documentation

## Example Usage

### Fetch top 10 DevOps posts:
```bash
curl http://localhost:8000/devops/top
```

### Fetch top 5 DevOps posts:
```bash
curl http://localhost:8000/devops/top?limit=5
```

## Response Format

```json
{
  "posts": [
    {
      "title": "Post Title",
      "author": "username",
      "score": 42,
      "num_comments": 15,
      "url": "https://example.com",
      "created_utc": 1640995200.0,
      "permalink": "https://reddit.com/r/devops/comments/...",
      "selftext": "Post content preview..."
    }
  ],
  "total_count": 10
}
```

## Kubernetes deployment

```bash
kubectl create ns devops
k get ns
kubectl create deployment drs --image=komodoroot/devops_reddit_scrapper -n devops
k get pods

k create ns devops2
cd k8s/
helm upgrade --install drs -n devops2 .
k get all -n devops2
```

## Development Notes

- Uses Reddit's public JSON API (no authentication required)
- Implements proper error handling for API timeouts and errors
- Includes rate limiting considerations with User-Agent header
- Follows FastAPI best practices with Pydantic models