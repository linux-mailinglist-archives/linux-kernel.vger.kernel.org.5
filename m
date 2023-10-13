Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF57C869A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjJMNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjJMNSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:18:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751D91;
        Fri, 13 Oct 2023 06:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B380EC433C8;
        Fri, 13 Oct 2023 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697203131;
        bh=tfwxO8vY/5VZ2f6n/V/bDl2PR5lkSh2hbmTloas/vbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8l/+Xh+FfwFx+l9WHwzf+CivJ/aQqq9Ob4RuihtTBUpYiOuTy3Tr2sDTy8Hpah8a
         6xRRSLejv5k1mSGCuNEr9qde5MZaS9RjAz7zqKULnjRQzGCyM9KAggY1mVEWE6RvrR
         rU4XNPMhlHO8C1AoNLlpT/QoQEGY0EZS74Pkzj/GxgY/++gt4bBzD02xnAzPzYPF5D
         rOZvCL2jrS6V3YYoJuEQu0d15U95vNTmj0N/QwdvZTctYGALnn7ATPm/GwyHAGN5BR
         YRCs5xpVpvJzuojfHyS4mMnfWRu/75PUjo2zQHsyWLo1FhOlINZfK0f1AMYPZlGIdl
         u2p1k4sUiA0Dw==
Date:   Fri, 13 Oct 2023 14:18:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v6 01/11] ASoC: fsl_asrc: define functions for memory
 to memory usage
Message-ID: <ZSlDsZ+pFoefpYKF@finisterre.sirena.org.uk>
References: <1697185865-27528-1-git-send-email-shengjiu.wang@nxp.com>
 <1697185865-27528-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TrxnhrhreJ8i5XbB"
Content-Disposition: inline
In-Reply-To: <1697185865-27528-2-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TrxnhrhreJ8i5XbB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 04:30:55PM +0800, Shengjiu Wang wrote:
> ASRC can be used on memory to memory case, define several
> functions for m2m usage.

Acked-by: Mark Brown <broonie@kernel.org>

--TrxnhrhreJ8i5XbB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpQ7AACgkQJNaLcl1U
h9DVYgf/XvHmqiuXmRoN0U7tMZzo7WP+CLOA/DjYORoGLnjZnxp9vShIZ3Rb3yBD
zAFWBQlLSw1/NGqOUbgPbCEKjzACGAK/iDrvtmWuwK3Md03mHwm9dVlzDbHo/KsB
XEpVnISg49uAdGRDldGYcLhNUJmylglwuHdBQHUXTDXoubZlIKq3Y8lkO2UE++1F
JJWM51XbIJDShikbunKjiKnY9HwIsoIIYMzgXw26s7W3M5O/zmYJT4t9BWiOq/I/
eKiHLARnegDruQcOWp324f+MGV7eLtpOSB4oppydGT4532XH81CvdbBblFMsnyJH
h/YIjT8VFxVlIr6Wl9uEdHuKTTOPow==
=mvxU
-----END PGP SIGNATURE-----

--TrxnhrhreJ8i5XbB--
