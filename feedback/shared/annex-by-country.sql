USE giec

SELECT
  countries.name AS `Country`,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Name`,
  institutions.name AS `Institution`
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
  countries.id,
  participations.author_id
ORDER BY
  countries.name,
  authors.last_name,
  authors.first_name
;
