theory AInvsPre
imports PDPTEntries_AI ADT_AI
begin

locale AInvsPre =
  fixes state_ext_type1 :: "('a :: state_ext) itself"
  assumes ptable_rights_imp_user_frame:
    "\<And> (s :: 'a state) t x y. 
     valid_state s \<Longrightarrow> 
       ptable_rights t s x \<noteq> {} \<Longrightarrow>
       ptable_lift t s x = Some (addrFromPPtr y) \<Longrightarrow>
       in_user_frame y s"

definition
  "kernel_mappings \<equiv> {x. x \<ge> kernel_base}"

end