Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86E07F7624
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKXORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKXORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9515A19A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:17:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5556C433CD;
        Fri, 24 Nov 2023 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700835431;
        bh=umb1lq+7x0di4GkTWElfAJiKHuYnyynTpxF8V0VWQ14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rW0B7dkoDAMXF3C8b51xqQYnjp/0ej9P/oNncvvL07WENujuurblmbxVjJSwx7wmB
         9KKHcOIYNeCVw4zCJhk5eB9xPYx1FC6SzFhublw39agOIs9ybkipKrUVf8kWaoPQB1
         5Oz0ulLztmqTP5R8wxPh9L8QI+4CmGvYsrs5ti0tb2QmZes7KUvcsXl0xtptfsqCVP
         BAGOB7XRL3w0YUYz1YRDr2amdMod2abgiEEgaFMdczTGqoUdW1zB0kkvS+cAK2mjcR
         fbj52ldJjgY/aKo/vWb0aCc5aaJOuscmUqgjnVk5MCYQih0+KJMbjPQZdsubDy3NQA
         WKH/df1ixMCvA==
Date:   Fri, 24 Nov 2023 14:17:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        robh+dt@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 1/2] ASoC: audio-graph-card2: Introduce
 playback-only/capture only DAI link flags
Message-ID: <ZWCwZNzWZNIefNjB@finisterre.sirena.org.uk>
References: <20231123160655.188428-1-daniel.baluta@oss.nxp.com>
 <20231123160655.188428-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KPJm13OYvLGl9q7Q"
Content-Disposition: inline
In-Reply-To: <20231123160655.188428-2-daniel.baluta@oss.nxp.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KPJm13OYvLGl9q7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 06:06:54PM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> We need this to signal that DAI link supports only one direction that
> can only be either playback or capture.
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

It'd be good if the changelog explained why we need this.

--KPJm13OYvLGl9q7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgsGMACgkQJNaLcl1U
h9CQZAf8CQihmPYaPIZSCRjd6wUATVjtfC2gIaucJq69pLgqmWIvLjsCCAnqqJbM
MlwcKVML2trFRWXG+bvNrIdtXLGr7/Hp0MiksG6oPuJsfKLdNPIEyKF17QYKs2iq
gPonNRnz5xePhFu3JWPJGbzeSu/kf2uq4mXOH7iwEBRmZFS35chTGBX5Shvrbvx2
UoNoyzy1nynNEAmplvYuqCvwXa6WD5UiwbgjMoIXy9UeD7tlytbxxUjdhSRPIq0e
cAfvAczOcivL6kSw079o4UGhAEOlU+fvm1YOn2QFoGQvlmQFtyBxhd02KhwKXfXL
7FxvwpPzuNJ2xjWnnIR3bf0Tlk11qw==
=c549
-----END PGP SIGNATURE-----

--KPJm13OYvLGl9q7Q--
