SELECT
  CONCAT(
    UPPER(authors.last_name),
    ', ',
    authors.first_name
  ) AS `Name`,
  institutions.name AS `Institution`,
  countries.name AS `Country`
FROM
  participations
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
GROUP BY
  participations.author_id
ORDER BY
  authors.last_name,
  authors.first_name
;
