Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE179DFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjIMGVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjIMGVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:21:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF81731;
        Tue, 12 Sep 2023 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694586107; x=1726122107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yQ/j7D4OXBoW16GrBTc/hnFxI50i0+gh0HACschoKSA=;
  b=QeTYj2tcWVEZYAeLhhDR7v0AjMYpnUtJc3U2BmA9myuBLewR+YmkXQlp
   DObJ2QJlgGshGy8rbDdadXz8/fF5TSlJdvViyc0QtzowwFzDibVrKihLZ
   YQNFuAv00sbJuWkj89rcjWkgXoQWAL7wGGpKd/Z28DGEWWZuVnFQdGuB7
   aoZitgL0uhMfzWc2htqlqfSADEDe9K856W8npGJV6qAoGvyU4AB0XzWJV
   hm4cUhNs3TAGHRzawBLGT8IVMYjhRmAg/9MxfceFeac6sY3R+9qEcKcYn
   VrhQCkkcFNFxtWOMjK8HpIpSUJQFmfSrzFogksO9YXjDgraOusQB60FE1
   A==;
X-CSE-ConnectionGUID: 7XmvrzgjQjiO7en38VZV5Q==
X-CSE-MsgGUID: Lz0HCdHbTEyKqaPCKhfWKw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="asc'?scan'208";a="234927951"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 23:21:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 23:21:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 23:21:10 -0700
Date:   Wed, 13 Sep 2023 07:20:54 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [-next v2 1/2] riscv: dts: starfive: visionfive 2: Enable usb0
Message-ID: <20230913-mockup-liable-9dcf94ed4568@wendy>
References: <20230829020511.26844-1-hal.feng@starfivetech.com>
 <c417d55d-d886-f66d-15a9-73b297d28d59@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6s20so3aHOodvuXr"
Content-Disposition: inline
In-Reply-To: <c417d55d-d886-f66d-15a9-73b297d28d59@starfivetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6s20so3aHOodvuXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:47:22AM +0800, Hal Feng wrote:
> On Tue, 29 Aug 2023 10:05:10 +0800, Hal Feng wrote:
> > usb0 was disabled by mistake when merging, so enable it.
> >=20
> > Fixes: e7c304c0346d ("riscv: dts: starfive: jh7110: add the node and pi=
ns configuration for tdm")
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.=
dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > index d79f94432b27..85f40df93f25 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > @@ -513,6 +513,7 @@ &uart0 {
> > =20
> >  &usb0 {
> >  	dr_mode =3D "peripheral";
> > +	status =3D "okay";
> >  };
>=20
> Hi, Conor,
>=20
> As v6.6-rc1 is already released, would you apply this series
> in rc2 or the later rc versions?

Yes, I was planning on doing a sweep for potential fixes today. There's
3 or 4 I think.

--6s20so3aHOodvuXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQFUuAAKCRB4tDGHoIJi
0nRsAQCTaqgoWUbeumzMTXR5EzAQXSylZNGF84sjQsGXntCqYgD9ErLrcWMRsBL/
Ez8Q3a7Spg2MhCfTWPzCpJX74CDvhAs=
=+OgF
-----END PGP SIGNATURE-----

--6s20so3aHOodvuXr--
