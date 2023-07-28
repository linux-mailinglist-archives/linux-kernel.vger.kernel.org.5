Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6492876646E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjG1Grd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjG1GrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:47:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A773AA8;
        Thu, 27 Jul 2023 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690526837; x=1722062837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtvQho51fiUQiVv7pUWMWChlYR1zLZ8AT/WHvdmM9Ww=;
  b=BQJR08sEg2G448F9BOcQezoCgr3+gNHLc2lf4FPWNQkmuSdpYuMi2ut0
   XfoKiF7cBdDG5YJMeutUcifjxIdqEk7KJQROUQFEx65FicTbFAB68JqrP
   N432SUsallebmQmNyAr++jVZpyLd1drp+gnIJ9QOnhnPaxEE1kDmEMOIJ
   uPjBFPGOhBIJi3Pk4wLPu/tCIDJozY54PkqOHZ1kr3LFIA4bA6uA0vqLb
   GuwPcDcRoT04weAOL/sah2C5Bx8tm5WQjyv/b8n/S/efrE+BP1vvHLx36
   UICPJLWhq+c8pEizjt4zo9Trutd3NE9mVnRDoIz25pyb0o4+jEYl5fVyA
   w==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="asc'?scan'208";a="227024283"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2023 23:47:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Jul 2023 23:47:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Jul 2023 23:47:11 -0700
Date:   Fri, 28 Jul 2023 07:46:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Eric Lin <eric.lin@sifive.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong.li@sifive.com>, <greentime.hu@sifive.com>,
        <vincent.chen@sifive.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230728-penpal-prelude-29a952c03827@wendy>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
 <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org>
 <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DkvLLUDHEo/ixRke"
Content-Disposition: inline
In-Reply-To: <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
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

--DkvLLUDHEo/ixRke
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 02:01:28PM +0800, Eric Lin wrote:
> Hi Krzysztof,
>=20
> On Fri, Jul 21, 2023 at 4:35=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 20/07/2023 15:51, Eric Lin wrote:
> > > This add YAML DT binding documentation for SiFive Private L2
> > > cache controller
> > >
> > > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > > Reviewed-by: Zong Li <zong.li@sifive.com>
> > > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> >
> >
> > ...
> >
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: sifive,pl2cache1
> >
> > I still have doubts that it is not used in any SoC. This is what you
> > said last time: "is not part of any SoC."
> > If not part of any SoC, then where is it? Why are you adding it to the
> > kernel?
> >
>=20
> Sorry for the late reply. I didn't describe it clearly last time.
> Currently, we have two hardware versions of pl2cache: pl2cache0 and pl2ca=
che1.
> The pl2cache0 is used in unmatched board SoC.

Wait a second, does the fu740 on the unmatched not have a ccache as
it's L2 cache?

> The pl2cache1 is
> utilized in our internal FPGA platform for evaluation; it's our core
> IP.

--DkvLLUDHEo/ixRke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMNkSQAKCRB4tDGHoIJi
0n12AP4h2vY+IY4Xw3D7EqF9UHWzxcPq70z+ADbj7pY81bxvgAD/eTAguxDbLB8q
4QcYSxEmzDs/Mr2qOF0gN0xCG6+3KwQ=
=Vu0G
-----END PGP SIGNATURE-----

--DkvLLUDHEo/ixRke--
