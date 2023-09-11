Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90A879A173
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjIKCiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjIKCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:38:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0EE99;
        Sun, 10 Sep 2023 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694399920;
        bh=4qaHdtNto7Db6RwIvpc8K/z+TccFThymM9grKdrd6HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OPv2fzIYikgLa44AhNbkKvKfhMEcS8AVLrioTmWhw/cDzYj4pO6ddaPocruX/TAim
         SVo7p7ShojsK01cImDvshL114nIyx7dKX/3KbBczfOhrShYTagEMxe+0RHwvnUzTwc
         eZySuqawUKPLCmsRlXCQzLVz/NrkTTgbHlhOfjEzWKVm+y52HGAqbyio4qMIPEeQ2u
         zIbUuhoTqxM/0JccNiy44FUI9sunmIfjQCHrkcOj1lljxCKlaHjw0I4I8RuGZMlg45
         BKlVFVV0m2cd0Or2ChGvIM+YPwetxVQ2I48gubhE1Ihah5G4kpFiyIrq1CbVowTpNZ
         rNbWpLyO1jeUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RkW9r53Jkz4xQT;
        Mon, 11 Sep 2023 12:38:40 +1000 (AEST)
Date:   Mon, 11 Sep 2023 12:38:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 6.6-rc1)
Message-ID: <20230911123839.7ab72f81@canb.auug.org.au>
In-Reply-To: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UgIKJd1WIRKeskxIXG2NAlB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UgIKJd1WIRKeskxIXG2NAlB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20230828 was the first linux-next after
the merge window opened.)

Commits in v6.6-rc1 (relative to v6.5):            12330
Commits in next-20230828:                          11959
Commits with the same SHA1:                        11436
Commits with the same patch_id:                      227 (1)
Commits with the same subject line:                   21 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20230828:     11684 94%

Some breakdown of the list of extra commits (relative to next-20230828)
in -rc1:

Top ten first word of commit summary:

     41 net
     36 riscv
     34 perf
     31 gfs2
     26 drm
     18 s390
     17 devlink
     15 tty
     15 dt-bindings
     15 bpf

Top ten authors:

     22 rpeterso@redhat.com
     20 robh@kernel.org
     20 irogers@google.com
     18 sd@queasysnail.net
     17 alexghiti@rivosinc.com
     15 jirislaby@kernel.org
     15 jiri@resnulli.us
     15 edumazet@google.com
     13 donald.hunter@gmail.com
     11 prabhakar.mahadev-lad.rj@bp.renesas.com

Top ten commiters:

     62 kuba@kernel.org
     61 palmer@rivosinc.com
     51 davem@davemloft.net
     33 agruenba@redhat.com
     32 acme@redhat.com
     26 alexander.deucher@amd.com
     24 daniel@iogearbox.net
     22 robh@kernel.org
     17 axboe@kernel.dk
     16 gregkh@linuxfoundation.org

There are also 275 commits in next-20230828 that didn't make it into
v6.6-rc1.

Top ten first word of commit summary:

     39 arm64
     38 drm
     34 accel
     21 x86
     20 apparmor
     17 nvmem
     14 dt-bindings
     13 soc
     13 arm
      8 btrfs

Top ten authors:

     21 jpoimboe@kernel.org
     12 treding@nvidia.com
     11 ttayar@habana.ai
     11 cuigaosheng1@huawei.com
      9 sean@geanix.com
      8 prike.liang@amd.com
      8 hch@lst.de
      8 frank.li@vivo.com
      6 lang.yu@amd.com
      5 obitton@habana.ai

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

     37 alexander.deucher@amd.com
     34 ogabbay@kernel.org
     25 srinivas.kandagatla@linaro.org
     21 mingo@kernel.org
     20 john.johansen@canonical.com
     19 matthias.bgg@gmail.com
     18 treding@nvidia.com
     13 akpm@linux-foundation.org
     11 geert+renesas@glider.be
     10 alexandre.torgue@foss.st.com

--=20
Cheers,
Stephen Rothwell

--Sig_/UgIKJd1WIRKeskxIXG2NAlB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT+fa8ACgkQAVBC80lX
0GxmZgf/SkB7P3B0POJlbcnn1G9NysQej2KNOTe0ybA0tIuWMyojexjjbE65Wscu
Z2dCoPcrUPv9XZ13cHcxEtbBJBvuDoKIfmTacsNH+LKsShccm9C5eJy5z9nN20m3
mHyvue8wUEzrlMYB3gF5P0kZHrstjbTw5UTqi2p2izOQLCxbdgT/W8Y7rFwqBhmt
JPqNjG7khY8DgNPTNmPh67+3eS7YwSu7gzKdwPhXiIQ64fj93shAPzUjSFpvU2Ai
YRXQJnQacMaEfocjYujifxarhOytr4F/1VoTcatz5tBYWurMxix3do15bxarc9Cg
e1CUzeVRlnmWjL3BN9RCEwnhc1k/uQ==
=alaP
-----END PGP SIGNATURE-----

--Sig_/UgIKJd1WIRKeskxIXG2NAlB--
