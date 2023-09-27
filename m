Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A957B001B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjI0J3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjI0J3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:29:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC0CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:29:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BF5C433C7;
        Wed, 27 Sep 2023 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695806981;
        bh=PoynAhC42Ct+N5LxHx/oBa8Zl3onSqNPhKu1yqqfuCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I46iMBznA20yjD8uhY5Qh9Ki6oMk1pBVm3P7nWXi/Mt6g5XG/sSBgeI+alGlhDjyv
         Rp+wcfJ+1yNmiLkI99DrGrHYZ57KbA+kccDiooBhQPHxymj/oL5MCv0lxJAVPnAn0c
         y9Ds7V8pNS/a4vQqy/nJD5Jo19U6zjcNoNokZKHlMZLpNbPHtCZeCDEbJDpQ5STvGa
         tV0DK2K8ZhNPWhyjn2iIrCcc5mUAHbMHsupiyOzBrUjFuJEznhfEXWM8puzd8oxvMX
         Kk2fxTFBxUct64Pg2DCGj4ceXwRsSe0W1gsCVHN/P3jRUPsls15U3mfVG7+Dn1TxKa
         A+sG9yBWlHU5Q==
Date:   Wed, 27 Sep 2023 11:29:39 +0200
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
Subject: Re: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_rpmsg: List DAPM
 endpoints ignoring system suspend
Message-ID: <ZRP2A1hvuB8ZymBK@finisterre.sirena.org.uk>
References: <20230925110946.3156100-1-chancel.liu@nxp.com>
 <ZRF8KI11IVf6NzpL@finisterre.sirena.org.uk>
 <DB9PR04MB94987AC750B4AB02DCBC44C8E3C2A@DB9PR04MB9498.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M0KDERL2YfXElnfx"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB94987AC750B4AB02DCBC44C8E3C2A@DB9PR04MB9498.eurprd04.prod.outlook.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M0KDERL2YfXElnfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 03:07:49AM +0000, Chancel Liu wrote:

> > This is a fairly standard DSP playback case as far as I can see so it
> > should work with DAPM without needing this obviously use case specific
> > stuff peering into the Linux implementation.  Generally this is done by
> > tagging endpoint widgets and DAIs as ignore_suspend, DAPM will then
> > figure out the rest of the widgets in the path.

> Yes, indeed I meant to let driver get DAPM endpoints from the "fsl,lpa-widgets"
> property and then set these endpoints as ignore_suspend if the sound card is
> running in this use case. Do you think the description for the use case can be
> simplified since it's a common use case?

This is a card problem - the driver for rpmsg shouldn't need to worry
about it.  Any bindings extensions should be at the card level rather
than in a specific driver, we could probably use something in the
generic properties that they're all using.

--M0KDERL2YfXElnfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT9gIACgkQJNaLcl1U
h9Co/gf/YdAlws18Znc1Leg2ZPsdDGFeaWbgTuNgdJBfXu7DkM5EBpJwJitNdYBH
ee4d/A5s4cPYEwNBF6APc8Kuoo6ZLSzUUVTIoEVo3hx90x3VMkYHMG4ZrmbGHM1j
Q2Nb8wflfskYqPjLus1P4DcBWKulBIM1xfQGN3G4XZefa653qnNWGAoJLrIJr0BT
z5wh8S+9QtDJosvub7my40MWeV9d4i3yNywRESPCV7oFQd6c0WwDPrW6XxUClSEt
sKPmpp8TyP7AfzZoFiHYh3/97Qhm04LSjlNAybae7/XqRS6zFJGYi1rCSaT5Oaol
AklEsC5VrCYgCthrJITSvQd79yOuyg==
=w/+0
-----END PGP SIGNATURE-----

--M0KDERL2YfXElnfx--
