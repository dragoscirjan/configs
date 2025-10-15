aws-creds() {
  local PROFILE=${1-${AWS_PROFILE:-default}}
  local CREDS

  grep "$PROFILE" ~/.aws/config >/dev/null || {
    echo "AWS SSO Profile is not configured. Please configure it using \`aws configure sso\`"
    exit 1
  }

  echo "You may not ... ???? SSO shit..." >&2
  if ! CREDS=$(aws configure export-credentials --profile "$PROFILE" --format env 2>/dev/null); then
    echo "SSO cache for profile '$PROFILE' is expired – firing authentication..." >&2
    aws sso login --profile "$PROFILE" || {
      echo "Authentication failed or aborted. No credentials exported" >&2
      return 1
    }
    CREDS=$(aws configure export-credentials --profile "$PROFILE" --format env)
  fi
  eval "$CREDS"
  echo "creds valid until: "
  node -p 'new Date(process.env.AWS_CREDENTIAL_EXPIRATION).toTimeString()'
}
