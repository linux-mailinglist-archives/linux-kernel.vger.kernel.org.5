Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92C7B6313
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjJCICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJCICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:02:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1412AA9;
        Tue,  3 Oct 2023 01:02:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39382UnV010136;
        Tue, 3 Oct 2023 03:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696320150;
        bh=gVMDmNcDdk5Xjzv4wzSLdgAeNMqZ5fMGaXgl5cQg44M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mm+FxZfpZQpBNiHmrqZlCFphntnOlN6X3pdnvQUPXZKEbmVpcor7E/ifdgZDdqvID
         R/fOBXR8KMZtQwiyaELohrlZmqeCdmC0bQpKtkAJkJEo0phMSzW+/HPFs4MxbOfiic
         I07ryWHnyRO15bDpK5q8r5hNmSbS8Ca33M7dRo/k=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39382Utk120065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 03:02:30 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:02:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:02:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39382Suv101819;
        Tue, 3 Oct 2023 03:02:29 -0500
Date:   Tue, 3 Oct 2023 13:32:26 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
Message-ID: <tstb2fxrio26yhu4cbeblq6rpo7hsqfa3ydrz54lmk2gbbegnl@qsvfevchllkd>
References: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
 <20230928-mcasp_am62a-v2-3-ce9f0e1ba22b@ti.com>
 <1ad3087c-c9aa-9a67-46c7-4969c97041d8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uvdysceesknkyl3p"
Content-Disposition: inline
In-Reply-To: <1ad3087c-c9aa-9a67-46c7-4969c97041d8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--uvdysceesknkyl3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aradhya,

On Oct 03, 2023 at 10:54:12 +0530, Aradhya Bhatia wrote:
>=20
>=20
> On 28-Sep-23 14:54, Jai Luthra wrote:
> > The TLV320AIC3106 audio codec is interfaced on the i2c-1 bus. With the
> > default rate of 400Khz the i2c register writes fail to sync:
> >=20
> > [   36.026387] tlv320aic3x 1-001b: Unable to sync registers 0x16-0x16. =
-110
> > [   38.101130] omap_i2c 20010000.i2c: controller timed out
> >=20
> > Dropping the rate to 100Khz fixes the issue.
> >=20
> > Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
>=20
> Since the codec wouldn't have worked with the 400KHz, the initial DT
> configuration is wrong, which makes this patch a fix, and should be
> indicated as such.

I am slightly confused, as the codec node was not enumerated before this=20
series, and i2c-1 configuration @ 400Khz works for the GPIO expanders=20
present.

My understanding is that a Fixes: tag would mean we backport this patch=20
to older releases, but that would not really be necessary here as=20
nothing was per se "broken" before this series.

Will discuss this offline with you and Vignesh and send a v3.

>=20
> With the Fixes tag added,
>=20
> Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
>=20
> Regards
> Aradhya
>=20
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/=
dts/ti/k3-am62a7-sk.dts
> > index c689d3da2def..866b2725f775 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > @@ -261,7 +261,7 @@ &main_i2c1 {
> >  	status =3D "okay";
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&main_i2c1_pins_default>;
> > -	clock-frequency =3D <400000>;
> > +	clock-frequency =3D <100000>;
> > =20
> >  	exp1: gpio@22 {
> >  		compatible =3D "ti,tca6424";
> >=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--uvdysceesknkyl3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmUbyo8ACgkQQ96R+SSa
cUUMmA/+N/E2rMFbxy2zfGYWL2ach8I1kkxOnoZBgLbw9TeSp9uyVrLA4JvM4ZYM
FSpxYw82Hze4O4X7xa7dV0b42y9HZF8brW7SwRSrdgAIPQFRpqjna+/gcxLz3UL6
mHiGLD44kpJYbFcV0nyQLgvy7x3x6g843LurprkRrgUgA/jOfiYKIsIB8HRH3oNY
tzpAVwlwn9qKDc5D2TcdTbstZgJdOcH2XtHoAEi91qxbpciUTObmPqYCyEHw2DBD
QV78vzIS/hdimwxFh7PXiCINRVKWpRvIV5ccCaeJ9rjiq/9A+JPhXFHFkYqB6SHk
Bt6z+W4bkuRJlhNXquEX1mPtWSbvHYd1MTBJrASoxZ36FRJn1xo7XXnp7PMyCWHG
mhNJByZ3CMiatYWL0aQWJgNneDL3haXZFYrJHoM1cheBob7dosnctC+u4vhSLY9N
kJcubku6F6KmVFP9U5EABh5LKsN/eIgb28K0HHi9Dq6WYdASfE0lQ6wJX2a9c9yF
iUH1M52+eArXdBiqbuqUzzq3S4lWe1qHufQc54Dd02STxyQbwojGy7pQ012PqpJ6
QdrU4ONAyHF1XpM1Z8rlTyyJ2nkpJN+XMKkiJeNCb+VYXvP/mFVuISxrOUb1Yx+1
wre0nsxlWIZmfRJJfQeOG4/fV98rZ1ZQ7Tl6YG+S0lpvrE+VT3w=
=MzXC
-----END PGP SIGNATURE-----

--uvdysceesknkyl3p--
