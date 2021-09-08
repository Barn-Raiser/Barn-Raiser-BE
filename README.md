# BarnRaiser Backend

### Application Overview
BarnRaiser is a community-focused mutual aid platform. Visitors can post requests for support - referred to as _Needs_ - and also review open Needs filtered by location, category, or timeframe.

Clicking on a Need shows the detailed information about that Need, and provides the option to email the point of contact for that Need, or to sign up to volunteer for that Need. Volunteers are stored in the backend database and visible to Administrator users.

### Development Team
Timeframe: 2 weeks  

#### Backend
Heroku: [BarnRaiser BE](https://barn-raiser-be.herokuapp.com/)    
Contributors:
- Aliya Merali  
   [Github](https://github.com/aliyamerali) | [LinkedIn](https://www.linkedin.com/in/aliyamerali/)
- Andrew Shafer  
   [Github](https://github.com/Aphilosopher30) | [LinkedIn](https://www.linkedin.com/in/andrew-shafer-0631ab20a/)

#### Frontend
Heroku: [BarnRaiser](https://barn-raiser.herokuapp.com/)   
GitHub: [barn-raiser-ui](https://github.com/Barn-Raiser/barn-raiser-ui/)    
Contributors:
- Dean Cook  
   [Github](https://github.com/novaraptur) | [LinkedIn](https://www.linkedin.com/in/dean-r-cook/)
- Shauna Myers  
   [Github](https://github.com/ShaunaMyers) | [LinkedIn](https://www.linkedin.com/in/shauna-myers/)

### Database Schema
![Screen Shot 2021-09-05 at 11 05 07 AM](https://user-images.githubusercontent.com/5446926/132135254-3b35a83d-fd4b-4b63-9d0e-27b3a77929d9.png)

### Available Queries/Mutations
#### Queries
- [need(:id)](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/need_JSON_Contract.md)
- [allNeeds](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/allNeeds_JSON_Contract.md)
- [allActiveNeeds](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/allActiveNeeds_JSON_Contract.md)
- [upcomingActiveNeeds](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/upcomingActiveNeeds_JSON_Contract.md)
- [allCategories](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/allCategories_JSON_Contract.md)

#### Mutations
- [createNeed](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/createNeed_JSON_Contract.md)
- [createSupporter](https://github.com/Barn-Raiser/project-planning/blob/main/contracts/createSupporter_JSON_Contract.md)

### Backend Technologies
- Ruby 2.7.2
- Rails 5.2.6
- GraphQL
- PostgreSQL 13.4
- RSpec
- CircleCI
- Heroku

#### Important Gems(Libraries):
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
* [simplecov](https://github.com/simplecov-ruby/simplecov)

### Local Setup
To spin up this backend locally:
1. Fork and clone the repo
2. Install gem packages with `bundle install`
3. Run `$ rails db:{create,migrate}` to setup the database
4. From your terminal run `$ rails s`
5. Submit queries to http://localhost:3000/graphql using a tool like [curl](https://curl.se/) or [Postman](https://www.postman.com/).

### Project Management Tools + Processes
This project was managed with GitHub Projects (project board [here](https://github.com/orgs/Barn-Raiser/projects/1)), using a rebase workflow.

### Next Steps
The application as it currently stands demonstrates the basic functionality scoped for a single user. In the future, we'd like to:
* Implement authentication with user registration and login
* Include authorization rules with user and administrator roles
* Leverage GraphQL subscriptions to alert administrators or Need points of contact when a new supporter registers
