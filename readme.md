# Template graphql tymate
 based on :
 https://www.notion.so/tymate/How-to-start-up-a-project-from-scratch-with-GraphQL-32411f8a34b94198a3a6e6083cb332f1
# How to use it ?

- first go in your stack path
- run `mkdir rails_templates; cd rails_templates`
- run `git clone git@github.com:tymate/graphql_template.git`
- run `cd ..`
- run `rails new mon_project_api --database=postgresql -m rails_templates/graphql_template/setup.rb`

# what does it do
- setup basics gem
- setup graphql
- setup annotate
- setup rubocop
- setup doorkeerper
- setup clearance
- setup rspec with basic tests for current_user(graphql query) and refresh token(rest)
- chore


## TODO:
- [ ] fix gems versions ?
- [ ] chose implementation together and refacto with `inject_into_file` or `gsub_file`
- [ ] add conditional setup ? ex "Would you like to install Clearance ?"
- [ ] add one graphql mutation test ex: update user password
