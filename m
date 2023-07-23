Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9494375E5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 01:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGWXDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 19:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGWXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 19:03:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F08E5C;
        Sun, 23 Jul 2023 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690153407;
        bh=vKk+zQjfeVHdrQhTyb8CNok8oPqG+yP/ASG9POArvxs=;
        h=Date:From:To:Cc:Subject:From;
        b=rXdVGqyPHy7OukkRWRXLDXcDT3CAAbRUUKXifHcJn/ujREhLG1P89+xo8TJUBUI38
         JxuA1oa/nK3e1+TgEUavK4pK1zP/QBTOw6UJrzBJ+DIDEuZt3nZy70AGZRWEepWr7K
         OB0TiZ75jglXBSS4SdtFA6ddp8rgMQcm8qZ8fbS7l7y6hVd+TwS4JHi51W3/0Di4KA
         GpyFoGnr6Kbeg8d94jPf7eGNWd7AAYX+a9xptOK0Rgrahvg3Ng2HRIAZJBjztov6Zc
         Ix0hFZLRDwbD49ycmXCq5Ls6pDy2QG9RDNz5afdhuIhec47XT7MHE4duRf3eWTWJz2
         vTSm9g7gPZLWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8Jk75Cv5z4wy1;
        Mon, 24 Jul 2023 09:03:27 +1000 (AEST)
Date:   Mon, 24 Jul 2023 09:03:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230724090326.72e61015@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7dqyzp9CXjG.3lFeIoEqTvW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7dqyzp9CXjG.3lFeIoEqTvW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  5ad6c1f83fb9 ("kbuild: flatten KBUILD_CFLAGS")

This is commit

  0817d2599cfe ("kbuild: flatten KBUILD_CFLAGS")

in Lunus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/7dqyzp9CXjG.3lFeIoEqTvW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9sb4ACgkQAVBC80lX
0GyALQf/YFMFFXobXndxXYJ8PRvkx+JN3zByw/VWDv9SMVt6QzLo+12teQx7rX/D
hRAhKpokasjqaATJfGRjdepN7FnuwkKkOWlbDlA6KxVZxq12wiYGM1IlUm34P9HH
lxQV4L58e7oIZ9QDgK2ZX7xxABCb1JGm0/7DlbtDn8zOGdhmLO8vyP8VgGkcNZaR
kcJ4mMcFH7k+Nu0h9Yr2hBSKQKH9PPDqQ1PLieTz5/CDj+1exsaNvwz4cnyTaLRJ
1qxy/AuVAnnsUywdVaT2+8cLEgiWjZK7EBkzif5yX/A49BAN6gmJbiAzGnDG6OpO
0x9T43FW00TSRk/U59sCkPXw5M+1PQ==
=2x4h
-----END PGP SIGNATURE-----

--Sig_/7dqyzp9CXjG.3lFeIoEqTvW--
