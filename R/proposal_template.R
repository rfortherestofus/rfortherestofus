gh::gh(
  "GET /repos/{owner}/{repo}/contents/{path}",
  owner = "rfortherestofus",
  repo = "proposal-template",
  path = "_extensions/proposal-template/_extension.yml",
  .token = gh_token()
)
