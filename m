Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D667EB994
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjKNWtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjKNWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:49:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE76DB;
        Tue, 14 Nov 2023 14:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700002174;
        bh=vm2uTzIiqSSr6FSDEyJMGfR9WuQnzTH6xLtZ/57heuI=;
        h=Date:From:To:Cc:Subject:From;
        b=EplH6026GPtU2jdBDPgNq3C4WmyDjOEksg4Cl+d0tNbHZEZz088vKt6UVxr5TVOZQ
         WeNX2xbZze3FWMfH+5EUvhrFpibPAJRzFXD6+A/MhZ3BIhpzyCQiYicbgSq/4CNnvc
         TxwPtC2Aeyn+0gh4ITKlzVMzqOlQZRjYaIkiJQzjPd19A+tTNJBy6umWtd9JAJ2p2K
         D4y9bRo688GA5YSSJcMCD3IBXcKZgXFiB8dy8wHzua+q32s3PqNYlja2go4dmO10Mq
         IsCOGOyqYzeAVSF+c7tNr1MesP0OdtkoHJazIXAdCGG84twPeyo5Ctyet2uJz3hVjm
         4aYwqKJqMMDeQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVM1V1Yfpz4x5m;
        Wed, 15 Nov 2023 09:49:33 +1100 (AEDT)
Date:   Wed, 15 Nov 2023 09:49:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the hwmon-staging tree
Message-ID: <20231115094929.124e784d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A.27v/4n_PPUI_5CLmChzBd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A.27v/4n_PPUI_5CLmChzBd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the hwmon-fixes tree as different
commits (but the same patches):

  095d1c419ff1 ("hwmon: max31827: include regulator header")
  a41be5d68fbe ("hwmon: ltc2991: Fix spelling mistake "contiuous" -> "conti=
nuous"")

These are commits

  58ebe7fb6eb2 ("hwmon: max31827: include regulator header")
  d9995cd96928 ("hwmon: ltc2991: Fix spelling mistake "contiuous" -> "conti=
nuous"")

in the hwmon-fixes tree.

This latter one is already causing a conflict due to other changes.

--=20
Cheers,
Stephen Rothwell

--Sig_/A.27v/4n_PPUI_5CLmChzBd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVT+XkACgkQAVBC80lX
0GynaAf+Oovi6ncm1HRbEukX+aR0pzom5mbbzWLT3aLSXIcNpx+2vsnxnk8LdM9F
iIpk3giK2QvEUgz75H41v9u5CcABm304UNUqg6w8sB041uQ/KNDoXJxNLYJoD9fu
o59gCrSxOmmOKjszAVtoQNbyj25sa/ajdyIHBs77uFeZe1eg5q96A/67Xb+oGKt3
zWw3g4fdboJ+7lKJ+Nx0sWa+SD9BUGpKgSduXhtPY2qkDUlHHF/HaKbp2Ma044Hh
lJYM83Sgoch+O/9zmwVBf4ABmuwRGPtPE8i5VK49Oy94VhlirwWorwH5xS9kZaBa
FbqVuT7fUQOvUENQG4PhXpCnsN7sDw==
=8tX6
-----END PGP SIGNATURE-----

--Sig_/A.27v/4n_PPUI_5CLmChzBd--
