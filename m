Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28C1791F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbjIDWEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjIDWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:04:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C99C;
        Mon,  4 Sep 2023 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693865048;
        bh=AfWZi/bPn+vKFA9pzzajo9fomcUTmGfDGp2wv3bgFkc=;
        h=Date:From:To:Cc:Subject:From;
        b=c94YuYza+jF+Oygx3drYDE33iKenY5+EFFc29QiFAiDZ/8lU3vVXLvz+v/lkWUnlL
         HCyGTxRAcOYN6ZzhdB4MMR8XrIhk3kZATR5nKA+rduDjhrv3DsL6YKfT6ywZ0KEI2J
         vHd22qEaLAuJuZsr1Jw7HhcSETgZeX1P+F/KOv7jwmnT7pDSJ+4FJYI1X2idb1J7NM
         qEYd81ZblWfftg8dw4kf/VBiMvrwdfzyF0giY+2GN3YqJ2aM+5AhK/n4tRBy6YI2LU
         YTKkrEDTL5jX6n+lnnKyB9gNLL+oRgJNyG2r805RZIspMDWcDa72Zinot/mMzW+xr0
         OZF8p6ltOpytA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfjMr4Lx3z4wb0;
        Tue,  5 Sep 2023 08:04:08 +1000 (AEST)
Date:   Tue, 5 Sep 2023 08:04:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20230905080406.08167ab9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eem+6F+TvS6tNY3zcaO8JWJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eem+6F+TvS6tNY3zcaO8JWJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0401edffa338 ("dt-bindings: nvmem: Add t1023-sfp efuse support")
  050cd7f49580 ("dt-bindings: nvmem: sec-qfprom: Add bindings for secure qf=
prom")
  0991afbe4b18 ("nvmem: core: Notify when a new layout is registered")
  0a9ec38c47c1 ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")
  104af6a5b199 ("nvmem: core: Create all cells before adding the nvmem devi=
ce")
  31c8217bc34a ("dt-bindings: nvmem: fixed-cell: add compatible for MAC cel=
ls")
  3e0558db94db ("nvmem: Explicitly include correct DT includes")
  431f08ed0ba5 ("nvmem: qfprom: do some cleanup")
  4b71b2a44d7d ("dt-bindings: nvmem: Add compatible for QCM2290")
  5f41033e4154 ("nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resou=
rce()")
  67f919120705 ("nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resou=
rce()")
  6870b4a37343 ("nvmem: sunxi_sid: Convert to devm_platform_ioremap_resourc=
e()")
  6c7f48ea2e66 ("nvmem: core: Return NULL when no nvmem layout is found")
  77803ef86379 ("nvmem: stm32-romem: Use devm_platform_get_and_ioremap_reso=
urce()")
  8fd85ce6cfdf ("dt-bindings: nvmem: qfprom: Add compatible for MSM8226")
  97edd4c6ba34 ("nvmem: uniphier: Use devm_platform_get_and_ioremap_resourc=
e()")
  9d53d595f688 ("nvmem: Kconfig: Fix typo "drive" -> "driver"")
  ad065ae27bd1 ("nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_re=
source()")
  b8257f61b4dd ("nvmem: core: Do not open-code existing functions")
  c32f2186acc9 ("nvmem: u-boot-env:: Replace zero-length array with DECLARE=
_FLEX_ARRAY() helper")
  c8efcf7a86eb ("nvmem: add new NXP QorIQ eFuse driver")
  e75d23cf347d ("nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_r=
esource()")

--=20
Cheers,
Stephen Rothwell

--Sig_/eem+6F+TvS6tNY3zcaO8JWJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT2VFcACgkQAVBC80lX
0GzNzQf/UHK1bH0bVbTZqOKlkihy/vrLoF3AK58kjKsHe3lxy0d8Ad2TvJJnUuZg
TVYpYzXcg5v2Pkj9WnEomGyBXFPzwRJkMoNjJ/K6Z3A4stlaO8FCrz11kSqUdtN/
COCtz7YQMRHEb9YtxEjStBvrU8iVmt8LFt0sOzhCLLG2gAHk1Pyet8JnkdU46YTI
DZwnzSfql9HWRpblUrlwj5j8TitO72M4IG6uLZbaCHlugCc7I2XJDU6kbJT3q549
ZiDufxz60Tougzq0Qs8mGmRCd8bbDLzLvpPzu47CeT6eoPoOqSwp1GxV4eEsHFER
jkJyTACvE3lYL666P1fGhh4yGJFAzw==
=a0i4
-----END PGP SIGNATURE-----

--Sig_/eem+6F+TvS6tNY3zcaO8JWJ--
