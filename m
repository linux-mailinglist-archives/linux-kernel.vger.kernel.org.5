Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B397979A189
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjIKCyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIKCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:54:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872ABB0;
        Sun, 10 Sep 2023 19:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694400842;
        bh=sC94OkEjNklVqKluKs/jz7fIsxI4ac629uX1SDfCOVU=;
        h=Date:From:To:Cc:Subject:From;
        b=Gx/eE0fily3R6IlVjuuyKg8moyix8OGRF7QgfrHamZCopN30++GJ1adVxPxqjIQqx
         fhfrt7X0vuPdqLL51yUqyx6l8dzTJnsIYYz3ZZYBdxIClR78+TRDyFL3ZNHixnTPP6
         +bgK08korvJhdu8YiUiRnhIcWwVpAqN85kdfRMp03H1m8MpUqgNT+HKm/Jhv7GLT9c
         M/EPw2Cm9Ra9fcwcLvQL+1Q873ywDOfnKbN4G0udgp49NR9pwY2qTqehz4xHuekqwV
         jUah0V7SHiBZ5bk0sY0Bc0UF20X7HfErZAzkKTmrZgstP4AeyZDxFpaKc1I9B+G+ir
         pUhY7sga40Mzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RkWWZ1hZbz4xQN;
        Mon, 11 Sep 2023 12:54:01 +1000 (AEST)
Date:   Mon, 11 Sep 2023 12:53:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the bcachefs tree
Message-ID: <20230911125359.5a61d30a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l0xyGRw.fatHo2alzDjjMH9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l0xyGRw.fatHo2alzDjjMH9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  6952ce94323e ("fixup bcachefs: Use for_each_btree_key_upto() more consist=
ently")
  465b4018393a ("fixup! bcachefs: Factor out __bch2_btree_iter_set_pos()")
  1f882e0766c1 ("Revert "bcachefs: statfs bfree and bavail should be the sa=
me"")
  5afaba4ad035 ("bcachefs: fix a possible bcachefs checksum mapping error o=
pt-checksum enum to type-checksum enum")
  5f3aa2627fe5 ("bcachefs: Fix unitialized use of a value")
  6547c5bd02fc ("bcachefs: Fix a deadlock")
  2833d0e7e154 ("bcachefs: rewrote prefetch asm in gas syntax for clang com=
patibility")
  733ab5f20977 ("bcachefs: made changes to support clang, fixed a couple bu=
gs")
  407f5f4c40dc ("bcachefs: Fix bkey_method compilation on gcc 7.3.0")

are missing a Signed-off-by from their author(s).

Commits

  594c33d7704f ("bcachefs: restart journal reclaim thread on ro->rw transit=
ions")
  0eb30f7f72b2 ("bcachefs: fix up wonky error handling in bch2_seek_pagecac=
he_hole()")
  2ef3bf79d875 ("bcachefs: Lower BCH_NAME_MAX to 512")
  1d8bc9862a8e ("bcachefs: Optimize bch2_dirent_name_bytes")
  09883ff4f3d2 ("bcachefs: Introduce bch2_dirent_get_name")
  0d5cdb5d1f94 ("bcachefs: Add btree_trans* to inode_set_fn")
  3d39f205c34a ("bcachefs: use prejournaled key updates for write buffer fl=
ushes")
  34dd841b4ece ("bcachefs: support btree updates of prejournaled keys")
  5fe49b157790 ("bcachefs: fold bch2_trans_update_by_path_trace() into call=
ers")
  d10d7eaafac6 ("bcachefs: remove unnecessary btree_insert_key_leaf() wrapp=
er")
  6afdf2a943de ("bcachefs: remove duplicate code between backpointer update=
 paths")
  9f40289714c8 ("MAINTAINERS: add Brian Foster as a reviewer for bcachefs")
  0808bfa932ad ("bcachefs: mark bch_inode_info and bkey_cached as reclaimab=
le")
  dd0b3714e925 ("bcachefs: flush journal to avoid invalid dev usage entries=
 on recovery")
  f3cd20387053 ("bcachefs: mark active journal devices on journal replicas =
gc")
  d68d3b600b69 ("bcachefs: fix NULL pointer dereference in try_alloc_bucket=
")
  80a232516183 ("bcachefs: don't spin in rebalance when background target i=
s not usable")
  5fcb4aecbe91 ("bcachefs: push rcu lock down into bch2_target_to_mask()")
  00ad66bfff3e ("bcachefs: create internal disk_groups sysfs file")
  f8c865fedb29 ("bcachefs: mark journal replicas before journal write submi=
ssion")
  a53344387468 ("bcachefs: remove unused key cache coherency flag")
  13a2acee0696 ("bcachefs: fix accounting corruption race between reclaim a=
nd dev add")
  6e2c8b06a832 ("bcachefs: remove bucket_gens btree keys on device removal")
  225d53c408b6 ("bcachefs: fix NULL bch_dev deref when checking bucket_gens=
 keys")
  7aa938d90b00 ("bcachefs: folio pos to bch_folio_sector index helper")
  858569294982 ("bcachefs: use u64 for folio end pos to avoid overflows")
  c97e3a250063 ("bcachefs: clean up post-eof folios on -ENOSPC")
  7c833a5e794f ("bcachefs: fix truncate overflow if folio is beyond EOF")
  54d85cf3fa2a ("bcachefs: use reservation for log messages during recovery=
")
  53b3581ee623 ("bcachefs: drop unnecessary journal stuck check from space =
calculation")
  40e5de902637 ("bcachefs: refactor journal stuck checking into standalone =
helper")
  c930660f32fb ("bcachefs: gracefully unwind journal res slowpath on shutdo=
wn")
  829dbc2bac41 ("bcachefs: more aggressive fast path write buffer key flush=
ing")
  5cbf9d221fc8 ("bcachefs: use dedicated workqueue for tasks holding write =
refs")
  71156b6a3040 ("bcachefs: remove unused bch2_trans_log_msg()")
  d49b36394c8f ("bcachefs: don't bump key cache journal seq on nojournal co=
mmits
")
  6952ce94323e ("fixup bcachefs: Use for_each_btree_key_upto() more consist=
ently")
  eef3450ac9a9 ("bcachefs: Reimplement repair for overlapping extents")
  94f785f6643e ("bcachefs: Don't run triggers when repairing in __bch2_mark=
_reflink_p()")
  283af2eb5446 ("bcachefs: let __bch2_btree_insert() pass in flags")
  13472af06d49 ("bcachefs: don't block reads if we're promoting")
  a62602f023d6 ("bcachefs: handle failed data_update_init cleanup")
  65834ad9e8a1 ("bcachefs: expose nocow_lock table in sysfs")
  fa7afefcc3cc ("bcachefs: Fix memleak in replicas_table_update()")
  c7a48eda7a36 ("bcachefs: fix bch2_write_extent() crc corruption.")
  da3c7e72d195 ("bcachefs: fix security warning in pr_name_and_units")
  b0d41643bf5e ("bcachefs: __bio_compress() fix up.")
  c53fa9b230a7 ("bcachefs: make durability a read-write sysfs option")
  a80d79f711e8 ("bcachefs: improve behaviour of btree_cache_scan()")
  f6c9ef277c9f ("bcachefs: remove dead whiteout_u64s argument.")
  0e83514260cb ("bcachefs: bch2_time_stats_to_text now indents properly")
  6dd502323a66 ("bcachefs: lock time stats prep work.")
  c8d1c78f006b ("bcachefs: fix __dev_available().")
  e51d1c8634bd ("bcachefs: Rename group to label for remaining strings.")
  6054a4fdaf82 ("bcachefs: Make bch_option compatible with Rust ffi")
  44564b19beee ("bcachefs: Add persistent counters")
  3c1cd27a6e8f ("bcachefs: respect superblock discard flag.")
  465b4018393a ("fixup! bcachefs: Factor out __bch2_btree_iter_set_pos()")
  a321016e7b8f ("bcachefs: Return -ENOKEY/EINVAL when mount decryption fail=
s")
  f7b56aa7634b ("bcachefs: Fix compiler warnings")
  995de4f9d73f ("bcachefs: Add a valgrind memcheck hint")
  b0d66ab8faa6 ("bcachefs: add progress stats to sysfs")
  26b6350d8599 ("bcachefs: Fix 32 bit build failures")
  1f882e0766c1 ("Revert "bcachefs: statfs bfree and bavail should be the sa=
me"")
  289709a07ff8 ("bcachefs: docs: add docs for bch2_trans_reset")
  50f8f276d491 ("bcachefs: set disk state should check new_state")
  e7e759f82298 ("bcachefs: add bcachefs xxhash support")
  b5a92cddb3e5 ("bcachefs: Prepare checksums for more advanced algorithms")
  f80bcfc7ced3 ("bcachefs: Enforce SYS_CAP_ADMIN within ioctls")
  63be0991647f ("bcachefs: Fix bch2_acl_chmod() cleanup on error")
  9de44dd81c5a ("bcachefs: statfs bfree and bavail should be the same")
  c72074059c96 ("bcachefs: fix truncate without a size change")
  da726a6616ff ("bcachefs: fix ifdef for x86_64 asm")
  7c8e7b9a36aa ("bcachefs: ensure iter->should_be_locked is set")
  a2f33554563f ("bcachefs: Fix unused variable warning when !BCACHEFS_DEBUG=
")
  eaf8681e232b ("bcachefs: ensure iter->should_be_locked is set")
  5afaba4ad035 ("bcachefs: fix a possible bcachefs checksum mapping error o=
pt-checksum enum to type-checksum enum")
  f661a523327e ("bcachefs: mount: fix null deref with null devname")
  5f3aa2627fe5 ("bcachefs: Fix unitialized use of a value")
  a8c2852f2c6d ("bcachefs: do not compile acl mod on minimal config")
  6547c5bd02fc ("bcachefs: Fix a deadlock")
  2833d0e7e154 ("bcachefs: rewrote prefetch asm in gas syntax for clang com=
patibility")
  578d368a9d94 ("bcachefs: statfs resports incorrect avail blocks")
  733ab5f20977 ("bcachefs: made changes to support clang, fixed a couple bu=
gs")
  2f9dc03f1555 ("locking: export contention tracepoints for bcachefs six lo=
cks")

are missing a Signed-off-by from their committer(s).

--=20
Cheers,
Stephen Rothwell

--Sig_/l0xyGRw.fatHo2alzDjjMH9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT+gUcACgkQAVBC80lX
0Gzdhwf+L7o+w9hwrHZ/biF73kvgPlNo+Xwis7qMyHN0CuxjNcVFeJ537bl2c1FN
XVd7699pJlJgVbyZqTZd/U5b0cnwGLdn3dD9aWyOBOc3hB7AS6Fzx159NORAq3GJ
nylC1RAc8Gva0BfxDb7HfP7x9CVEaQ47nfIYcGegksv6KrNRC/R2OA0svz6t7UtS
jz4UNpHMLy8mSxehj8kqF3iPxfE7aOCOLHBEQyh1dE/yyLWd3wJ9ADtPhlIJohTf
EwISbKKrPj8T30Pc15nCNIb9Rfh/qL9Gzseaoe2/dpvR4rXsSJvLT6gyjvQ2I1zc
0YGbic6dI1r4YZccXWibF4n9yjeawQ==
=HMv8
-----END PGP SIGNATURE-----

--Sig_/l0xyGRw.fatHo2alzDjjMH9--
