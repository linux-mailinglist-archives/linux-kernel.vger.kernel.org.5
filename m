Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC197DDA77
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbjKABBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376924AbjKABBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:01:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F065DA;
        Tue, 31 Oct 2023 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698800483;
        bh=w7cB5/DfsNaqHAPKVUm7+/nm2gVSnMiF+lwkwCzXS0M=;
        h=Date:From:To:Cc:Subject:From;
        b=CIUju1ue9BTFVzJw/ihRlwvFjYCJF/3WBslLnmml9yvA9JWSXwnTGWswged84PuiH
         3LzbcgBYMy1WaEy2qqCjN1IZi+g7+6uCmcesBcaCbiljpf3d1AccC8rcCJKjMg/5nc
         QYQyJdTyj4vFLro+TpTBF5FsNc73q+k85QMOeKuiZWwWOl9/mqlgThMiw0I3arojv9
         Gv/TB8ZUvY7L02NTJbS8NkJJ/8r6E3jlzY+URB08DU7x9l5dVm6SN5Ob5G2n3NYJMg
         CrMTV9I0/b9qg9A5WTFH54DSzfWrMaIkDur78bNrrlxFgyiW/0mBeQrLZ0Snd1U+cE
         VxTC6pvWRFK2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKpc22SpLz4wcg;
        Wed,  1 Nov 2023 12:01:22 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 12:01:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Yong He <alexyonghe@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20231101120121.04919c8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kux=L9QU4S1fMEsZ+sabZV3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kux=L9QU4S1fMEsZ+sabZV3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  8a77f38bcd28 ("srcu: Only accelerate on enqueue time")

This is commit

  1bb2b7de033a ("srcu: Only accelerate on enqueue time")

in the rcu tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kux=L9QU4S1fMEsZ+sabZV3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBo2EACgkQAVBC80lX
0GwSvwgApUQ+OPROhP/zc1Vvs8sQ+1iXls85Y/MCFdzXmMU4g+b+QMhIrWBiBwHC
ZCRdRhDPo8Ms6bk0qYs15AkNCNDLWgkSFFYRsj/9Ucv+3HcbitfIx3xe7yBJCeZw
82xVU+Ve/QukWaYwkP6c3a66MXmn4V8LhAXOFGcKUugAxDTQ1AjcmXrGj/sS3rWS
JbDBEwMJq1ml6dYsC8rkZeVIrQdnvnkgf+Lc0wB2shgNQ66YjqhjZ0IOR1UBI6up
rXatpGUzQcWr9I5L4+RCDV+Qo2HR0GJfzAncHQPLqQ70ZQzpRr6Y+X3hxx89Vujo
MH7WJ1TT89NiATeGDZmYcIKluy334w==
=RJiu
-----END PGP SIGNATURE-----

--Sig_/kux=L9QU4S1fMEsZ+sabZV3--
