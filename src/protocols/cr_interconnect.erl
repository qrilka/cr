-module(cr_interconnect).
-copyright('Maxim Sokhatsky').
-include("cr.hrl").
-compile(export_all).
-record(state, {succ,pred,port,name,socket,module}).

sup() -> interconnect_sup.
init([Name,Mod,Socket]) -> #state{name=Name,module=Mod,socket=Socket}.

dispatch({'add_iterator',Object},State)  ->
    kvs:add(Object),
    State;

dispatch({'get_container',Table,Key},#state{socket=Socket}=State)  ->
    {ok,Record}=kvs:get(Table,Key),
    gen_tcp:send(Socket,)
    State.

ring() -> cr_hash:fresh(5,node()).

list_replicas(Key) ->
    cr_hash:successors(cr_hash:key_of(Key),cr_hash:fresh(5,node())).
