# README

This is a quick example Rails 5 app using GraphQL.

### Setup

Getting setup is simple:

- clone the repo
- `cd` into the repo directory
- run `bin/setup`
- open `localhost:3000/graphiql` in your browser of choice
- drop the following snippet in as your query

```
{
  posts {
	  id,
  	title,
    body
 },
  classic_mustangs {
    link,
    thumbnail,
    title,
    price,
    specs,
    description
  }
  search_beers(q: "IPA") {
    name,
    description,
    abv,
    style,
    availability,
    label,
    serving_glass
  }
}
```

### More Info

Here are some links I used when building this little app:

- [https://rmosolgo.github.io/graphql-ruby/](https://rmosolgo.github.io/graphql-ruby/)
- [http://www.rubydoc.info/gems/graphql/GraphQL](http://www.rubydoc.info/gems/graphql/GraphQL)
- [https://github.com/motdotla/rails-graphql-heroku-template/blob/master/app/models/schema.rb](https://github.com/motdotla/rails-graphql-heroku-template/blob/master/app/models/schema.rb)


