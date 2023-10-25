Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447757D74AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjJYTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYTsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:48:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8F93;
        Wed, 25 Oct 2023 12:47:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD50C433C7;
        Wed, 25 Oct 2023 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698263279;
        bh=h4BRsvufsuFwSxNjBiJ/P4K5+hKj62Otlj2Fx1zE7Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agL6oJC/Uo/LtgyG6fI1q5xGq6xxjN+xbfVkC2zmSbjh56jDwuehSxu9XNKIPLCcU
         3ms5dxw7YS84RoE9b4FIFpThw8BOo8/Qm/56ptNZYnBA6mD+xezsYYBvqPkOVUyE6J
         2GZJTDRahrOnO41NemvJcqoLHZy7pJSU/qcMvrOu2pH5QcSIdwngBfz3OrC/F0h9GF
         JzA8BxCpieNh17KRvAnXvQ6+ZfrJLotTNuPCYxN4Vu0y++c63fNtBQWIaiuGYDxlTD
         cHRt8KC5SOvuc8C2beUaF3Q5iNSU/GKATpljTdsdxt8Ayjq7gksKr1CT24oRtY6iuQ
         VMsVsTwfelZfw==
Date:   Wed, 25 Oct 2023 20:47:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/30] Add support for QMC HDLC, framer infrastructure
 and PEF2256 framer
Message-ID: <a02dd435-9b7b-418e-a87c-28fad56f8004@sirena.org.uk>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
 <20231013164647.7855f09a@kernel.org>
 <20231025170051.27dc83ea@bootlin.com>
 <20231025123215.5caca7d4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TVHY9B7BnvBaREJ9"
Content-Disposition: inline
In-Reply-To: <20231025123215.5caca7d4@kernel.org>
X-Cookie: There's no time like the pleasant.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TVHY9B7BnvBaREJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 12:32:15PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 17:00:51 +0200 Herve Codina wrote:
> > > Which way will those patches go? Via some FSL SoC tree? =20

> > This series seems mature now.
> > What is the plan next in order to have it applied ?

> > Don't hesitate to tell me if you prefer split series.

> FWIW we are happy to take the drivers/net/ parts if there is no hard
> dependency. But there's no point taking that unless the SoC bits
> also go in for 6.7.

> Li Yang, what are your expectations WRT merging this series?

I did previously ask for the generic framer bit as a tag so I could
apply the ASoC part but nobody responded and I've been getting repeated
resends of the series :(

--TVHY9B7BnvBaREJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU5cN4ACgkQJNaLcl1U
h9BOigf/QB+M3jhpcGgpYNTcVVEM0JK0u1Vxzv91903ZwQlHKd6PSPWKFGwkPrbV
PkNR8xoBtGJp1rgu8AIQMhy8U+OFmf9Bsgc9Fzvakvb5/5oUOIAEyjCqLVOi9oVl
JiN7xM7bMd9vOk6g+b0UxRJjsF7+gqTYApUqigiblxG72qBLI0PYj9WauqiNNXkQ
stdLTuSDHBvXROKADqtlrjsSfU9kGw51/ZAILd4/s845m68TP4zRa9Ajz4vBWuRU
Re9dpEoBUQpd6lSkvAAlYJiYeOIeW2/EJqo1pU9areKbPkS4xwyKJKw4FQaXhwOA
hpVhGkXT/PcTml0V0pDfQyKUsbFWMA==
=1u2S
-----END PGP SIGNATURE-----

--TVHY9B7BnvBaREJ9--
