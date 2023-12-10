Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC66E80BD7B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjLJWC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:02:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F64AD5;
        Sun, 10 Dec 2023 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702245781;
        bh=2O4SnToZRlIJj7GU6Ia5ynTYDd4e5i3JyKdu2oxWSBg=;
        h=Date:From:To:Cc:Subject:From;
        b=a8AEjVnpBUTU7mWxergcOV6+v0PzAphEKAmYhJiqT9aKDjnVV5kEpsMiJiCUhxSW1
         zhSKiVDleTM59cjN/Jx2i3jEHgy02Eo/oGfKjXdZScDYJjA9P66gTKzu8r0LQCFzgx
         7nFq0Rfxjrat2hQ6ligXijjKBA3GltUuWNMx9GfEwnsUTsjX2/TTkBX7T0UP3xwB10
         WjA75M/Qljt4/k15Kg9WHUSNC3UCxQNMULHEusZg7H33sxEqUU1dR6McpjjOvlmynL
         mCXms0706CJ83Vc6jLXp4HByAbp0r8HEh6lMyoyGrFa6jn2rNJ22bslbjrmhJglRB6
         OJVQTxZacHO0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpJll5vnHz4wdC;
        Mon, 11 Dec 2023 09:02:59 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 09:02:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mvebu tree
Message-ID: <20231211090259.35d1ade6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IQWGjVU.65A+mu33_hHwozJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IQWGjVU.65A+mu33_hHwozJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  8b3ebdf4f061 ("ARM: dts: marvell: make dts use gpio-fan matrix instead of=
 array")
  c431744e514e ("ARM64: dts: Add special compatibles for the Turris Mox")
  818a1801d196 ("ARM64: dts: marvell: Fix some common switch mistakes")
  5c0b28f30f65 ("ARM: dts: marvell: Fix some common switch mistakes")
  e10957e4973c ("MAINTAINERS: add Marvell MBus driver to Marvell EBU SoCs s=
upport")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/IQWGjVU.65A+mu33_hHwozJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2NZMACgkQAVBC80lX
0GwEbQf5AdQCOpAm37qKAh0IlGf6YoNQ+Xj5xXREqVc6rn/Cm3kQim6S7F2twtPw
/rxze5bPxrQ4PFQ3J1zN8TjjKuY09E0p++rVCea8BYB6i7QdNIXOmbAjcLi18N0b
uer1BGZG7habrdQMr6xp9qf4fK4hnfDX+DjcECS2eN53knZkVEedqxdJpJczlCqr
oNe1j7tOs/T7ulsoJAkcMN2mvisXoy4rrBKnX5BDifunL4BTbLdG9qaVYSOTvXqq
0i/63c+Q4NH66Gq9XnvwbYUuWVlW7OzK06M68zBKvxQLxlj730ayLbry8Un6aQ4Y
lFltoOZvHgyTz9cXoI8qgXWdPvSieg==
=TjGD
-----END PGP SIGNATURE-----

--Sig_/IQWGjVU.65A+mu33_hHwozJ--
