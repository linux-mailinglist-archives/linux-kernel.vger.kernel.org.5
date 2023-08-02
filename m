Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8D76CBE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjHBLki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHBLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:40:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AD413E;
        Wed,  2 Aug 2023 04:40:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372BeQQA054554;
        Wed, 2 Aug 2023 06:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690976426;
        bh=MRkc0kA9D0X9GcnGaHhXoOG07XC+S5YO6/kh08XlTEw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tlO6fSGLwoEdZ+gDU+XH2m0wICXpRsmtT9veCOnJyqaL7n86mkUG1ETd/C0CoNZJO
         bAb3SDhWLTtqlmHhYZHUyv6Dpz7SowEFI3+4CCpEWrLAskMHRLVblJ33wlA3kRgDEJ
         5nQtdJwwEaf7M9ooJ0L2hn+VRcGsx1ai2eag5yTc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372BeQkQ008531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 06:40:26 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 06:40:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 06:40:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372BePgV120226;
        Wed, 2 Aug 2023 06:40:25 -0500
Date:   Wed, 2 Aug 2023 17:10:29 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Devarsh Thakkar <devarsht@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
Message-ID: <52pbbqnp46h33gymoydnjtxoo3dsb6wnytvjnmomtjdtwck536@ewhb2rngomr2>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-4-8bd137ffa8f1@ti.com>
 <aa8d2aa6-a121-51e6-77de-0e1c8bdac043@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3zg2pdfn37jmidw"
Content-Disposition: inline
In-Reply-To: <aa8d2aa6-a121-51e6-77de-0e1c8bdac043@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c3zg2pdfn37jmidw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Devarsh,

On Aug 02, 2023 at 16:15:12 +0530, Devarsh Thakkar wrote:
> Hi Jai,
>=20
> Thanks for the patch.
>=20
> On 31/07/23 18:14, Jai Luthra wrote:
> > Add nodes for audio codec and sound card, enable the audio serializer
> > (McASP1) under use and update pinmux.
> >=20
> > Link: https://www.ti.com/lit/zip/sprr459
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++=
++++++++
> >  1 file changed, 77 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/=
dts/ti/k3-am62a7-sk.dts
> > index 752c2f640f63..5f68d2eefe0f 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > @@ -125,6 +125,41 @@ led-0 {
> >  			default-state =3D "off";
> >  		};
> >  	};
> > +
> > +	tlv320_mclk: clk-0 {
> > +		#clock-cells =3D <0>;
> > +		compatible =3D "fixed-clock";
> > +		clock-frequency =3D <12288000>;
> > +	};
> > +
> > +	codec_audio: sound {
> > +		compatible =3D "simple-audio-card";
> > +		simple-audio-card,name =3D "AM62Ax-SKEVM";
>=20
> In my opinion better to give the codec name instead of board name here.

I agree, maybe calling it "sk-am62a-tlv320aic3106" would be the most=20
clear option.

Running a quick ripgrep on next tree:

$ rg "simple-audio-card,name" arch/*/boot/dts/

I see a healthy mix of using both board and/or codec name here - with TI=20
almost always using the board name. Maybe we can change the convention,=20
but it would be a good idea to at least update SK-AM62 as well to use=20
the new convention.

Is it okay with you if it is handled as a separate series?

>=20
> Regards
> Devarsh

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--c3zg2pdfn37jmidw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTKQKwACgkQQ96R+SSa
cUUKxQ//ROhdIrrNS1eNNN8J+ubZ5lvP4jdzjeVCBvRNcS3ni/zunXODRYoL7wC5
5Xip+GeTh0Cv20rCGPmrhD2PGCY9aPZClOPNNd0ESErjQ3G52hofMMyedchxNeCe
pb74/qvTLo6ReDCLWnXLioP3fxV4yI/xyNImeJv+2oph7gA2khIdqUN8Lb9lO6fK
SpZWeBRtNKfFoWiy5SCZk3TfIlNcTIPm+wYor6rdRi3wMlCThw9Bt2jkkAWOSVaU
8WIdzDWnOP2D0x3B8fObEx0mMbrjvmOTIJayGzTF4j9570XkiHcBQVlg4f+7Ea5n
teeGPlw6bnjztajdB8Why8B4yRrTdECLqqfBHCKXdRLxZ57LJIVXqYB391NBdYBk
c6KZ8diGO8dwwzvloWt6lVsk8HBiS/JTqQYWlbmoHTAUosYYpGZOQc6qzechBxgq
nfgErxG6x4Y9SM0tW/Ao8rYO0BiLEXaF6xE+f+B6rnmX4ClJ/PoTMxyXuqe8uMjZ
YevgHIzmeOvR81B8tyR2pWJQiQ8oDKhAU/yVXbn+XO3fU3McmOzdT35AKKhf1kRO
Fq5iaoRo5Uaa1uwAuucxQXtINppo8OpNiKUrf8GWwlvcAkM2IE3LBrm4k+B7Nhg+
HR3B8mluTQuEq5IWEaTe2Zmfp+lH8V0F+ZW7LCqXuufdLrMAeA4=
=YBBX
-----END PGP SIGNATURE-----

--c3zg2pdfn37jmidw--
