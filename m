Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655197B53BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjJBNOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:14:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5493
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:14:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B20C433C8;
        Mon,  2 Oct 2023 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696252484;
        bh=HuaILnKaqJkgCcuZj0uhvKwWfMGfSaYcyoOOPL8N3Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyxj3Bm9iKxI/T17uFMykPGU1tTM7jVoFjG4QkCsRe4xLgXU0SNoiBzmpGqOQZR7D
         Krc3mkFWTAUtaF+MyUbwio62QhKKRk2Yea0YYP5vfditpWH6kCTNEjWCL1r5l/woGm
         LqbkTjiWtTWlV6ThgMN19+3YVO5Y9ZhoZu2zlqDQFXxdgYD4PB1r0YTXSSdJ6DLfOu
         HaEnTOpmRtJOqVMHA1q0uJFa8sHXvQv9U9draxNyirFHxy4XnLJ1e0SDZqfDf+/MX3
         EXVM+X1t+aZ5zLAUwpz7mfsZTsqJarJgILGGApfmvXswJWO9w7UMj9Cirqkyb/AFTo
         0ZfZSytatbVfA==
Date:   Mon, 2 Oct 2023 14:14:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Antoine Gennart <gennartan@disroot.org>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, baojun.xu@ti.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] audio: tlv320adc3xxx: BUG: Correct micbias setting
Message-ID: <d5250bc9-403e-4b2a-a5c9-1c3711caef68@sirena.org.uk>
References: <20230929130117.77661-1-gennartan@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="omQMoXSCBIHz/SbF"
Content-Disposition: inline
In-Reply-To: <20230929130117.77661-1-gennartan@disroot.org>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--omQMoXSCBIHz/SbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 03:01:17PM +0200, Antoine Gennart wrote:
> The micbias setting for tlv320adc can also have the value '3' which
> means that the micbias ouput pin is connected to the input pin AVDD.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--omQMoXSCBIHz/SbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUawj0ACgkQJNaLcl1U
h9Dhpgf+Mpc4EGYGbWS6TYHo7x660bBHpu32KWRzDoyKjmkmbTBakRX4niRBRqFN
kFvgfT/+UY1AV7dT/FTRb8qcAfIJvkCJkul7iIY/2DjVcr4Xm1779DqIE/zqnfri
qI+TJ7f4jgzl1XbAzG/3t4VT4HJsUo7Y3ajlAo2ZjQyePFRDeEEnZQ5i4oCXrq2u
3lKrvCzt5nnE1fVGPtj7vRHgnBmBuFiu47f38aEbG5CTY4zSHF69w4yrHDNI1E9m
FGSSaHn9N32xr00GeD2UGS0JYzfR4n+cAfTWMPKXKqgB+FzniGVEDOBNXgbdgnFX
dP5me0cXpACy2E5Yn7vBghaXy2K9wg==
=jAA9
-----END PGP SIGNATURE-----

--omQMoXSCBIHz/SbF--
