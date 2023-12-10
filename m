Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B594480BB20
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjLJNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjLJNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:39:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA271ED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:39:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E1C433C7;
        Sun, 10 Dec 2023 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702215559;
        bh=fTm7ITxHWlDMbWerH/cRI+Ai9WLiPVmOtrotE0lLvnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVhomcV5xU0ZXA9qvXYGKxiMFdS6MgqOgBH8yVcI/wMrxQ7aUz//+rvpXYNlw07hm
         P9NAJs6tPMENLr+CI1h6JdOynsfnysMgdiZuu4zORGoSaM9iHLx7SdGP44mJ7+wb0T
         0q/uQgMO2k/WLbkNfC92nhuv51HjZk2N//+TkzuwPgTT6xWTQpv3m2pKHgdGjoaQa1
         xYVU9AEaFVTZLSmqS54YhEJMq6RR/MdtE2fc8b+wS7cX8/oYlgPeMB7rpn+kCOo/Db
         xXLcjoliKR7pQd8Zwzb8q3aJ2zPk3t3DmczpDmldyi1Ymw3r25d5XOUoKHO5cl7e7e
         mQf4jAAx+CFdA==
Date:   Sun, 10 Dec 2023 13:39:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Xu Yang <xu.yang_2@nxp.com>
Cc:     Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add
 i.MX95 compatible
Message-ID: <20231210-scrap-backdrop-8bae1acc07fd@spud>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
 <20231208-depress-smuggler-f3069487a067@spud>
 <DB7PR04MB51468DB108F3003AF52CDDDA8C88A@DB7PR04MB5146.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Y73PFULRu5w7Pr1"
Content-Disposition: inline
In-Reply-To: <DB7PR04MB51468DB108F3003AF52CDDDA8C88A@DB7PR04MB5146.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Y73PFULRu5w7Pr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 04:27:16AM +0000, Xu Yang wrote:
> Hi Conor,
>=20
> > On Fri, Dec 08, 2023 at 04:53:59PM +0800, Xu Yang wrote:
> > > i.MX95 has a DDR pmu. This will add a compatible for it.
> >=20
> > On v1 we had a discussion because the commit message wasn't clear about
> > whether or not the device was compatible with existing ones. For some
> > reason, the v2 patch _removes_ information from the commit message
> > rather than tries to explain.
> > This [1] message of yours, that I didn't get a chance to reply to before
> > you sent this new version, seems to say that there should be an
> > imx93-ddr-pmu fallback.
>=20
> Thanks for your comments.=20
>=20
> Just read my previous comment in [1] and found I made a mistake.
> Now I'll try to clarify it here.
>=20
> Imx95 and imx93 have different AXI filter configuration. I need a=20
> compatible for imx95 since the driver cannot differentiate them.=20
>=20
> Then I need to consider below two options:
> 1. compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu"
> 2. compatible =3D "fsl,imx95-ddr-pmu"
>=20
> Both of them work correctly on imx95. When I make changes in
> driver for imx95, imx93 is not affected.
>=20
> For basic functions, imx95 is compatible with imx93. I select the 2rd
> form for simplicity. If the first form is optimal, I can change it in next
> version.

The first form is preferred, yes.

--6Y73PFULRu5w7Pr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXW/fAAKCRB4tDGHoIJi
0tsaAP48qhr4ANSJHCm2QzJHQ7OffzfDNhkrzRw0fj/ODk7Q2AD8CjVcf8ACaciH
Z9eIvtEKnMZ8bKAW+0NtJBxGnoeK+wQ=
=zAEX
-----END PGP SIGNATURE-----

--6Y73PFULRu5w7Pr1--
