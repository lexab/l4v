(*
 * Copyright 2014, General Dynamics C4 Systems
 *
 * This software may be distributed and modified according to the terms of
 * the GNU General Public License version 2. Note that NO WARRANTY is provided.
 * See "LICENSE_GPLv2.txt" for details.
 *
 * @TAG(GD_GPL)
 *)


theory Setup_Locale
imports "../../../lib/Qualify" "../../../lib/Unqualify"
begin

(* 
   We use a locale for namespacing architecture-specific definitions.
   An Arch locale is defined to precisely copy ARM so that we
   can open an architecture context in generic theories.

   Note that we always open ARM (as opposed to Arch) in ARM-specific theories so that
   constants, facts and types are correctly under the "ARM" namespace.

   We open Arch in generic theories when we want access to architecture-specific
   constants, facts and types but expect the block (begin ... end) 
   to be valid in all architectures.

*)

locale ARM
locale Arch

sublocale Arch \<subseteq> ARM .
sublocale ARM \<subseteq> Arch .

end