Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491E67688FA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjG3WAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3WAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:00:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231EAE5C;
        Sun, 30 Jul 2023 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690754428;
        bh=qs2xpOwdfcfN5m9kr2KRvg6IYCtu//ATnwWa9gYV0VI=;
        h=Date:From:To:Cc:Subject:From;
        b=cmI/ADAzfHzOrMvFgFZkAsmT0vrRZITfPvAl1ATSqz7sNmMZQ9MzxbPcPzdqsuRJT
         Z9XNm8R0hBlVvjufKbgr/b4ACU2FTD3WixZTjS5N0Mkoo0W3Iv5M6gMGDIlOPF23FF
         Q+uO1/i1IAM2Zc/dgVuN4k0QyksVx3UJbLKoyel96d75FYuO0l1cx9+p8mvj/YNcCu
         oll2tQgwIffgwqxZCiXogMrsNIKF3VTdUUMZQTdDFl6nsLY2lXYcUtDd6P+B5wzFfU
         JjCOD3KhGd7nPmQZBzefo4UDREuJfOkqcLgfVRVc1gs9OXzqnpDz/HW5+HH3aaVMOv
         11yh5s6wxiHvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDb0D6CJ1z4wy0;
        Mon, 31 Jul 2023 08:00:28 +1000 (AEST)
Date:   Mon, 31 Jul 2023 08:00:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20230731080028.2bf92e8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kl_tuxUUTW/.hEiO9VfebBl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kl_tuxUUTW/.hEiO9VfebBl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  93136dfd9566 ("media: ipu3-cio2: allow ipu_bridge to be a module again")

is missing a Signed-off-by from its author.

The author metadata in the commit is bady corrupted:
  Arnd BergmannArnd Bergmann <arnd@arndb.dearnd@kernel.org>

--=20
Cheers,
Stephen Rothwell

--Sig_/Kl_tuxUUTW/.hEiO9VfebBl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTG3XwACgkQAVBC80lX
0GwuqQf8CDEIxMLIyRMAzpg76R11cQIlA+q6UYZEDe3jUwD90D3Tw6I77vfrJvRA
Kb2SPX/RgOjU2I+0pRZRdcUHbOzzmJq+qiNGhomwVu8Iv5BkznNd9hfwnYTjhRVb
3QueHlAKFkOUlAltpAbx7PtP8Rase8yWqjY8EjLKXhUAq9tkAjNfpe3yP5ukqpwg
x5ySFa7UMTfHU8t7KzahqNEsxsV/We+84WxZV7nXfRPmY4x06cO9/ei5bWmGUGyc
ZCDdPW6fmcQEO7wJP5ZTGWpZzthd1PYduqS0X+Cq34LxOBmpMUVLatsRElSSx3v6
jzfLf74sC5crZuA+WgRs9fpmyWvR3g==
=I+mo
-----END PGP SIGNATURE-----

--Sig_/Kl_tuxUUTW/.hEiO9VfebBl--
