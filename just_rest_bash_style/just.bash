export JUST_PROJECT_REST_CALL_ROOT="$(pwd)";
. "${JUST_PROJECT_REST_CALL_ROOT}/rest.bash";

export BASE_URL='http://localhost:6000/';
export STAGING_SERVER_01_BASE_URL='https://server-name/base/api/';
export STAGING_BASE_URL='https://subdomain.domain.com/base/api/';

# TODO: change once we have auth
function _just_get_auth_token {
  atoken=`echo "" | sed -E 's/.*access_token\":\"([^,\"]*?)\",.*/\1/g'`;
  echo "$atoken";
}

function _just_post {
  local data="$1";
  [[ -z "$data" ]] && { echo "Must specify data!" >&2; return 1; }
  local auth="$2";
  local endpoint="$3";
  [[ -z "$endpoint" ]] && { echo "Must specify endpoint!" >&2; return 1; }
  local extra_headers="$4";
  local query_params="$5";
  local filetype="$6";
  filetype=${filetype:-"json"};
  local content_type="$7";
  content_type=${content_type:-"application/json"};
  [[ -e "$query_params" ]] && { query_params=`cat "$query_params"`; }
  [[ ! "$query_params" == "?"* ]] && { query_params=`echo "${query_params:+"?$query_params"}"`; }
  [[ -e "$extra_headers" ]] && { extra_headers=`cat "$extra_headers"`; }
  url="${BASE_URL}${endpoint}${query_params}";
  rest_post "$url" "$data" '' "$auth" "$filetype" "$content_type" "$extra_headers" '';
}

function _just_put {
  local data="$1";
  [[ -z "$data" ]] && { echo "Must specify data!" >&2; return 1; }
  local auth="$2";
  local endpoint="$3";
  [[ -z "$endpoint" ]] && { echo "Must specify endpoint!" >&2; return 1; }
  local extra_headers="$4";
  local query_params="$5";
  local filetype="$6";
  filetype=${filetype:-"json"};
  local content_type="$7";
  content_type=${content_type:-"application/json"};
  [[ -e "$query_params" ]] && { query_params=`cat "$query_params"`; }
  [[ ! "$query_params" == "?"* ]] && { query_params=`echo "${query_params:+"?$query_params"}"`; }
  [[ -e "$extra_headers" ]] && { extra_headers=`cat "$extra_headers"`; }
  url="${BASE_URL}${endpoint}${query_params}";
  rest_put "$url" "$data" '' "$auth" "$filetype" "$content_type" "$extra_headers" '';
}

function _just_get {
  local auth="$1";
  auth="${auth:-''}";
  local endpoint="$2";
  [[ -z "$endpoint" ]] && { echo "Must specify endpoint!" >&2; return 1; }
  local extra_headers="$3";
  local query_params="$4";
  local filetype="$5";
  filetype=${filetype:-"json"};
  [[ -e "$query_params" ]] && { query_params=`cat "$query_params"`; }
  [[ ! "$query_params" == "?"* ]] && { query_params=`echo "${query_params:+"?$query_params"}"`; }
  [[ -e "$extra_headers" ]] && { extra_headers=`cat "$extra_headers"`; }
  url="${BASE_URL}${endpoint}${query_params}";
  rest_get "$url" '' '' "$auth" "$filetype" '' "$extra_headers" '';
}

function just_get_movies_search {
  local query_params="$1";
  _just_get "`_just_get_auth_token`" "movies/search" "$query_params";
}

function just_get_movies {
  _just_get "`_just_get_auth_token`" "movies";
}

function just_post_movie {
  local data="$1";
  [[ -z "$data" ]] && { echo "Must specify data!" >&2; return 1; }
  _just_post "$data" "`_just_get_auth_token`" "movies";
}

function just_put_movie {
  local data="$1";
  [[ -z "$data" ]] && { echo "Must specify data!" >&2; return 1; }
  _just_put "$data" "`_just_get_auth_token`" "movies";
}

function just_put_movie_status {
  local id="$1";
  [[ -z "$id" ]] && { echo "Must specify id!" >&2; return 1; }
  local status="$2";
  [[ -z "$status" ]] && { echo "Must specify status!" >&2; return 1; }
  _just_put "" "`_just_get_auth_token`" "movie/$id/$status";
}

