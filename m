Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3016B76E6F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjHCLc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjHCLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6F1981
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C107A61CF4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3A1C433C7;
        Thu,  3 Aug 2023 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062371;
        bh=i5W35nWalNHvzyZkha5GDZ9ilBdjAd73GB7rd1dqhOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trNi2I0gK0hw8S3zYu7HuwaqsRWhaxbxmpTkSc2QEEjayEchvYqfEVdK+I4Jqv4g9
         RRq5ZZJGH08RCCaivoZDPPAOPnkxAUfpfRuOGXjIYsz2hZVglOpOz6eddRynU6r/sX
         fuYynHtfayO0bldoi8dApnHpCBbuQb0PVDFyZDN4OWH3FWMneWjON/kgdMucnRYvvY
         wz7dD73FJ9sAcPvw83lHBuczI9UmuufT9Uy1LYxCVDGqjhZnnoZnwxYFYPF5w/PwS+
         lj4w9j9gv/sxNk5Df6FWtzRLDZuEeXy+RU1vIQsyLlZRSkxBYnpzxqkH0nOsPV96/C
         inBFXIfLaEfzw==
Date:   Thu, 3 Aug 2023 12:32:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: fsl: micfil: Use dual license micfil code
Message-ID: <8a1f9a9a-0962-4c64-8226-b48535a0ae86@sirena.org.uk>
References: <20230803072638.640789-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HC6W1CiDcuryTgiZ"
Content-Disposition: inline
In-Reply-To: <20230803072638.640789-1-daniel.baluta@oss.nxp.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HC6W1CiDcuryTgiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:26:38AM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> We need this in order to easily reuse register definitions
> and some functions with Sound Open Firmware driver.
>=20
> According to Documentation/process/license-rules.rst:
>     "Dual BSD/GPL"	The module is dual licensed under a GPL v2
> 			variant or BSD license choice. The exact
> 			variant of the BSD license can only be
> 			determined via the license information
> 			in the corresponding source files.
>=20
> so use "Dual BSD/GPL" for license string.

Adding Sascha as he seems to have written a lot of the commits for the
driver including some features.  Leaving the full message for his
benefit.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_micfil.c | 4 ++--
>  sound/soc/fsl/fsl_micfil.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index fe28b27e50d0..97cf315781ab 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  // Copyright 2018 NXP
> =20
>  #include <linux/bitfield.h>
> @@ -1254,4 +1254,4 @@ module_platform_driver(fsl_micfil_driver);
> =20
>  MODULE_AUTHOR("Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>");
>  MODULE_DESCRIPTION("NXP PDM Microphone Interface (MICFIL) driver");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
> index 9237a1c4cb8f..fee9fe3d9119 100644
> --- a/sound/soc/fsl/fsl_micfil.h
> +++ b/sound/soc/fsl/fsl_micfil.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>  /*
>   * PDM Microphone Interface for the NXP i.MX SoC
>   * Copyright 2018 NXP
> --=20
> 2.25.1
>=20

--HC6W1CiDcuryTgiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTLkFwACgkQJNaLcl1U
h9B2owf8Dfhe2aaQU6T1VGelLjjiQGDx+KrR3TJ0uHRrjviuLEmNS+WjpZouvVTv
lgSVXaBBdkO51rp0PYT2Q6AZP2jveImANJ7wLNh5hED0RGQIxDaR8/a7r/FyuZL6
atb4WTAR4q29lUSyxhf17HeiiJIM98GuwksLCm1e8fInIyXuoIIWBhFTdmCBRk9h
o+fIROMcxSjcdCMAy+6du/xaJxBFMZIP6gc219rycOIYMxkOIlvCnptC2ZK9PFzX
X9Sdmu7WsJOAt3UsVXC38BuKVjH/yaNKnqthd3ze87ECe+NfFoYvnTvh/pFxjkEz
wTCgEMN2dzLdup0IBM1Ux1haiIbRoQ==
=d7Kb
-----END PGP SIGNATURE-----

--HC6W1CiDcuryTgiZ--
