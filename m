Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB98A7BE69C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377687AbjJIQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377683AbjJIQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A4102
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2AFC433CC;
        Mon,  9 Oct 2023 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696869401;
        bh=jUtlqwEMn2KZFHhL84vsbzy62E/jQ9IHVeiIR+dgdME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukqTw6yAx9xZXzZu/8PsJbg/qq6AWNoyLzpX1TYC5EftTWC6ToteJaTiXhf6PzU0A
         5wBCFj8oWtwhs9tVStKAZr5mZup5lvq9UU+J5l/qQsK2Dji9GMKDD1iDfHUP/Uwi98
         vFd2kqCFIDYnbZrH0Xd3OicQR0UKp48FW3OnDlWpAwCujwIZXWRyiB5Wj8rtpAjlwc
         4hDYebItl9tJtJ2PVIOfJ+bsFq6JmBAJrt0ungX/IrpO3fOlCe0nufcGBkNDiupZ2H
         W67NEICrBvwMrkpjALwW0wf1QrN3tLRLHAFMz3Wh2TYHwUG4R4ngZBlYHgFjostCPW
         wEQrpOfY+Ln0w==
Date:   Mon, 9 Oct 2023 17:36:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_rpmsg: List
 DAPM endpoints ignoring system suspend
Message-ID: <50ad5eed-325c-457b-976e-4ffcf7696938@sirena.org.uk>
References: <20230925110946.3156100-1-chancel.liu@nxp.com>
 <ZRF8KI11IVf6NzpL@finisterre.sirena.org.uk>
 <DB9PR04MB94987AC750B4AB02DCBC44C8E3C2A@DB9PR04MB9498.eurprd04.prod.outlook.com>
 <ZRP2A1hvuB8ZymBK@finisterre.sirena.org.uk>
 <DB9PR04MB9498352BC1763048B8358D97E3C8A@DB9PR04MB9498.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YpmdxlIGHB5pmEP7"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB9498352BC1763048B8358D97E3C8A@DB9PR04MB9498.eurprd04.prod.outlook.com>
X-Cookie: What is the sound of one hand clapping?
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YpmdxlIGHB5pmEP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 11:13:49AM +0000, Chancel Liu wrote:

> Instead of "fsl,lpa-widgets", I would like to add a common property=20
> "ignore-suspend-widgets" in sound-card-common.yaml file. So not only rpmsg
> sound cards but also other sound cards which have such feature can use th=
is
> property to define wanted widgets ignoring suspend.
> What do you think about that?

We can perhaps bikeshed the name a bit to be more focused on the use
case but yes, that sounds reasonable.

--YpmdxlIGHB5pmEP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUkLBEACgkQJNaLcl1U
h9BE7gf/e2k4KxlF2CXa8VUkiAAnGisQr0YxQGZ4hg6Qf2VNcqgvRgb12u3r5CqZ
MlMItmfRzSiUOhCXYtyl9Iq58MtkaxNK4iWbNCVrZ0+fvUvEI8B9C2izjeYR2Lwj
8RirJfNnircg4thI9oRxPgQEEIoK/SI5iAlI9RliJrADXD/EETYQ/iaJ778Rh1AN
RTNseFJXS+BHwZ7rP09Va1GsROiMb2P9xtRVxAw02wiE5dUge0h43O+3fRyY1yLo
9BmxluF+wyXuHiuaBR4hCvAyM8lvp5JWsRdgT+2z0MAWTXVwP6R2bTfs3Xnm4ej9
UnKuK53QIGytXgaFriLzbO2ZU4gIsw==
=r9Lx
-----END PGP SIGNATURE-----

--YpmdxlIGHB5pmEP7--
