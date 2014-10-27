USE giec

SELECT
  chapters.number AS `#`,
  chapters.title AS `Chapter`,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name,
    ', ',
    countries.name
  ) AS `Name, Country)`
FROM
  chapters
  JOIN participations
  ON chapters.ar = participations.ar
  AND chapters.wg = participations.wg
  AND chapters.number = participations.chapter
  JOIN authors
  ON authors.id = participations.author_id
  JOIN institution_countries
  ON institution_countries.id = participations.institution_country_id
  JOIN countries
  ON countries.id = institution_countries.country_id
WHERE
      participations.ar=@AR
  AND participations.wg=@WG
  AND participations.chapter=@CH
ORDER BY
  authors.last_name,
  authors.first_name
;
