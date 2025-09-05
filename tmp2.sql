--SELECT * FROM ort_server.resolved_package_curation_providers
--INNER JOIN ort_server.resolved_configurations ON ort_server.resolved_configurations.id = ort_server.resolved_package_curation_providers.resolved_configuration_id
--WHERE ort_server.resolved_configurations.ort_run_id = 5
SELECT
    purl
FROM
    ort_server.package_curation_data
    INNER JOIN ort_server.package_curations ON ort_server.package_curations.package_curation_data_id = ort_server.package_curation_data.id
    INNER JOIN ort_server.resolved_package_curations ON ort_server.resolved_package_curations.package_curation_id = ort_server.package_curations.id
    INNER JOIN ort_server.resolved_package_curation_providers ON ort_server.resolved_package_curation_providers.id = ort_server.resolved_package_curations.resolved_package_curation_provider_id
    INNER JOIN ort_server.resolved_configurations ON ort_server.resolved_configurations.id = ort_server.resolved_package_curation_providers.resolved_configuration_id
    --WHERE ort_server.resolved_configurations.ort_run_id = 5
WHERE
    ort_server.package_curation_data.purl IS NOT NULL
    AND ort_server.package_curations.identifier_id = ort_server.identifiers.id
    AND ort_server.resolved_configurations.ort_run_id IN (16, 2, 3, 4, 5, 6, 14, 10)
ORDER BY
    ort_server.resolved_package_curation_providers.rank,
    ort_server.resolved_package_curations.rank
LIMIT
    1;