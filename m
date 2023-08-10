Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65FB7778D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjHJMx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjHJMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:53:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748026A8;
        Thu, 10 Aug 2023 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691672006; x=1723208006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJ+/b00F9kPexO4v/gdgxth24IwvwYtglje3VG8O1nU=;
  b=ycsRBXovdMOTzEo334IVqLnJ9Z9f8t9kPKsD0boEGnm2ZeihMr1y9OaX
   381MolbPiH8q3S8xZh7pNzuVwVaFziSjWmUH0G5FQJALXiSg+GJLfi+wN
   3kIJSiV7Aob5uh0nfJyiOkSX1p9TMR0XgBuWhrdXgCY/vGn32NLNWz6jE
   4WnjEXNhtrUr8dNuCBb+2lE8yS6NC0LVBEwVT27DpJylmzYEfGtH/nyyN
   3vU/8Im9KxY8P12CQxWxAlD7N6oFtNP1TuOHh9swcB1ATgnMOZii8PQYE
   5pnL99tvYIFpNEZ/ZwkiByUqdZo/3VJBqbwk4VMK9FvDAtQHN72I6gRj5
   w==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="asc'?scan'208";a="229166856"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 05:53:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 05:52:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 10 Aug 2023 05:52:49 -0700
Date:   Thu, 10 Aug 2023 13:52:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Md Danish Anwar <a0501179@ti.com>
CC:     Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
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
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/5] dt-bindings: net: Add ICSS IEP
Message-ID: <20230810-drippy-draw-8e8a63164e46@wendy>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-2-danishanwar@ti.com>
 <20230809-cardboard-falsify-6cc9c09d8577@spud>
 <0b619ec5-9a86-a449-e8db-b12cca115b93@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="diS/Ua0hOZdswhas"
Content-Disposition: inline
In-Reply-To: <0b619ec5-9a86-a449-e8db-b12cca115b93@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--diS/Ua0hOZdswhas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 03:23:11PM +0530, Md Danish Anwar wrote:
> On 10/08/23 3:07 am, Conor Dooley wrote:
> > On Wed, Aug 09, 2023 at 05:19:02PM +0530, MD Danish Anwar wrote:
> >> Add DT binding documentation for ICSS IEP module.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
> >>  1 file changed, 37 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.=
yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/=
Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> >> new file mode 100644
> >> index 000000000000..adae240cfd53
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
> >=20
> > Does the module here refer to the hw component or to the linux kernel
> > module?
> >=20
>=20
> The module here refers to the hardware component.

Sweet, thanks.

> >> +
> >> +maintainers:
> >> +  - Md Danish Anwar <danishanwar@ti.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,am654-icss-iep   # for all TI K3 SoCs
> >=20
> > *sigh* Please at least give me a chance to reply to the conversation on
> > the previous versions of the series before sending more, that's the
> > second time with this series :/
>=20
> My bad, I should have waited for your response. I will hold on posting ne=
xt
> version until your response is received.
>=20
> > Right now this looks worse to me than what we started with given the
> > comment is even broader. I have not changed my mind re: what I said on
> > the previous version.
> >=20
>=20
> OK, so in the previous version [1] your reply was to have specific compat=
ibles
> as bindings with "ti-am654-icss-iep" as a fall back. I will go with this =
only.
>=20
> Does the below looks good to you? Here "ti,am642-icss-iep" and
> "ti,j721e-icss-iep" are different compatibles for different SoCs where as
> "ti,am654-icss-iep" is the fall back. Compatible "ti,am654-icss-iep" will=
 go in
> the driver.
>=20
> properties:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - ti,am642-icss-iep
>               - ti,j721e-icss-iep
>           - const: ti,am654-icss-iep
>=20
>       - items:
>           - const: ti,am654-icss-iep

This one doesn't need to be an items list, since there is only one item.
It should be able to just be const:. I much prefer this approach.

Thanks,
Conor.

--diS/Ua0hOZdswhas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNTdewAKCRB4tDGHoIJi
0iMoAQCDOBl0Qa9rDfRGu4AnjpAIUepfbUnc63ThpYDzbWaJ+wD/e5Y5S1Ae5ZBa
5xbzDkOAnzsbPwqtnhkcByShucEghg4=
=yxL7
-----END PGP SIGNATURE-----

--diS/Ua0hOZdswhas--
