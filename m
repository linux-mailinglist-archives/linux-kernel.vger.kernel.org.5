Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3827CC1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjJQL3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:29:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41269B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:29:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E0DC433C7;
        Tue, 17 Oct 2023 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697542156;
        bh=LP4csdsL40nCe4OI51VZDntZqUrXlSQ7yWdsMFKaLak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0Cmq2C+o4Ccul/EWW2mklmE9X/PrY0lNRXHgKvtY3w4oCgdpp8BFoffq17cNW2q4
         /YosBj6Mku4+8YMfTAcfVGVPyGRkEhEaZGfnFdxmyZic8NU06T8oPaOEYAs4/O3P36
         uQol5micnCXAOrPBNDNbscb1aN1kKtHuv1AiZqddeTk/GJECc6L0zop6tMWh4pofAq
         0ossgeXpAJ/DPcA1zWayBKkKTk6TPIW1CMr/Osx6D2oyo8q2cK+6+L/LXv00xMt+SJ
         Tfg0AoN6ua6akDRHgjClxdF0NNTFjeo3ejUbWV4G7ewHDoKyIFEQn6WkvcmKJMZtPF
         jTR0SUq5q/qDA==
Date:   Tue, 17 Oct 2023 12:29:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: tas5805m: Disallow undefined
 properties
Message-ID: <0498f609-357b-4242-b3c1-d53967f1faa8@sirena.org.uk>
References: <20231016155547.2973853-1-robh@kernel.org>
 <20231017-blinking-barricade-9e068a5fc602@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b2wBVIPRJdO8J3Zq"
Content-Disposition: inline
In-Reply-To: <20231017-blinking-barricade-9e068a5fc602@spud>
X-Cookie: Santa Claus is watching!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b2wBVIPRJdO8J3Zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 11:50:42AM +0100, Conor Dooley wrote:
> On Mon, Oct 16, 2023 at 10:55:47AM -0500, Rob Herring wrote:
> > Device specific bindings should not allow undefined properties. This is
> > accomplished in json-schema with 'additionalProperties: false'.
> >=20
> > Examples should be last in the schema, so move additionalProperties up
> > while we're here.
> >=20
> > Signed-off-by: Rob Herring <robh@kernel.org>

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Rob, I don't have the original patch for this.  It looks like whatever
email troubles you were having are persisting - if there's anything else
you've sent me I'm just unawaere of it.=20

--b2wBVIPRJdO8J3Zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUucAYACgkQJNaLcl1U
h9A31Af/bVFGDwltLpFkDhMtgvv5mBtHMksfRt66A8yyK173lHwQv671KtfOouGV
Me5R/4H5X7taXZ5i29SzDGlKwvKEo05OoXVWCD1WXgpSBXQQO/m+5Lpw3v39mzj+
VUmhmFhXnVPZypXscP7Mf7e+J2rLNA4HcTphoqF2Ohprk3otRwQ+7GH7dUsjBB8j
h2psO+rfr0IxAK90iFfgLp/3pJyIfubRHgHiNMz/AeiPiJF4NZLPPxz2U+hpgdh+
kcQ95YVWFT3c9RPxPXUrcqolaBbXkNxCm3ErwHEWVA024Z/Ldx1YmO8jwgtmmBA3
n9W3o73nz1xspcS/4beeKkcZ7fH3jA==
=vvnq
-----END PGP SIGNATURE-----

--b2wBVIPRJdO8J3Zq--
