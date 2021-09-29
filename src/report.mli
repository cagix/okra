(*
 * Copyright (c) 2021 Magnus Skjegstad <magnus@skjegstad.com>
 * Copyright (c) 2021 Thomas Gazagnaire <thomas@gazagnaire.org>
 * Copyright (c) 2021 Patrick Ferris <pf341@patricoferris.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

type t
type project
type objective

val project : t -> string -> project option
val objective : project -> string -> objective option
val krs : objective -> KR.t list
val dump : t Fmt.t
val of_krs : KR.t list -> t
val of_projects : project list -> t
val of_objectives : project:string -> objective list -> t

val of_markdown :
  ?ignore_sections:string list ->
  ?include_sections:string list ->
  Parser.markdown ->
  t

val iter :
  ?project:(string -> project -> unit) ->
  ?objective:(string -> objective -> unit) ->
  (KR.t -> unit) ->
  t ->
  unit

val add : t -> KR.t -> unit

val pp :
  ?include_krs:string list ->
  ?show_time:bool ->
  ?show_time_calc:bool ->
  ?show_engineers:bool ->
  t Printer.t
(** [pp] pretty-print weekly team reports.

    [include_krs] only includes this list of KR IDs. Note that this will ignore
    empty KR IDs or KRs marked as "NEW KR" unless specified in the list. If the
    list is empty, all KRs are returned.

    When [show_time_calc] is set, an extra line will be added to the output each
    time the same entry is included in the report with a sum at the end. This is
    useful for showing the intermediate steps when aggreating multiple reports
    that contain the same KR.

    [show_time] shows the time entries [show_engineers] shows the list of
    engineers *)

val print :
  ?include_krs:string list ->
  ?show_time:bool ->
  ?show_time_calc:bool ->
  ?show_engineers:bool ->
  t ->
  unit