(*
 * Copyright 2014, NICTA
 *
 * This software may be distributed and modified according to the terms of
 * the GNU General Public License version 2. Note that NO WARRANTY is provided.
 * See "LICENSE_GPLv2.txt" for details.
 *
 * @TAG(NICTA_GPL)
 *)
(*<*)
(* THIS FILE IS AUTOMATICALLY GENERATED. YOUR EDITS WILL BE OVERWRITTEN. *)
theory GenFilter2System
imports UserFilter2
begin

type_synonym component = "(channel, component_state) comp"

(* Local and global state *)
type_synonym lstate = "component_state local_state"
type_synonym gstate = "(inst, channel, component_state) global_state"

definition
  Store_untrusted :: "(Store_channel \<Rightarrow> channel) \<Rightarrow> component"
where
  "Store_untrusted ch \<equiv>
    LOOP (
      UserStep
    \<squnion> ArbitraryRequest (ch Store_l)
    \<squnion> ArbitraryResponse (ch Store_l))"

definition
  Client_untrusted :: "(Client_channel \<Rightarrow> channel) \<Rightarrow> component"
where
  "Client_untrusted ch \<equiv>
    LOOP (
      UserStep
    \<squnion> ArbitraryRequest (ch Client_l)
    \<squnion> ArbitraryResponse (ch Client_l))"

definition
  Filter_untrusted :: "(Filter_channel \<Rightarrow> channel) \<Rightarrow> component"
where
  "Filter_untrusted ch \<equiv>
    LOOP (
      UserStep
    \<squnion> ArbitraryRequest (ch Filter_external)
    \<squnion> ArbitraryResponse (ch Filter_external)
    \<squnion> ArbitraryRequest (ch Filter_backing)
    \<squnion> ArbitraryResponse (ch Filter_backing))"

(* Component instantiations *)
definition
  store_untrusted :: component
where
  "store_untrusted \<equiv> Store_untrusted (\<lambda>c. case c of Store_l \<Rightarrow> two)"

definition
  client_untrusted :: component
where
  "client_untrusted \<equiv> Client_untrusted (\<lambda>c. case c of Client_l \<Rightarrow> one)"

definition
  filter_untrusted :: component
where
  "filter_untrusted \<equiv>
    Filter_untrusted (\<lambda>c. case c of Filter_backing \<Rightarrow> two
                                  | Filter_external \<Rightarrow> one)"

(* Global initial state *)
definition
  gs\<^sub>0 :: gstate
where
  "gs\<^sub>0 p \<equiv> case trusted p of Some s \<Rightarrow> Some s
    | _ \<Rightarrow> (case p of store \<Rightarrow> Some (store_untrusted, Component init_component_state)
                    | client \<Rightarrow> Some (client_untrusted, Component init_component_state)
                    | filter \<Rightarrow> Some (filter_untrusted, Component init_component_state))"

end
(*>*)
