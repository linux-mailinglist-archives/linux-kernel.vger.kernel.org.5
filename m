Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6A75D80D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGVAMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31F12F;
        Fri, 21 Jul 2023 17:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA50F61DB5;
        Sat, 22 Jul 2023 00:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF61C433C7;
        Sat, 22 Jul 2023 00:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689984762;
        bh=xIn7LIW3Am88HZKhucqW4ZhBJ10lWTPD5eayxdEyWaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyYy41QLKxVEbPCOs5ut0eKmId8vMYna3jIBKca9HALw+vRaaQiZAxwomzgKIml9P
         acbWpAs0re0qFbwHTf4KlPM45s9hX4y8GLx+9PlsfRK6GXkc5X8nEhbkfA/rZ74qNb
         blBbu4rIM+wJQDeR7Yl+YNCkOl4+LYKymGkfx/qkPrtdpaV32+wJ4r8QD6cD2iXkq2
         pa0pWZGOMTEutEV5HRHIF5/ecGwyNH2ahpxcGxZOKG3RizN+zFHefx4wlFXRAGtTHv
         MT5gWKmpcCk3pjXOa8ApLV5O9UWJT3roqoclABijDRKEBD/68AGxOhd5qLtlf8ZWU9
         f+5FV09oZZtJA==
Date:   Sat, 22 Jul 2023 01:12:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: freescale: verdin-imx8mp: dahlia: add
 sound card
Message-ID: <ZLse9jKdQqJILbVJ@finisterre.sirena.org.uk>
References: <20230719125430.249644-1-francesco@dolcini.it>
 <20230719125430.249644-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ern2nQKVDGv3ys/b"
Content-Disposition: inline
In-Reply-To: <20230719125430.249644-2-francesco@dolcini.it>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ern2nQKVDGv3ys/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 02:54:29PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Add WM8904 based analog sound card to Dahlia carrier board.

Tested-by: Mark Brown <broonie@kernel.org>

It'd be great to get this merged for the benefit of my CI.

--ern2nQKVDGv3ys/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS7HvUACgkQJNaLcl1U
h9Almwf/RE9gKuJIW6kdVX9eOd0obNnWUVlYY1rqDmgHoYJoTaFbISwffFbAXEtz
MIazx9+1AmE3UynGsAtfoMXSLIG69kaXlsiEM99PGuNE2A3zi0ZR6WeFNZaYkKAu
4bhjKByjpn+NKiPCWgw51UHMzoXSEKDNWpkagcIav/cskHkN7IILmqvsuF3buAMu
qZSnll+8BXIUUpnfSpHpW6qfBhj86SzEfsYkDjJnorLHCwVui+dalvyGHKLsxQhj
YBWVy4hFSogXNwNLrcXkhxbJM+rxdQqtSpUKGz5J+7b5OkbG5FpjQOAF6QG/95GH
zoU3QrHYoa0AQfFAPMqXTf98zIR6TA==
=ady3
-----END PGP SIGNATURE-----

--ern2nQKVDGv3ys/b--
