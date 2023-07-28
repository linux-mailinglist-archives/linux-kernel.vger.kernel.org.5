Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8967664CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjG1HGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjG1HG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:06:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37729268B;
        Fri, 28 Jul 2023 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690527985; x=1722063985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YV/HherCTDGw+ls4/jLdsAyaf6VBOQkF2Uf7NZiBfII=;
  b=WQP/BC+00hmQAj2QkA+0SPtlcQzErmCG+jmPXpM85yNL+EV2X5HCfxj5
   /8a5pUG+ptFu1wjDXUDaHX8L7GnIIV+AaXtjrRAszlhLGB9JuE5MgSpko
   KczGV19hrJw8S4lWB2Qgy31qRuRwxB/9HcFa/Ipq1XZmzmJtMSaCFXYS3
   Ic8fSTipn3JkMqS+lYXTl6DxA7iGglZvDroDGUjZBaBMd0bGEVuz06mPp
   gcZ8QliWvrJcn5hDhR161SX1GHL6eigx4IRCv7RZ2lJdEX9y2nWyOsHb1
   BGXEzFZDr3rpTE1nP63G0qGMrAp5pmK/QvujsLc/j/Y8pcgWfGMN6DGhB
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="asc'?scan'208";a="227027311"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 00:06:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 00:06:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 00:06:20 -0700
Date:   Fri, 28 Jul 2023 08:05:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Eric Lin <eric.lin@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong.li@sifive.com>, <greentime.hu@sifive.com>,
        <vincent.chen@sifive.com>, Nick Hu <nick.hu@sifive.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230728-facedown-husked-9813fa79d9a0@wendy>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
 <20230720-slept-guru-216e2803061e@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CLBf1mcbqLUt7ULL"
Content-Disposition: inline
In-Reply-To: <20230720-slept-guru-216e2803061e@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CLBf1mcbqLUt7ULL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 06:10:51PM +0100, Conor Dooley wrote:
> Hey Eric,
>=20
> On Thu, Jul 20, 2023 at 09:51:19PM +0800, Eric Lin wrote:
> > This add YAML DT binding documentation for SiFive Private L2
> > cache controller
> >=20
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  .../bindings/cache/sifive,pl2cache.yaml       | 62 +++++++++++++++++++
>=20
> btw, your $subject should be "dt-bindings: cache: ...." rather than
> "riscv: sifive".
>=20
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2c=
ache.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/cache/sifive,pl2cache.ya=
ml b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> > new file mode 100644
> > index 000000000000..ee8356c5eeee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2023 SiFive, Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive Private L2 Cache Controller
> > +
> > +maintainers:
> > +  - Greentime Hu  <greentime.hu@sifive.com>
> > +  - Eric Lin  <eric.lin@sifive.com>
>=20
> There's extra spaces in these lines for some reason.
>=20
> > +
> > +description:
> > +  The SiFive Private L2 Cache Controller is per core and
> > +  communicates with both the upstream L1 caches and
> > +  downstream L3 cache or memory, enabling a high-performance
> > +  cache subsystem.
> > +
> > +allOf:
> > +  - $ref: /schemas/cache-controller.yaml#
> > +
>=20
> I'm pretty sure that I pointed out last time around that you need to add
> something like in the ccache driver:
>=20
> select:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - sifive,ccache0
>           - sifive,fu540-c000-ccache
>           - sifive,fu740-c000-ccache
>=20
> otherwise this binding will be used for anything containing "cache" in
> the dt-binding.
> For this binding, I think that the following is sufficient:
>=20
> select:
>   properties:
>     compatible:
>       contains:
>           const: sifive,pl2cache1
>=20
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,pl2cache1
> > +      - const: cache
>=20
> You omitted the pl2cache0 from here, that needs to come back! You'll end
> up with 2 items entries.
> Either way, I can't take this binding without a soc-specific compatible,
> per sifive-blocks-ip-versioning.txt..

Further, "sifive,perfmon-counters" is an undocumented property.

Thanks,
Conor.

--CLBf1mcbqLUt7ULL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMNoygAKCRB4tDGHoIJi
0t7lAP4l8gcLhmzGLDZoKSuera2y1ijqtLLcIiiMvpnoAU9Z6gEA3sHmaOCWY5wC
Dp6THGXUlDytdskVE4dXvgAel5laawk=
=Bv67
-----END PGP SIGNATURE-----

--CLBf1mcbqLUt7ULL--
