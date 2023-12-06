Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE908064FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjLFCd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:33:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214F9E;
        Tue,  5 Dec 2023 18:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701830039;
        bh=BCM+MfXUrTzHO36/7tt8Uv/b1nQ71LO63G+QflHlmmQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ts/PcCcXHPkTWYhkFWg/7PtlAz3jyhv/lCCwSvFFJqrrx60/3TOt2DN0GeZeYICWI
         RYRLY/vpRV5w3qrH8ok4WQmnlL3xONIvacAJfpsJevUzYrFX9Gmk5tDE9s58CCfNfq
         D8hrU+oxmU5aUdTpG+jm5aaB1bmoZH3GRLL4sxPpAwGownwMglZkobVOGO+n1Y1jF/
         9nlvN5yEgDi1XJv+5OsA6ba/+hrlORcKOgmt2U8j5k14ZadAS14QsyQUmnQypKiZ32
         ZDczFF5vxjG/aO+PldwkuOBPHA4ChmLN+DTZB6Qi2w68E5S7tNYx/sSpEMTR/2N2jT
         lOSJ3kRJ/affA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SlM0l21tsz4wcH;
        Wed,  6 Dec 2023 13:33:58 +1100 (AEDT)
Date:   Wed, 6 Dec 2023 13:33:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the asm-generic tree
Message-ID: <20231206133357.2aae6f49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uqlLKZjeeR++b7cjLeHjKlC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uqlLKZjeeR++b7cjLeHjKlC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit
(but the same patch):

  235a59c373b1 ("mips: remove extraneous asm-generic/iomap.h include")

This is commit

  83e9a9f1e7d6 ("mips: remove extraneous asm-generic/iomap.h include")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/uqlLKZjeeR++b7cjLeHjKlC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVv3ZUACgkQAVBC80lX
0Gx77gf8DqhSdROWbMGFPE8XU1BVs4exB0FYJMjO3yhkD6P6QvtHBxMKy+txHmGV
2Y85SDOBSu2vcDX1Q3TozWVuTAz7cSycoW+0c4pRum8VXydFNU9l3/LhHhsCeqQx
p8X9mkvDjaraOHju4HKISSKjlDwwl/LHN5B6XM1dFGdK1o6rJw/ax6RWT0Cx267c
Sh+WEpyhRgzQTnldvsXXbBkd6a/eZjGHSnvEx9YsVrVYyyKP0WIJ1n8g627wbM9Z
bY+SaudvgaFQW8MiLLXjHvk8XEbuBrY2z+m+KEHtmfyjktXmGsMTA5zZ7vYaACRi
y35+QD2woP01Grty4kS+DE3y3zCpDw==
=DqKZ
-----END PGP SIGNATURE-----

--Sig_/uqlLKZjeeR++b7cjLeHjKlC--
