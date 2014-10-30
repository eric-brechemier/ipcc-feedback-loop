CREATE OR REPLACE VIEW feedback_chapter AS
  SELECT
    participations.ar AS `AR`,
    participations.wg AS `WG`,
    chapters.number AS `CH`,
    participations.role AS `ROL`,
    authors.last_name,
    authors.first_name,
    chapters.title AS `Chapter`,
    roles.name AS `Role`,
    CONCAT(
      authors.first_name,
      ' ',
      authors.last_name,
      ' (',
      countries.name,
      ')'
    ) AS `Name (Country)`
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
  ORDER BY
    chapters.id,
    roles.rank,
    authors.last_name,
    authors.first_name
;

SELECT *
FROM
(
  SELECT `Chapter`, `Role`, `Name (Country)`
  FROM feedback_chapter
  WHERE ROL='CLA' AND AR=@AR AND WG=@WG AND CH=@CH
  ORDER BY last_name, first_name
) CLAs
UNION ALL
  SELECT '','',''
UNION ALL
SELECT *
FROM
(
  SELECT `Chapter`, `Role`, `Name (Country)`
  FROM feedback_chapter
  WHERE ROL='LA' AND AR=@AR AND WG=@WG AND CH=@CH
  ORDER BY last_name, first_name
) LAs
UNION ALL
  SELECT '','',''
UNION ALL
SELECT *
FROM
(
  SELECT `Chapter`, `Role`, `Name (Country)`
  FROM feedback_chapter
  WHERE ROL='CA' AND AR=@AR AND WG=@WG AND CH=@CH
  ORDER BY last_name, first_name
) CAs
UNION ALL
  SELECT '','',''
UNION ALL
SELECT *
FROM
(
  SELECT `Chapter`, `Role`, `Name (Country)`
  FROM feedback_chapter
  WHERE ROL='RE' AND AR=@AR AND WG=@WG AND CH=@CH
  ORDER BY last_name, first_name
) REs
;
