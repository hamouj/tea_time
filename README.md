
<!-- ReadMe -->
<a id="readme-top"></a>

<!-- Opening -->
<br />
<div align="center">
  <a href="https://github.com/hamouj/tea_time">
  </a>

<h3 align="center">Tea Time</h3>
  <p align="center">
    Tea Subscription Service API
    <hr>
    This API provides information about customer tea subscriptions and fulfills the requirements for the Turing School of Software & Design take-home challenge.
  </p>
</div>
<hr>
<br>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#schema">Schema</a></li>
        <li><a href="#testing">Testing</a></li>
      </ul>
    </li>
    <li>
    <a href="#endpoints">Endpoints</a>
    </li>
    <li> 
    <a href="#contact">Contributors</a>
    </li>
  </ol>
</details>
<br>

<!-- GETTING STARTED -->
## Getting Started

If you'd like to demo this API on your local machine:
1. Ensure you have the prerequisites
2. Clone this repo: `git@github.com:hamouj/tea_time.git`
3. Navigate to the root folder: `cd tea_time`
4. Run: `bundle install`
5. Run: `rails db:{create,migrate,seed}`
6. Inspect the `/db/schema.rb` and compare to the 'Schema' section below to ensure migration has been done successfully
7. Run: `rails s`
8. Visit http://localhost:3000/

<!-- Prerequisites -->
### Prerequisites

- Ruby Version 3.1.1
- Rails Version 7.0.4.x
- Bundler Version 2.4.9

<!-- Schema -->
### Schema

<img src="https://github.com/hamouj/image_repo/assets/114951691/0ccf28f0-075e-4d3b-94aa-54bce6f156a6" alt="Schema" width="100%">

<!-- Testing -->
### Testing
To test the entire spec suite, run `bundle exec rspec`.
*All tests should be passing.*

Happy path, sad path, and edge testing were considered and tested. When a request cannot be completed, an error object is returned.

<details>
  <summary>Error Object</summary>
    <pre>
    <code>
{
    "errors": [
        {
            "status": 404,
            "title": "record not found",
            "detail": "Couldn't find CustomerSubscription with 'id'=3"
        }
    ]
}
    </code>
  </pre>
</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Endpoints -->
## Endpoints

<details>
  <summary>Subscribe a customer to a tea subscription<br>
  <code>POST "/api/v1/customer_subscription"</code></summary>
  Request:
  <pre>
    <code>
{
  "customer_id": 1
   "subscription_id": 2
}
    </code>
  </pre>

  Response:
  <pre>
    <code>
{
    "data": {
        "id": "12",
        "type": "customer_subscription",
        "attributes": {
            "id": 12,
            "customer_id": 4,
            "subscription_id": 6,
            "status": "active"
        }
    }
}
    </code>
  </pre>
</details>

<details>
  <summary>Cancel a customer's tea subscription<br>
  <code>PATCH "/api/v1/random_acts"</code></summary>
  Request:
  <pre>
    <code>
{
    "id": 12,
    "status": "cancelled"
}
    </code>
  </pre>

  Response
  <pre>
    <code>
{
    "data": {
        "id": "12",
        "type": "customer_subscription",
        "attributes": {
            "id": 12,
            "customer_id": 4,
            "subscription_id": 6,
            "status": "cancelled"
        }
    }
}
    </code>
  </pre>
</details>

View these endpoints in [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/26085409-38914007-3a2c-4676-8467-e40407f1823d?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D26085409-38914007-3a2c-4676-8467-e40407f1823d%26entityType%3Dcollection%26workspaceId%3D1ed95997-2390-4abc-b31e-2cd34f407b2e)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<h2 id="contact">Contributors</h2>

| [<img alt="Jasmine Hamou" width="75" src="https://github.com/hamouj/image_repo/assets/114951691/03d1bbcf-1f28-48d7-98c0-cd38a9c41be1"/>](https://www.linkedin.com/in/jasmine-hamou/) |
| ------------------ | 
| Jasmine Hamou |
| Creator |
| [GitHub](https://github.com/hamouj) |
|  [LinkedIn](https://www.linkedin.com/in/jasmine-hamou/) |

<p align="right">(<a href="#readme-top">back to top</a>)</p>
