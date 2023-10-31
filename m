Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F967DD775
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjJaVG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJaVG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:06:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCC8F3;
        Tue, 31 Oct 2023 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698786379;
        bh=of0pl9Zp8MiZ1FNN1AWooh5vOCvzcmEBnYPYq2iyDXI=;
        h=Date:From:To:Cc:Subject:From;
        b=WXqyOj3NF0VtVdGGfu1pHjkgfNguCFqLhFk2tuU1aupSRAk3gP7h3rVJZ2hPfrdjM
         0p8CKqArM+SIv2Gg3zvWwahLjLfpcGeHLaxcpvX/4IlmARFYSndR7Pwcb5JNYAnTvB
         UolXvHJSVREjswmvlvK651DXVMHyuvAru1/D2T/9cyy0y5rLbYjw5uyaK/7P0UC9Mv
         RgcHJ9BYAi7TFkdsPHXPrLNuS4+N3X9oBacTdbiBi7ji8aAc+mijfmw5VmFhTdSpJ5
         kZkf4P1O7a8ja7z8ZDPgv7W8/3Nao3zBfBAorNaVsCBg9QGLzX7qaQn4BTMBZB9wR4
         aFAqPzuE628kw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKjNq3f0Pz4x1v;
        Wed,  1 Nov 2023 08:06:19 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 08:06:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20231101080618.17fd208a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YxtM1LuF4nRD/U9+MdRczwC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YxtM1LuF4nRD/U9+MdRczwC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ed2232d49187 ("ASoC: amd: acp: fix for i2s mode register field update")

Fixes tag

  Fixes: 40f74d5f09d7 ("ASoC: amd: acp: refactor acp i2s clock

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes lines over more than one line.  Also, please
keep all the commit message tags together at the end of the commit
message.

--=20
Cheers,
Stephen Rothwell

--Sig_/YxtM1LuF4nRD/U9+MdRczwC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBbEoACgkQAVBC80lX
0Gxl5Qf/RVzpqUYAcWdKW5aconhiD9YgaZKmofe8tagmQhRTKrZgup0VoiWjQ9tF
yBcK8xHcM4a4EZcaQk9NNHleDNI2zogMsW28XHcYXLA6Ctz/2x5vOEAJgiI0g2TE
84MEnmHaSKKS/TdZ11p2tZ6WxfCGVjQO9LZOkw9G4ZGH+/FeX+AZbp28AY0+8NbX
tUmFdt6qubYydmuXHiI1lh47aRpBJ2rB3AqARHPvJNxy0EMA3pX11lqAxwit26mE
RG19VN5EDbpg3aqVSEEDwwDzTnvrRwnEW3XgWDqmP9H/KZTqJMQFKpPyhD/8kXVW
UNboWSjoT9Ym5sENpAhsWXCVV0yeyA==
=b0FW
-----END PGP SIGNATURE-----

--Sig_/YxtM1LuF4nRD/U9+MdRczwC--
