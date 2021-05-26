%%--------------------------------------------------------------------
%% Copyright (c) 2020-2021 DGIOT Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(dgiot_api_app).

-behaviour(application).

-emqx_plugin(?MODULE).
-include("dgiot_api.hrl").
-include_lib("dgiot/include/logger.hrl").
-logger_header("[dgiot_api]").

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = dgiot_api_sup:start_link(),
    Spec = dgiot_http_server:child_spec(?APP, ?WEBSERVER),
    {ok, _} = supervisor:start_child(Sup, Spec),
    {ok, Sup}.

stop(_State) ->
    ok.

%% internal functions
