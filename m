Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D180111E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378704AbjLAQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjLAQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:17:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F3170E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:17:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DCC433C7;
        Fri,  1 Dec 2023 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701447426;
        bh=1clXQHaKlN3+Iey4fwvTDjGR7w5qW4bBovJgyAH6bm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXOtzgxTZmqTX7UMTBKAELYx0R+uGIzx1B+2m8VO3+dC+h/phPJnHkvjZuHzYjrs0
         RA1ZG6+t7FLbFSgM648hNOOH313ZOvtkCkQoF2AsQBBwfYIasV3QECsUNrUaFgkBda
         ov6QgW4jCFO9P4m0vdcvg3eRPbrMkYTiSpp/xM6xH30feYpk4OneCB3d1eBJ2wUP4u
         nk5w3gjQ07fJriufkNUvdTnAh1WLcv9FAcR7HdRLuHhngaFOwTrFMycJ2M1IYAaRKb
         PXAKJ0dHhe011leboXXazfoD1N9l/EitARVA4/qPWNwkr9PESF4uUa60Qr0zIwdDvQ
         oBHkyZWd/C/Bw==
Date:   Fri, 1 Dec 2023 16:16:59 +0000
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
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Message-ID: <20231201-pointer-statue-f30a42b8102e@spud>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
 <20231127-whoever-magical-5a7cf2b142e1@spud>
 <DB7PR04MB51460A715C6870642B6D7BBE8C81A@DB7PR04MB5146.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TkOZ/60oHOjywoPV"
Content-Disposition: inline
In-Reply-To: <DB7PR04MB51460A715C6870642B6D7BBE8C81A@DB7PR04MB5146.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TkOZ/60oHOjywoPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 06:41:59AM +0000, Xu Yang wrote:
> Hi Conor,
>=20
> >=20
> > On Mon, Nov 27, 2023 at 03:32:06PM +0800, Xu Yang wrote:
> > > i.MX95 has a more precise counting capability than i.MX93. This will =
add
> > > a compatible for it.
> >=20
> > It is hard to tell from this comment, but I figure this "more precise
> > capability" is not an option you can enable, but instead makes the
> > programming model of this device different to that of the imx93?
>=20
> Actually, imx95 is compatible with imx93 except AXI ID filter capability.
> But for AXI ID filter, imx95 is using different registers and bits from
> imx93 for filter configuration.

This sounds like it conflicts with...

> To distinguish them, I need use different
> compatible because programming model cannot recognize which device is
> running.
>=20
> compatible =3D "fsl,imx95-ddr-pmu";

> compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu";

=2E..this. If drivers for the imx93 need changes to work on the imx95,
then `compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu";` cannot be
used. If they will work, with only the new imx95 features being
non-functional, then you can use it.

> Both above compatible is okay for me. Therefore, "fsl,imx95-ddr-pmu" is n=
eeded.

--TkOZ/60oHOjywoPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWoG+wAKCRB4tDGHoIJi
0vEhAP4wzNFvpXcJTLzerrD4dUi4x/ljKAP60wZOIvaUeVfIggEAmh++tRu2JE6H
W9PxEUNaXYdEI2l4eUhUFMLEGSaNvws=
=61zC
-----END PGP SIGNATURE-----

--TkOZ/60oHOjywoPV--
