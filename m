Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451087A3E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjIQWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbjIQWBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:01:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79784D1;
        Sun, 17 Sep 2023 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694988091;
        bh=zUtP8JXVordBQJ9xgN0pkE76f+LqQAZon2NDBr6ifXU=;
        h=Date:From:To:Cc:Subject:From;
        b=BrR09xUHf86OkM1S0BAZ8v2hXK2SIkYQaCa1imQ6kRvVWGVckhzfHg7iJp1XK4ceE
         PuA9SZzPGxKQqaDxWVUS9ATKx62SL4CamCG97aA627DYfY1o6soZPBVrDap9JQtXuX
         n4Bv5s2ApTmrtDHh44HXXKgoRyx5imsrD0X0gBzU/IeVoWJ4Pgehi5JCoyB8Al2Xnn
         x7MZopBYZch1wBGugnAyT0xhchhnt+SEh+0o5vxPzAkpOnUu6+sHjyAsfjzfI14sa9
         +46TeXNMAUOGcO6l727awqrIjdnkPMt8j4d6GVFlHDyH5r+cb2l2FdRN8D5QSMDk0H
         j9OuKdxGOH0xw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rphhp4KFqz4wxn;
        Mon, 18 Sep 2023 08:01:30 +1000 (AEST)
Date:   Mon, 18 Sep 2023 08:01:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20230918080129.7be6b6df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JGyri1YrnTKTn/vMmE60Snd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JGyri1YrnTKTn/vMmE60Snd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e4d93065a508 ("freezer,sched: Use saved_state to reduce some spurious wak=
eups")
  fa14aa2c23d3 ("sched/core: Remove ifdeffery for saved_state")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/JGyri1YrnTKTn/vMmE60Snd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHdzkACgkQAVBC80lX
0GwafQf/QMo1y8EexRfEE89FcfRPe0/aFLXmVZe8rEgtBs7tg3v4mUokYFhn+4uJ
WDRMoMMQ4kN5cy10X4lrPt4ftsGxuItYgPB3mG+7rZQ41KaQlNUGd7mIy/ahJLiL
e7q8AJI431b4KMPk1WAnudQ7bMh5B01boqmC4UgoyTkKqpyvSRaUPxj+Id2dkf9j
OZW80rBYaIWMbVdtp26Di5+ExP2TROR9mEfG/yayMLi+sP+q8mBH74ySmaoRGzyJ
j2DQjUKhaFwdQ+lN+9/Hqa//CYyVHT0RqzTBVv8jK8+bd7AVrrY1JN+Ap85DjiuP
gPIerpuUlpNtS79SM8Gx0bgHxmzG0g==
=djW6
-----END PGP SIGNATURE-----

--Sig_/JGyri1YrnTKTn/vMmE60Snd--
