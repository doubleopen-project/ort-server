SELECT
    ort_server.vulnerabilities.id,
    ort_server.vulnerabilities.external_id,
    --ort_server.vulnerabilities.summary,
    --ort_server.vulnerabilities.description,
    ort_server.identifiers.id,
    ort_server.identifiers.type,
    ort_server.identifiers.namespace,
    ort_server.identifiers.name,
    ort_server.identifiers.version,
    MAX(
        CASE
            WHEN UPPER(ort_server.vulnerability_references.severity) = 'CRITICAL' THEN 4
            WHEN UPPER(ort_server.vulnerability_references.severity) = 'HIGH' THEN 3
            WHEN UPPER(ort_server.vulnerability_references.severity) = 'MEDIUM' THEN 2
            WHEN UPPER(ort_server.vulnerability_references.severity) = 'LOW' THEN 1
            ELSE 0
        END
    ) rating,
    STRING_AGG (
        DISTINCT CAST(ort_server.ort_runs.id AS TEXT),
        ','
    ) runIds,
    COUNT(DISTINCT ort_server.repositories.id) repositoriesCount,
    COALESCE(
        (
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
                1
        ),
        ort_server.packages.purl
    ) as purl
FROM
    ort_server.vulnerabilities
    INNER JOIN ort_server.advisor_results_vulnerabilities ON ort_server.vulnerabilities.id = ort_server.advisor_results_vulnerabilities.vulnerability_id
    INNER JOIN ort_server.advisor_results ON ort_server.advisor_results.id = ort_server.advisor_results_vulnerabilities.advisor_result_id
    INNER JOIN ort_server.advisor_runs_identifiers ON ort_server.advisor_runs_identifiers.id = ort_server.advisor_results.advisor_run_identifier_id
    INNER JOIN ort_server.advisor_runs ON ort_server.advisor_runs.id = ort_server.advisor_runs_identifiers.advisor_run_id
    INNER JOIN ort_server.advisor_jobs ON ort_server.advisor_jobs.id = ort_server.advisor_runs.advisor_job_id
    INNER JOIN ort_server.ort_runs ON ort_server.ort_runs.id = ort_server.advisor_jobs.ort_run_id
    INNER JOIN ort_server.repositories ON ort_server.repositories.id = ort_server.ort_runs.repository_id
    INNER JOIN ort_server.identifiers ON ort_server.identifiers.id = ort_server.advisor_runs_identifiers.identifier_id
    INNER JOIN ort_server.vulnerability_references ON ort_server.vulnerabilities.id = ort_server.vulnerability_references.vulnerability_id
    INNER JOIN ort_server.analyzer_jobs ON ort_server.analyzer_jobs.ort_run_id = ort_server.ort_runs.id
    INNER JOIN ort_server.analyzer_runs ON ort_server.analyzer_runs.analyzer_job_id = ort_server.analyzer_jobs.id
    INNER JOIN ort_server.packages_analyzer_runs ON ort_server.packages_analyzer_runs.analyzer_run_id = ort_server.analyzer_runs.id
    INNER JOIN ort_server.packages ON ort_server.packages.id = ort_server.packages_analyzer_runs.package_id
    AND ort_server.packages.identifier_id = ort_server.identifiers.id
WHERE
    ort_server.ort_runs.id IN (16, 2, 3, 4, 5, 6, 14, 10)
GROUP BY
    ort_server.vulnerabilities.id,
    ort_server.identifiers.id,
    purl
ORDER BY
    rating DESC,
    repositoriesCount DESC
LIMIT
    10