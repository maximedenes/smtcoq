(* This file is useful when the tactic goes through but not the Qed *)
(* It is works as is for standard-coq and checker_b but can be adapted for native-coq and/or checker_eq *)
(* Paste the environment and the following code : *)


Definition l := TO_FILL. (* find l in the expression <checker_b l b c> *)
Definition nclauses := let (nclauses, _, _) := c in nclauses. (* different in native-coq *)
Definition confl := let (_, _, confl) := c in confl. (* different in native-coq *)
Definition t := let (_, t, _) := c in t. (* different in native-coq *)


Definition nl := Lit.neg l.
Definition d := PArray.make nclauses nl.
Definition s := add_roots (S.make nclauses) d None.

Compute (checker_b l true c).
Compute (checker (PArray.make nclauses nl) None c).

Compute (Form.check_form t_form).
Compute (Atom.check_atom t_atom).
Compute (Atom.wt t_i t_func t_atom).
Compute (euf_checker (* t_atom t_form *) C.is_false s t confl).

(* Check where the false comes from, if its the last one it means the certificate is wring *)
(* To find what rule is causing this, use : *)



Definition flatten {A : Type} (trace : _trace_ A) :=
  let (t0, _) := t in t0.

(* INSTEAD in native-coq, use : *)
(* Definition flatten {A : Type} (trace : _trace_ A) := *)
(*   PArray.fold_left (fun l_step arr_step => l_step ++ PArray.to_list arr_step) *)
(*                    nil trace. *)

Import ListNotations.
Fixpoint firsts {A : Type} (n : nat) (l : list A) :=
  match n with
  | O => []
  | S n => match l with
           | [] => []
           | he :: ta => he :: firsts n ta end end.

Definition step_euf := @step_checker t_i t_func t_atom t_form.
Definition l_t := flatten t.


Definition up_to n := List.fold_left step_euf (firsts n l_t) s.
Definition nth n := List.nth (n-1) l_t (ImmBuildProj t_func t_atom t_form 99 99 99).

Compute (List.length l_t).


Compute (up_to 0).
Compute (up_to 1).
Compute (up_to 2).

Compute (up_to 3).
Compute (up_to 4).
Compute (up_to 5).
Compute (up_to 6).
Compute (nth 6).

Compute (up_to 7).
Compute (up_to 8).
Compute (up_to 9).
Compute (nth 9).
Compute (up_to 10).
Compute (nth 10).

Compute (Zpos (xO (xO (xI xH)))).

