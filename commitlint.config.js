module.exports = {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "header-max-length": [2, "always", 200],
    "scope-enum": [2, "always", ["app", "k8s", "infra", "ci", "docs", "security", "scripts", "policies"]],
  },
};
