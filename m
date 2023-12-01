Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA18001FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377082AbjLADQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjLADQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:16:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D5A0;
        Thu, 30 Nov 2023 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701400621;
        bh=DpVmHZSbq3k9anbLD3zS7d+t6iwawrg86La9tsyDVgA=;
        h=Date:From:To:Cc:Subject:From;
        b=oahB17xnXPXYM2z+Lq43qCfExlPnF/VN48aIYTvhwwzI183TeINZpqdHhYzvfw9YJ
         vENSFwreWNg8FRUdkGW/8Chi+YMTuUdt9U1L40Dh1JlFi2ykd7bu5BvAk3AULYshVw
         t9C5fSEId9kEUf/ZY0lpY6u/Xl1xhWdymMFFru46Z/4ZmruSendI/TuRes1FzK7qgO
         0qSM+FPkwxH9ffXqC6vkZBgMYK0H/FsBQebT75ymrFMFAC5S/RTU/cT81DTq2Z275g
         e1jAAkDUcdevZ+sc9f4U+d0HAw0fpbOg4h1i1bsKUT1S5Zbwn/W7ojMWMwwQXoVced
         H9p850W+P1AYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShJBj2N56z4x5q;
        Fri,  1 Dec 2023 14:17:01 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 14:16:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the perf tree
Message-ID: <20231201141659.4de7f514@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jjAIfHAYGEUPqrGTGTBx0Xe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jjAIfHAYGEUPqrGTGTBx0Xe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  a399ee6773d6 ("tools: Disable __packed attribute compiler warning due to =
-Werror=3Dattributes")

This is commit

  57686a72da08 ("tools: Disable __packed attribute compiler warning due to =
-Werror=3Dattributes")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/jjAIfHAYGEUPqrGTGTBx0Xe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpUCsACgkQAVBC80lX
0GyupQf+Mzp8m/j6t+QPPAb/KWuqgVsWJB2vYjdJ1Qly8xD59cXdZi1cOq2JMjoe
UL0RYbh7JdKvdUQgxLmNr5becm3HsFe+ShV0InkE5wLRH+3aZhP6Y5a0x0FGV/Yx
yu62aluPbUIo5SNSJjJ8zlEBUhidEt7p8GzfhOXq7cypZII8t3gyVE34/NFqcwL2
o2oJ30rSMydiywNxij7hpzJb0Sz39atzRCixhZlh2J13eMFzRnrIQRrXLdFUTuAi
SqVF16WguINNXVDms56yPap8u72t7GLoCD6Iv4c8HEmfb1LflBCYt6d/YvJiUAsH
6znObbpQxLUODc/UPpVczP6mpwkHFw==
=jt7F
-----END PGP SIGNATURE-----

--Sig_/jjAIfHAYGEUPqrGTGTBx0Xe--
