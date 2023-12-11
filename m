Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E44480CA53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjLKM7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:59:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B7BC;
        Mon, 11 Dec 2023 04:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702299593; x=1733835593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g3G2RjYO0ZjlRfzDDIT4lRzkMZXiLvsGqGWVUJ3J/Cc=;
  b=cO9lf9OcVJvOVTuvrmBro+oOlEYXKOpYsUSv4tjCUSiIhhDuAx8aXIEp
   ty7nkqP83ZAQy527ht9Av8Q+8ikzY45M11Z3qsGlBLG8MMeJRx6w2rcmo
   Hzq9LGXcyTGwqhBvBqfpbFKQbAqwm2rWuJyGdsPXznZPI5+sZnNNVGwHq
   3n9jQHFkHmPm1p9oqZWFCF7ZytMDwSpJS5gA27QYjVTSSgKCY0vRNZRAm
   4pYW4ygQV7ra9MXVJTwqyWuzg9XVReerPkR25OkNjfa62Of+1XQokMPqD
   hqYYHaA5Fklie9HnuDk53vKbuReCxtv0/M8kxY3eaW+0b8RR781YYXW96
   g==;
X-CSE-ConnectionGUID: I++IsSqqRAGP8tAFiKojJQ==
X-CSE-MsgGUID: 9jHPT5NsRe+wM6kqL6MW7A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="asc'?scan'208";a="180277566"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2023 05:59:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 05:59:42 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Dec 2023 05:59:40 -0700
Date:   Mon, 11 Dec 2023 12:59:09 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <mparab@cadence.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/5] dt-bindings: phy: cadence-torrent: Add second
 optional input reference clock
Message-ID: <20231211-saucy-carnation-bce003ea09dd@wendy>
References: <20230724150002.5645-1-sjakhade@cadence.com>
 <20230724150002.5645-2-sjakhade@cadence.com>
 <20230724-unhappily-promptly-b25c7e42504d@spud>
 <13c7fa70-ec60-44a7-aba7-5c4b0e21a755@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IlaqcbunL1B3LURy"
Content-Disposition: inline
In-Reply-To: <13c7fa70-ec60-44a7-aba7-5c4b0e21a755@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IlaqcbunL1B3LURy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 02:45:48PM +0200, Roger Quadros wrote:
> Hi Conor,
>=20
> On 24/07/2023 20:53, Conor Dooley wrote:
> > On Mon, Jul 24, 2023 at 04:59:58PM +0200, Swapnil Jakhade wrote:
> >> Torrent(SD0801) PHY supports two input reference clocks. Update bindin=
gs
> >> to support dual reference clock multilink configurations.
> >>
> >> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> >> ---
> >>  .../bindings/phy/phy-cadence-torrent.yaml     | 23 +++++++++++++------
> >>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent=
=2Eyaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >> index dfb31314face..ddb86ee0cebf 100644
> >> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >> @@ -33,16 +33,25 @@ properties:
> >> =20
> >>    clocks:
> >>      minItems: 1
> >> -    maxItems: 2
> >> +    maxItems: 3
> >>      description:
> >> -      PHY reference clock for 1 item. Must contain an entry in clock-=
names.
> >> -      Optional Parent to enable output reference clock.
> >> +      PHY input reference clocks (refclk & refclk1).
> >=20
> > "refclk" and "refclk1" don't seem like great names. What is each one
> > used for & should refclk1 be renamed to match its use case?
>=20
> All PHYs need one refclk input. "refclk"
> Some PHY variants can take a second refclk input. Both are refclks so it =
was
> chosen to add an "1" to the name to the 2nd refclk.
> Please suggest if you have a better idea. Thanks!

The existing second clock name (phy_en_refclk) might serve as
inspiration. What is the additional role that the second reference
serves?

>=20
> >=20
> >> +      Optional Parent to enable output reference clock (phy_en_refclk=
).
> >> =20
> >>    clock-names:
> >> -    minItems: 1
> >> -    items:
> >> -      - const: refclk
> >> -      - const: phy_en_refclk
> >> +    oneOf:
> >> +      - items:
> >> +          - const: refclk
> >> +      - items:
> >> +          - const: refclk
> >> +          - const: phy_en_refclk
> >> +      - items:
> >> +          - const: refclk
> >> +          - const: refclk1
> >> +      - items:
> >> +          - const: refclk
> >> +          - const: refclk1
> >> +          - const: phy_en_refclk
> >> =20
> >>    reg:
> >>      minItems: 1
> >> --=20
> >> 2.34.1
> >>
>=20
> --=20
> cheers,
> -roger

--IlaqcbunL1B3LURy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXcHnQAKCRB4tDGHoIJi
0iiLAP433STH5ISjhoWeEvnlPNZvyHIkdzUN0tRTv2EvEefOwAEAkRo0tQ3o2xKr
DbRxACn03R8h2CpkW6ACjDgeNcIHAwY=
=F6Bi
-----END PGP SIGNATURE-----

--IlaqcbunL1B3LURy--
