Return-Path: <linux-kernel+bounces-19932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B38276F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086631F23A0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134355C0F;
	Mon,  8 Jan 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxeWVIM5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA445479F;
	Mon,  8 Jan 2024 18:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FD0C433C8;
	Mon,  8 Jan 2024 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736890;
	bh=2sJKQnWiuRcHb9YAm7i4yHBXpq3l+A/vAPFiNhQHp3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxeWVIM5KodphfplHbe3qTtNn0aaP41JS4rDwwLWMpnXDdNdq4b7BPyeU2SO6KZ6q
	 L7JRl5nbLiJwID4Ba8n8KOyFw+BQdLtXY6ZOFe20Tyz+3lntZbWBjekPs/zLGHhrij
	 5Rt1Q27IgT57pmk13bXK6h1Q/h8dXLoiQ8CazKwzlPQKmZJdjCnSpbeEyKuwVkhbB8
	 VrSkqppWrpcb09bYnK6N+wJ5a+e/RdWDo2D74W7mY/v7M0Yllrn6954jPf7oqiiznv
	 WgxFBc5ZLMMqXgMLkUHkCTu6uKsmKP0iXq/6XpV1rcXjpTqIVoaDJpr1wQ9OkQcuOV
	 SQ8SqJ0vBIEZw==
Date: Mon, 8 Jan 2024 18:01:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
Message-ID: <20240108-chariot-thinner-7a86808a0571@spud>
References: <20240107152557.3561341-1-enachman@marvell.com>
 <20240108-zoning-tactical-20501dccfac1@spud>
 <BN9PR18MB425195C57E2FC24D5F331C19DB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DBZslo/amjWoSLRv"
Content-Disposition: inline
In-Reply-To: <BN9PR18MB425195C57E2FC24D5F331C19DB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>


--DBZslo/amjWoSLRv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 05:47:24PM +0000, Elad Nachman wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, January 8, 2024 7:15 PM
> > To: Elad Nachman <enachman@marvell.com>
> > Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> > devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
> >=20
> > External Email
> >=20
> > ----------------------------------------------------------------------
> > On Sun, Jan 07, 2024 at 05:25:57PM +0200, Elad Nachman wrote:
> > > From: Elad Nachman <enachman@marvell.com>
> > >
> > > Add Marvell ac5 device tree bindings to generic EHCI.
> > > This compatible enables the Marvell Orion platform code to properly
> > > configure the DMA mask for the Marvell AC5 SOC.
> > >
> > > Signed-off-by: Elad Nachman <enachman@marvell.com>
> >=20
> > Maybe I am dumb, but I don't understand how this does what the commit
> > message says. There's no fallback to generic-ehci or any other compatib=
le
> > that is already understood by the driver.
> >=20
> > What am I missing?
>=20
> Following guidance by Andrew Lunn on my mmc patchset, I have split the pa=
tchset
> Into a single patch for dt-bindings review and another for USB driver rev=
iew.

I don't understand that advice. dt-bindings should (almost) always be
with the driver. Otherwise you just confuse people like me.

Perhaps Andrew meant sending dt*s* patches separately from the driver &
bindings?

Cheers,
Conor.

>=20
> The USB driver patch utilizing this new dt bindings compatible string is =
here:
>=20
> https://patchwork.kernel.org/project/linux-usb/patch/20240107163307.36773=
47-1-enachman@marvell.com/
>=20
> >=20
> > > ---
> > >  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > index 87986c45be88..2ed178f16a78 100644
> > > --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > @@ -77,6 +77,7 @@ properties:
> > >            - const: usb-ehci
> > >        - enum:
> > >            - generic-ehci
> > > +          - marvell,ac5-ehci
> > >            - marvell,armada-3700-ehci
> > >            - marvell,orion-ehci
> > >            - nuvoton,npcm750-ehci
> > > --
> > > 2.25.1
> > >
>=20
> Elad.

--DBZslo/amjWoSLRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZw4dQAKCRB4tDGHoIJi
0hSqAP4xusX8cEpsDU84zERhVTTbTIH10Je3uZ6ZsbDppShawwEA3ZBtfSjtCUIi
vFt1tM8Hu6nQZwxkTPe6i0M7wmX46wg=
=yA4S
-----END PGP SIGNATURE-----

--DBZslo/amjWoSLRv--

