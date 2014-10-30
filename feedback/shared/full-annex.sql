SELECT
  chapters.number AS `#`,
  chapters.title AS `Chapter`,
  roles.name AS `Role`,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Name`,
  CONCAT(
    institutions.name,
    ', ',
    countries.name
  ) AS `Institution, Country`
FROM
  chapters
  JOIN participations
  ON chapters.ar = participations.ar
  AND chapters.wg = participations.wg
  AND chapters.number = participations.chapter
  JOIN roles
  ON roles.symbol = participations.role
  JOIN authors
  ON authors.id = participations.author_id
  JOIN institution_countries
  ON institution_countries.id = participations.institution_country_id
  JOIN institutions
  ON institutions.id = institution_countries.institution_id
  JOIN countries
  ON countries.id = institution_countries.country_id
WHERE
      participations.ar=@AR
  AND participations.wg=@WG
ORDER BY
  chapters.id,
  roles.rank,
  authors.last_name,
  authors.first_name
;
