Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13A476C760
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHBHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjHBHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:47:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA74201;
        Wed,  2 Aug 2023 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690962287; x=1722498287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2szau/+aok62TKXNIGTEyyDGMJzaRmIjwYE4GSf6VkE=;
  b=k3qUberxhzxTnE1hKlltBJ8v3lNf130epX2s2nE+sopKkSXfcbBWiNWl
   My8ApH7Obj2HFhBud/mBigPpCYs29xW/nIJ6XVNsxpMKfYrSU8bIRHZN4
   iD7aUsXExsfcomsYyIO6eW1Tsv3zSDMSbG+dErngu7oWGQxQ1FR8TmWy8
   uwK/aJOgouY6uFO72BwFDTkSnk7Mtf7axW4I/c139joEIzcUZD1NXsP3K
   fccAmsZQvvmWGVUQM446L+4VdiTtvHL0jhhS1rxr3zuuldB+UxxkfLZXJ
   RAa2dzNEj2NxB0dUiCChatAPDSVyeIEkK7DV9Pi1g1RFtK0VuqdffSEXH
   A==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="227771449"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 00:44:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 00:44:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 00:44:35 -0700
Date:   Wed, 2 Aug 2023 08:43:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Carsten =?iso-8859-1?Q?Spie=DF?= <mail@carsten-spiess.de>
CC:     Conor Dooley <conor@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <20230802-sandbar-crudely-78a4b8a351b0@wendy>
References: <20230801163546.3170-1-mail@carsten-spiess.de>
 <20230801163546.3170-3-mail@carsten-spiess.de>
 <20230801-implicate-mullets-bd160bbda4b2@spud>
 <20230802093023.1a926c9f.mail@carsten-spiess.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rvwxYB0l/gGvqvqZ"
Content-Disposition: inline
In-Reply-To: <20230802093023.1a926c9f.mail@carsten-spiess.de>
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

--rvwxYB0l/gGvqvqZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 09:30:23AM +0200, Carsten Spie=DF wrote:
>=20
> On 8/1/23 22:52, Conor Dooley wrote:
> > On Tue, Aug 01, 2023 at 06:35:46PM +0200, Carsten Spie=DF wrote:
> > > Add dt-bindings for Renesas ISL28022 power monitor.
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - renesas,isl28022 =20
> >=20
> > You've only got one compatible, why the enum? Will there be more similar
> > devices that have an incompatible programming model?
> Yes, there are isl28023 and isl28025 with different register addresses,
> might be supported in future releases.

Right. Unless that's a very strong "might", const: will do the trick
here just fine.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> > > +  renesas,shunt-range-microvolt:
> > > +    description: | =20
> >=20
> > You don't need these |s if you have no formatting to preserve in the
> > text.
> Will fix in v4.

There's no need to send a v4 for that alone.

--rvwxYB0l/gGvqvqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMoJMwAKCRB4tDGHoIJi
0tMPAQDjQ697+EDhnCuyxLgCr9usLC3Co7rI5JVp14gTVjUuZgEAvAae+pGt9k8D
JU5YHsjUkBO+KWZi/AFxYKh1cmMOmwE=
=s4Ye
-----END PGP SIGNATURE-----

--rvwxYB0l/gGvqvqZ--
