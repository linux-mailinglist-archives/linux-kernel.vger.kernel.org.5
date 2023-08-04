Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478607704E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjHDPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjHDPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F2AC;
        Fri,  4 Aug 2023 08:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFAAF62083;
        Fri,  4 Aug 2023 15:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D5C433C7;
        Fri,  4 Aug 2023 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163358;
        bh=cQbVZMK/+oE/3CK/u6/7Zqr0SXiVGxH3ROY1UV0fNX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8moY05okVRv86wuUbFDhMkLLt15SDi8maNVhLU4Ol14LWWPW3EMrOFiMVag7d8I4
         IsZb9iBlZ29WLWmyJVYLmhJsuvquDaUzKGGAmWgPJGX9I+9ubwM83dDCoj4rSXfAU+
         AQUxD4YP9NWNJbx/vOUQaDjCbMTzguV59oBKSosyAqOYJpTExQGI1ytda5prxdVYQF
         BTKAQZmzQyqGYqHrpbbHXViEW/SS3HFOE9VpBMTPPyeakOA+64czmVdN6F3VT1K73K
         blJ3Vlg89ewIN/g6k8NPB0yGJ43aNjPB+SuJLS+SV/AyvsWUMCLG/0hVQN2KLINlpP
         8A4hY/KB/1sfA==
Date:   Fri, 4 Aug 2023 16:35:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: net: Add ICSS IEP
Message-ID: <20230804-uncombed-escalate-d46b38ce37a2@spud>
References: <20230803110153.3309577-1-danishanwar@ti.com>
 <20230803110153.3309577-2-danishanwar@ti.com>
 <20230803-guacamole-buddy-d8179f11615e@spud>
 <d3d53a4f-a1f8-09d4-77e8-a881829fac68@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3mKgAWLJHpCzOPKl"
Content-Disposition: inline
In-Reply-To: <d3d53a4f-a1f8-09d4-77e8-a881829fac68@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3mKgAWLJHpCzOPKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 11:56:19AM +0530, Md Danish Anwar wrote:
> Hi Conor,
>=20
> On 03/08/23 8:57 pm, Conor Dooley wrote:
> > On Thu, Aug 03, 2023 at 04:31:50PM +0530, MD Danish Anwar wrote:
> >> From: Md Danish Anwar <danishanwar@ti.com>
> >>
> >> Add DT binding documentation for ICSS IEP module.
> >>
> >> Signed-off-by: Md Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
> >>  1 file changed, 37 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.=
yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/=
Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> >> new file mode 100644
> >> index 000000000000..79cd72b330a6
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> >> @@ -0,0 +1,37 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) mo=
dule
> >> +
> >> +maintainers:
> >> +  - Md Danish Anwar <danishanwar@ti.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,am654-icss-iep   # for K3 AM65x, J721E and AM64x SoCs
> >=20
> > No. ti,am654-icss-iep is for am654. You should really have compatibles
> > specific to the SoC - is there a reason why this has not been done?
> >=20
>=20
> Yes, ti,am654-icss-iep is for am654. You are right, the compatibles shoul=
d be
> specific to SoC. Currently the upstream support is being added for only A=
M65x.
>=20
> I will remove J721E and AM64x SoCs from the comment above and these compa=
tibles
> when their support is enabled in future.

So the comment was totally wrong? Or does the same code work for all 3
of these SoC types & you used the same compatible on each of the 3?

Thanks,
Conor.


> Below is the updated compatible property.
>=20
> properties:
>   compatible:
>     enum:
>       - ti,am654-icss-iep   # for K3 AM65x SoCs

--3mKgAWLJHpCzOPKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0a1wAKCRB4tDGHoIJi
0kZLAQDt0yOMq+c+G7AcANr7kuJDAC5wZyoKewJmytYeOKITywEAxxaoRDlceLUD
irO27APk1pQvWbA9qMb6vB02LrMZ/go=
=seKc
-----END PGP SIGNATURE-----

--3mKgAWLJHpCzOPKl--
