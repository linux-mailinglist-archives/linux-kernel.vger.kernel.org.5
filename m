Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B27CFCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbjJSOjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjJSOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:39:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E8112;
        Thu, 19 Oct 2023 07:39:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1610C433C8;
        Thu, 19 Oct 2023 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697726378;
        bh=SoXuiL5s/SlvjK+pT6K1qf2tYDu8Ak9TPZKHzZUY9YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sp27wqADGIlgmpTPI1h6f3zKy4OIerBPynRS1yHKwrhfeli1snmnQG11brPsZ3HJv
         AKI9c4euIt7Oq0z4feJlJuNUeB6oe6tZmrFodoJFMyoSzkvEwn1W2u/JFj1t6eQGIt
         5c00YuxZdqlR0kGS9lIfJczulQW8Ju76smnONTLEg9V8mNqQ/DpRv6A99llB04yhW5
         /gbTaO2ffcen7gFpRHoxIvfPiEGy4cejQY8qxxWvrhGhXd3b3m5SWVy3E0yZMitY4K
         Qpt7dBmze4sOVEQzQCovd4MwmKUCY1l/jmEZ4uXLmEodC08HHSapW1P3EPWNzKWdmL
         ix9Jv0B6UpTmw==
Date:   Thu, 19 Oct 2023 15:39:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Estevam Moreira <estevam@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abelvesa@kernel.org, kernel@pengutronix.de,
        dl-linux-imx <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, inux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: support i.MX93 Anatop
Message-ID: <20231019-hydrant-landmass-7fee1399354f@spud>
References: <20231018084414.1950241-1-peng.fan@oss.nxp.com>
 <20231018-promenade-budding-3e228f241eb7@spud>
 <DU0PR04MB9417CD64DDD5238BCBC5B3E588D4A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231019-president-gallantly-1b509e6eb2eb@spud>
 <CALCWtBeJSFCUiYP47sb=XZObY_bQ=9jhh4i-5PNN4o1YbaQPqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mVSaFCbDOoas9kFX"
Content-Disposition: inline
In-Reply-To: <CALCWtBeJSFCUiYP47sb=XZObY_bQ=9jhh4i-5PNN4o1YbaQPqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mVSaFCbDOoas9kFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2023 at 11:28:43AM -0300, Estevam Moreira wrote:
> Remove me.
> I don't know what It is.

It is a typo! Someone meant to CC "festevam@gmail.com" and omitted the
f.
Peng Fan, please be more careful - your anatop series also CCed
"inux-clk@vger.kernel.org".

--mVSaFCbDOoas9kFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTE/pQAKCRB4tDGHoIJi
0lD0APwLAu/qACpfqHRbwYhtChARR2o7iLel8r4jOu/zYQmtXAEA/W+37kHDienb
GnhVsOFjoF5jKGejAJDnLk6ddzQNbA4=
=Sbqx
-----END PGP SIGNATURE-----

--mVSaFCbDOoas9kFX--
