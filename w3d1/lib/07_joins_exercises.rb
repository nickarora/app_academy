# == Schema Information
#
# Table name: actor
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movie
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director    :integer
#
# Table name: casting
#
#  movieid     :integer      not null, primary key
#  actorid     :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      title
    FROM
      casting c
      INNER JOIN movie m
        ON c.movieid = m.id
      INNER JOIN actor a
        ON c.actorid = a.id
    WHERE
      a.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      title
    FROM
      casting c
      INNER JOIN movie m
        ON c.movieid = m.id
      INNER JOIN actor a
        ON c.actorid = a.id
    WHERE
      a.name = 'Harrison Ford' AND
      c.ord != 1

  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      title, name AS leading_star
    FROM
      casting c
      INNER JOIN movie m
        ON c.movieid = m.id
      INNER JOIN actor a
        ON c.actorid = a.id
    WHERE
      m.yr = 1962 AND
      c.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      m.yr, COUNT(m.title)
    FROM
      casting c
        INNER JOIN movie m
          ON c.movieid = m.id
        INNER JOIN actor a
          ON c.actorid = a.id
    WHERE
      name = 'John Travolta'
    GROUP BY
      m.yr
    HAVING
      COUNT(m.title) > 1
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      m.title, a.name AS leading_actor
    FROM
      casting c
        INNER JOIN movie m
          ON c.movieid = m.id
        INNER JOIN actor a
          ON c.actorid = a.id
    WHERE
      c.ord = 1 AND
      m.title IN (
        SELECT
          m2.title
        FROM
          casting c2
            INNER JOIN movie m2
              ON c2.movieid = m2.id
            INNER JOIN actor a2
              ON c2.actorid = a2.id
        WHERE
          a2.name = 'Julie Andrews')
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)

    SELECT
      name
    FROM
      ( SELECT
          a.name, m.title
        FROM
          casting c
          INNER JOIN movie m
          ON c.movieid = m.id
          INNER JOIN actor a
          ON c.actorid = a.id
        WHERE
          c.ord = 1 ) AS starring_roles
      GROUP BY
        name
      HAVING
        COUNT(name) >= 15
      ORDER BY
        name
    SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      title, COUNT(name) AS cast_count
    FROM
      casting c
      INNER JOIN movie m
      ON c.movieid = m.id
      INNER JOIN actor a
      ON c.actorid = a.id
    WHERE
      m.yr = 1978
    GROUP BY
      title
    ORDER BY
      cast_count DESC, title ASC
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have worked with 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT DISTINCT
      name
    FROM
      casting c
      INNER JOIN movie m
      ON c.movieid = m.id
      INNER JOIN actor a
      ON c.actorid = a.id
    WHERE
      name != 'Art Garfunkel' AND
      m.id IN (
      SELECT
        m2.id
      FROM
        casting c2
        INNER JOIN movie m2
        ON c2.movieid = m2.id
        INNER JOIN actor a2
        ON c2.actorid = a2.id
      WHERE
        a2.name = 'Art Garfunkel')

  SQL
end
