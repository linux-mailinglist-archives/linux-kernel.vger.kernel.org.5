Return-Path: <linux-kernel+bounces-19953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3A82774D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F32C284B32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B045100F;
	Mon,  8 Jan 2024 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7RAqiHy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463154BC4;
	Mon,  8 Jan 2024 18:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7DDC433C7;
	Mon,  8 Jan 2024 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704738196;
	bh=Xq/EO1oUzFOE5Dl+jP8wqA2TBHVt9HXTNupEvkc0Mw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7RAqiHyXZ+NltxPmigtpJ8Z/lm8bpdTwMJMz8r1/LU4pGanagTzD+YnVkZll3WR2
	 hCwfhrJVor0hHRfd/uAdlPbvKrDE0vx5wjfyY7u6SdNpuBqiTsKf1bZRWPAA4zeEX+
	 vOADwhE5ZyuCUWwqHyTm7QJhBIvxWZdqJJftObzm6qquhm/ynfpu+xMjs6OOI4mpdz
	 c2sNGe4PglrSVQObDhkduh5AqcO/zHAxb6TJrlUFt5qZWsNT0GtCs4vTyk4gsppE0A
	 TxuxA+dd90B2l/CSfciF0gMRk1t4fC1J9LMc0VHIYH5AZA8Lp23sDINf+blvmtjDhF
	 iFSpZ3sClG8fQ==
Date: Mon, 8 Jan 2024 18:23:12 +0000
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
Message-ID: <20240108-undiluted-spiffy-8107aafdfa50@spud>
References: <20240107152557.3561341-1-enachman@marvell.com>
 <20240108-zoning-tactical-20501dccfac1@spud>
 <BN9PR18MB425195C57E2FC24D5F331C19DB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240108-chariot-thinner-7a86808a0571@spud>
 <BN9PR18MB42513EDDDA454FA50249205BDB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fFekk1XW+GUOomhA"
Content-Disposition: inline
In-Reply-To: <BN9PR18MB42513EDDDA454FA50249205BDB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>


--fFekk1XW+GUOomhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 06:15:51PM +0000, Elad Nachman wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > On Mon, Jan 08, 2024 at 05:47:24PM +0000, Elad Nachman wrote:
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > -- On Sun, Jan 07, 2024 at 05:25:57PM +0200, Elad Nachman wrote:
> > > > > From: Elad Nachman <enachman@marvell.com>
> > > > >
> > > > > Add Marvell ac5 device tree bindings to generic EHCI.
> > > > > This compatible enables the Marvell Orion platform code to
> > > > > properly configure the DMA mask for the Marvell AC5 SOC.
> > > > >
> > > > > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > > >
> > > > Maybe I am dumb, but I don't understand how this does what the
> > > > commit message says. There's no fallback to generic-ehci or any
> > > > other compatible that is already understood by the driver.
> > > >
> > > > What am I missing?
> > >
> > > Following guidance by Andrew Lunn on my mmc patchset, I have split the
> > > patchset Into a single patch for dt-bindings review and another for U=
SB
> > driver review.
> >=20
> > I don't understand that advice. dt-bindings should (almost) always be w=
ith
> > the driver. Otherwise you just confuse people like me.
> >=20
> > Perhaps Andrew meant sending dt*s* patches separately from the driver &
> > bindings?
>=20
> The rational was different people making the actual merge, into different
> intermediate git REPOs, before mering into linux-next.

Which almost certainly means he was talking about dts patches, not
dt-bindings. bindings (almost) always go through the same tree as the
driver that uses them.

Cheers,
Conor.

> > > The USB driver patch utilizing this new dt bindings compatible string=
 is here:
> > >
> > > https://patchwork.kernel.org/project/linux-usb/patch/20240107163307.36
> > > 77347-1-enachman@marvell.com/
> > >
> > > >
> > > > > ---
> > > > >  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > > b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > > index 87986c45be88..2ed178f16a78 100644
> > > > > --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > > +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > > @@ -77,6 +77,7 @@ properties:
> > > > >            - const: usb-ehci
> > > > >        - enum:
> > > > >            - generic-ehci
> > > > > +          - marvell,ac5-ehci
> > > > >            - marvell,armada-3700-ehci
> > > > >            - marvell,orion-ehci
> > > > >            - nuvoton,npcm750-ehci
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
> > > Elad.
>=20
> Elad.

--fFekk1XW+GUOomhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZw9kAAKCRB4tDGHoIJi
0sM1AP9jWivE9hoqI0QOA/4B6CD932ZBuoDM9HyaadT9ksWEkQD9GTRkXhrdXoCt
dtMkPLigOH+rBt9/GpyrGriyQOeiRgs=
=RjMD
-----END PGP SIGNATURE-----

--fFekk1XW+GUOomhA--

