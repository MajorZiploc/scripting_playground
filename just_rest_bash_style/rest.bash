function _rest_temp_response_loc {
  echo "/tmp/responses/";
}

function _rest_get_query_params {
  local url="$1";
  local query_params=`echo "$url" | sed -E "s/([^?]*?)\??(.*?)/\2/g"`;
  [[ -n "$query_params" ]] && { rest_encode_url "$query_params"; }
}

function _rest_get_base_url_with_endpoint {
  local url="$1";
  echo "$url" | sed -E "s/([^?]*?)\??(.*?)/\1/g";
}

function _rest_format_and_print_response {
  local _file="$1";
  prettier --write "$_file";
  cat "$_file";
}

function rest_encode_url {
  local url="$1";
  [[ -z "$url" ]] && { echo "Must specify url!" >&2; return 1; }
  echo "$url" | sed 's, ,%20,g;s,\!,%21,g;s,",%22,g;s,#,%23,g;s,\$,%24,g;s,'"'"',%27,g;';
}


function _rest_helper {
  local url="$1";
  local request_body="$2";
  local curl_flags="$3";
  local response_file_type="$4";
  local method="$5";
  local headers="$6";
  local trailing_command="$7";
  [[ -z "$url" ]] && { echo "Must specify url!" >&2; return 1; }
  echo "${content_type:="application/json"}" >/dev/null;
  echo "${curl_flags:="Lk"}" >/dev/null;
  echo "${response_file_type:="json"}" >/dev/null;
  temp_response_loc=`_rest_temp_response_loc`;
  mkdir -p "$temp_response_loc";
  local base_url_with_endpoint=`_rest_get_base_url_with_endpoint "$url"`;
  local _file="${temp_response_loc}$(basename "$base_url_with_endpoint" | tr "/" "_").${response_file_type}";
  local query_params=`_rest_get_query_params "$url"`;
  [[ -e "$request_body" ]] && { request_body=`cat "$request_body"`; }
  request_body=`echo "${request_body:+"-d '$request_body'"}"`;
  [[ ! "$curl_flags" == "-"* ]] && { curl_flags=`echo "${curl_flags:+"-$curl_flags"}"`; }
  [[ ! "$query_params" == "?"* ]] && { query_params=`echo "${query_params:+"?$query_params"}"`; }
  [[ ! "$method" == " -X"* ]] && { method=`echo "${method:+" -X $method"}"`; }
  [[ ! "$query_params" == "?"* ]] && { query_params=`echo "${query_params:+"?$query_params"}"`; }
  [[ ! "$trailing_command" == " "* ]] && { trailing_command=`echo "${trailing_command:+" $trailing_command"}"`; }
  [[ ! "$request_body" == " "* ]] && { request_body=`echo "${request_body:+" $request_body"}"`; }
  [[ ! "$headers" == " "* ]] && { headers=`echo "${headers:+" $headers"}"`; }
  url=" \"${base_url_with_endpoint}${query_params}\"";
  bash -c "
    curl $curl_flags$method$request_body$url$headers$trailing_command
  " > "$_file";
  _rest_format_and_print_response "$_file";
}

function _rest_helper_preper {
  local url="$1";
  local request_body="$2";
  local curl_flags="$3";
  local auth="$4";
  local response_file_type="$5";
  local content_type="$6";
  local extra_headers="$7";
  local trailing_command="$8";
  local method="$9";
  # authorization is mainly for Bearer token style auth
  if [[ ! "$auth" == *":"* ]]; then
    auth=`echo ${auth:+"-H \"Authorization: Bearer $auth\""}`;
  else
    auth=`echo ${auth:+"-H '$auth'"}`;
  fi
  [[ ! "$extra_headers" == " "* ]] && { extra_headers=`echo "${extra_headers:+" $extra_headers"}"`; }
  local headers="${content_type:+"-H \"Content-Type: $content_type\""} ${auth}${extra_headers}";
  _rest_helper "$url" "$request_body" "$curl_flags" "$response_file_type" "$method" "$headers" "$trailing_command";
}

function rest_get {
  _rest_helper_preper "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "GET";
}

function rest_post {
  _rest_helper_preper "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "POST";
}

function rest_put {
  _rest_helper_preper "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "PUT";
}

function rest_patch {
  _rest_helper_preper "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "PATCH";
}

function rest_generic {
  method="$8";
  [[ -z "$method" ]] && { echo "Must specify method!" >&2; return 1; }
  _rest_helper_preper "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$method";
}

