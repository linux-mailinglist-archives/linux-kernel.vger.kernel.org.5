Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2F7E1F06
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjKFK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKFK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:58:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8DB0;
        Mon,  6 Nov 2023 02:58:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD3EC433C7;
        Mon,  6 Nov 2023 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699268329;
        bh=Sg8f81K8kk3/SHGG8dWL3FhrCJtkIiWJ0jEsgKtTGhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Th/nT6VeS2zk1OlULtw+APVIYXcTssnx5cdpxe9RWD0rBicD+1gbBEBPHnoIJ2JxS
         y0BaJK13gBKtKqEq76LNJbcJooPSje3Rwa686by63MpTCvKZ9nW0vsP+ImT+OBHxlT
         /nq79xJlOCrCMBfTp/K2hw05nNLWY9683dIA1GR968Irjlhm1oNjc/Q7Rh5/ujtfpE
         EJyXp/JtyEqTP9GYp16IRj+3RmdFZfOV5og+MqYW5QDIk7bLhEYHgjdSpFJKPghEE1
         8DyuRWRhuQF5tpNI71knoBGV9foel4lRcP/XoizdI/dUMengOwxo81jAxXZMKfiSbY
         cDmyD6XWbes/Q==
Date:   Mon, 6 Nov 2023 10:58:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 06/10] ASoC: pxa: Suppress SSPA on ARM64
Message-ID: <ZUjG5tUrBvm6PDvB@finisterre.sirena.org.uk>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
 <dc7aaff0-f767-494e-9a3a-40fcacc1674e@sirena.org.uk>
 <3b4ac48b-e29d-415f-89f1-6d354f18c4a4@arm.com>
 <4855402.GXAFRqVoOG@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDAfE28G8f8xdnBg"
Content-Disposition: inline
In-Reply-To: <4855402.GXAFRqVoOG@radijator>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDAfE28G8f8xdnBg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 05:58:05PM +0100, Duje Mihanovi=C4=87 wrote:

> I just looked at it again and it looks like no code in sound/soc/pxa/* or=
=20
> sound/arm/pxa* depends on AACI in any way. Therefore, I believe that to f=
ix=20
> this correctly, I would have to remove "select SND_ARM" from sound/soc/px=
a/
> Kconfig and optionally move the PXA2xx code out of sound/arm/ and into so=
und/
> soc/pxa/. Is this correct? If so, I'd also split that fix into a separate=
=20
> series.

There's the pxa-ac97 driver to consider...

--cDAfE28G8f8xdnBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVIxuUACgkQJNaLcl1U
h9AeGAf/c2+d+tcgxFoSAkZXFPkCaz/eMgb8h+BgUpxjiuIheHzsxvbKE0zqEpob
LLb77Y8RJuFjRED+1HDwewAzExBafqDv6jOitYbrJDCL+ERlb72HhaWK7jrSvo9y
OjupBMTVvmLY0W64K7Vb2NM0T2/OIxrKApBbEMUxxpEagmmM1I09erf7m1Gi0Sfl
31oZwOnmH810ZaG0mtQuZijawmCMSuEnpl0vjhrQe0D8mSieZRdlT8IdpMVN7sm+
IZ6qvIh644bG7uf1E9a0QV6eM9ziLMDdId1h4W3hCTssoFesy9wWw6dV2mZiKrat
/yjpAz05qMaAFLHi45RxQYjqwdAKQw==
=jjeN
-----END PGP SIGNATURE-----

--cDAfE28G8f8xdnBg--
