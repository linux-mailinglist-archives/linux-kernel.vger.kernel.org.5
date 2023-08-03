Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7176DFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHCFmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHCFm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:42:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D740E211E;
        Wed,  2 Aug 2023 22:42:26 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3735gHFo072789;
        Thu, 3 Aug 2023 00:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691041337;
        bh=JaVDkNh24zeaIa0PzyZdBDMiqrDv32R2mv8TvqwD37k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AcstJXErHHqyOY7BBcGwY3t0fKmOX8ioQdG+a0oBcps30HcGhDPYPUurkKRvRCcN+
         gNYY9C0V9GbH0U39gFu/5gNzXY7iteSAG9crUxatkNUSH1n/Buo31jAt/qiCL3m1SS
         rxJeyBuvFuiZZ/3t2cNPoWCWsrNXGByMy7/FJtvs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3735gH2x027381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 00:42:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 00:42:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 00:42:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3735gGVG029112;
        Thu, 3 Aug 2023 00:42:16 -0500
Date:   Thu, 3 Aug 2023 11:12:20 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Devarsh Thakkar <devarsht@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
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
Message-ID: <g42iwlnxoaocvjglehavfnnfnfxj2z5fhvdbsnefhr2nzl3peb@6b7omnsthzq3>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-4-8bd137ffa8f1@ti.com>
 <aa8d2aa6-a121-51e6-77de-0e1c8bdac043@ti.com>
 <52pbbqnp46h33gymoydnjtxoo3dsb6wnytvjnmomtjdtwck536@ewhb2rngomr2>
 <20230802133502.zjvf7sslmcuayg5z@defog>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="znyrgjgdrrbjtpu2"
Content-Disposition: inline
In-Reply-To: <20230802133502.zjvf7sslmcuayg5z@defog>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--znyrgjgdrrbjtpu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth, Devarsh,

On Aug 02, 2023 at 08:35:02 -0500, Nishanth Menon wrote:
> On 17:10-20230802, Jai Luthra wrote:
> > Hi Devarsh,
> >=20
> > On Aug 02, 2023 at 16:15:12 +0530, Devarsh Thakkar wrote:
> > > Hi Jai,
> > >=20
> > > Thanks for the patch.
> > >=20
> > > On 31/07/23 18:14, Jai Luthra wrote:
> > > > Add nodes for audio codec and sound card, enable the audio serializ=
er
> > > > (McASP1) under use and update pinmux.
> > > >=20
> > > > Link: https://www.ti.com/lit/zip/sprr459
> > > > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > > > Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > > ---
> > > >  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++=
++++++++++++
> > > >  1 file changed, 77 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/b=
oot/dts/ti/k3-am62a7-sk.dts
> > > > index 752c2f640f63..5f68d2eefe0f 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> > > > @@ -125,6 +125,41 @@ led-0 {
> > > >  			default-state =3D "off";
> > > >  		};
> > > >  	};
> > > > +
> > > > +	tlv320_mclk: clk-0 {
> > > > +		#clock-cells =3D <0>;
> > > > +		compatible =3D "fixed-clock";
> > > > +		clock-frequency =3D <12288000>;
> > > > +	};
> > > > +
> > > > +	codec_audio: sound {
> > > > +		compatible =3D "simple-audio-card";
> > > > +		simple-audio-card,name =3D "AM62Ax-SKEVM";
> > >=20
> > > In my opinion better to give the codec name instead of board name her=
e.
> >=20
> > I agree, maybe calling it "sk-am62a-tlv320aic3106" would be the most=20
> > clear option.
> >=20
> > Running a quick ripgrep on next tree:
> >=20
> > $ rg "simple-audio-card,name" arch/*/boot/dts/
> >=20
> > I see a healthy mix of using both board and/or codec name here - with T=
I=20
> > almost always using the board name. Maybe we can change the convention,=
=20
> > but it would be a good idea to at least update SK-AM62 as well to use=
=20
> > the new convention.
> >=20
> > Is it okay with you if it is handled as a separate series?
>=20
> Will this cleanup of existing board break any userspace? If so, NO and
> follow existing "board" convention - I'd like to maintain consistency,
> even if that is not exactly clean!

Upon further inspection, yes changing existing boards can break=20
userspace applications as some procfs entries are enumerated with the=20
name of the soundcard. So updating AM62x is out of the question.

I am in favor of maintaining naming consistency with this board.

Devarsh, I notice the current scheme is not entirely opaque, as the pcm=20
device enumerates both the cpu & codec driver names:

root@am62xx-evm:~# aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=3DAM62xSKEVM
    AM62x-SKEVM, davinci-mcasp.0-tlv320aic3x-hifi tlv320aic3x-hifi-0
    Default Audio Device
sysdefault:CARD=3DAM62xSKEVM
    AM62x-SKEVM, davinci-mcasp.0-tlv320aic3x-hifi tlv320aic3x-hifi-0
    Default Audio Device

> If not, cleanup in a later series is fine, but please make sure to=20
> follow through this week - with this patch following the convention of=20
> choice.
>=20

Please feel free to pull the current series, if no further comments.

> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--znyrgjgdrrbjtpu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTLPjkACgkQQ96R+SSa
cUW5VQ//YJnb0BqpzhvBlAwqL9bHfaAS0ztOySXJc0NdLxv3eNtfsFekteMPTJaU
gawhb23HqSJy7/J6+2/qrmbjgV1Guz5EAJOgwnm65Y3m1MnfC19xI2/KRPapr9Uq
clMDqr4ztsR8TPpv0+4uyqVotBPaRGMK7rnTsPb6i7oYq+8FRPnl6cEbiFhlu1pu
//eCPOswKStCjFeWZbVFJbo2TT9ZDbypZxpS9Z3/FoImGtF99cuACSFHHEFfzq/l
p7sKRMkKoiSJGBQ1TERw1t6m2cPQLzocG2FiiLxtQAdspPIvHtvcSXWeQfae8lJ2
NAWRuJsIgoleoBTV+10WROVmyiu42mE+Bdh5lAHBA9WBG2E5h1juNcrWtwIsqyI0
25YYbnJdOTioC1Q+UWBf7jsvK55qt3s7RaOO1IKbIa4jYcJMlWIeXV546PRqfB9m
uwWFTGFAV0wHaOdcHvlA9RUayCWkGzUzAgIPfA2pTAvB4ObJD3NUkHfZi/nji+0x
fUPqM2kDBruiW2SDFZrMJC7aYtrb2mQ+rt3sCMJVxqb+QRuZsN7sHOF6B+GY1RJ7
puESJVQXEyT3aPKAqMp5wWGFSlS5EhIlfZX8ESEwHShI+IJvAjdybXwYjvrLmt+Z
tO15Pz8u+lONZ/u58Gsk4tfYv49e6IbSJZFYx6R2syLunSl7AL8=
=LK09
-----END PGP SIGNATURE-----

--znyrgjgdrrbjtpu2--
