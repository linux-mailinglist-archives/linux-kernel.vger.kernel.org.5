Return-Path: <linux-kernel+bounces-25727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEA82D507
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2CD281AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277363D1;
	Mon, 15 Jan 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoV0R374"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD005689;
	Mon, 15 Jan 2024 08:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC49C433C7;
	Mon, 15 Jan 2024 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705307133;
	bh=bkFxuxf0iCghKC8GrzWqXKXAFsRRBXSZ7feexi45UVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoV0R374tK5kCtzfve7eyQAekaInOpN0kUMbDADJ0KXk63eiqZTQu9MWzErWMYAfj
	 BDp82RgAyoC0OgaHWM5EFeBKTwr8e+VuBEiW9BLrJAQoXyQcvdypB5Jg9rqF3Eto5u
	 u+EbR/pWzZwUzdc53sIOnvkoHlbqKwwykR0GFpAgmNhCKrLV97kkbrFH0THj6m9hNd
	 rlhyTBEwVAXw3ZeYbwAxM/EyfKlfjSXTiTQg5oBwZxiTqrTSdiuaD5tS8mwlRYdcK1
	 J5IYOw8SdFTdWr6BorUsL3PvlYJxuPS7BKs7hxmNaGe84+JruinkUhmnF8916wcMt5
	 vzHB0zIfM8/Ew==
Date: Mon, 15 Jan 2024 09:25:30 +0100
From: Maxime Ripard <mripard@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>, 
	Donald Robson <donald.robson@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Adam Ford <aford173@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: Re: [PATCH RFC v2 04/11] ARM: dts: omap4: Add device tree entry
 for SGX GPU
Message-ID: <vpcgccul53oibwoqb3barj3rjxoyskoldjyfvjdzmytic3tonm@wq4aqsenk7rp>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-5-afd@ti.com>
 <122DC5ED-2AA7-46A0-845F-083922458385@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5bv4mdxrrdvnbudo"
Content-Disposition: inline
In-Reply-To: <122DC5ED-2AA7-46A0-845F-083922458385@goldelico.com>


--5bv4mdxrrdvnbudo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 12, 2024 at 06:33:58PM +0100, H. Nikolaus Schaller wrote:
> > Am 08.01.2024 um 19:32 schrieb Andrew Davis <afd@ti.com>:
> >=20
> > Add SGX GPU device entry to base OMAP4 dtsi file.
> >=20
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> > arch/arm/boot/dts/ti/omap/omap4.dtsi | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/ti/omap/omap4.dtsi b/arch/arm/boot/dts/t=
i/omap/omap4.dtsi
> > index 2bbff9032be3e..559b2bfe4ca7c 100644
> > --- a/arch/arm/boot/dts/ti/omap/omap4.dtsi
> > +++ b/arch/arm/boot/dts/ti/omap/omap4.dtsi
> > @@ -501,10 +501,11 @@ sgx_module: target-module@56000000 {
> > #size-cells =3D <1>;
> > ranges =3D <0 0x56000000 0x2000000>;
> >=20
> > - /*
> > - * Closed source PowerVR driver, no child device
> > - * binding or driver in mainline
> > - */
> > + gpu@0 {
>=20
> I wonder why we don't add a "gpu:" label here.
>=20
> Almost all other subsystem nodes have one (e.g. emif:, aes:, dss:, dsi:, =
hdmi:, etc.),
> obviously for convenience when using a .dtsi file.
>=20
> It would allow a board-specific DTS to easily add status =3D "disabled" t=
o avoid driver
> probing or disabling the GPU (e.g. if there is no display).

There's no reason to disable it in the DT: the hardware block would
still be there and it's rendering to memory so it still could be useful.

If there's no display on the board and you really don't want the GPU
driver, then you can disable the driver or block the module loading, but
it should be a distro / package / user decision, not a DT / kernel one
still.

Maxime

--5bv4mdxrrdvnbudo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZaTr7AAKCRDj7w1vZxhR
xSybAP96mNxOy9DrBryPZmmu4a4Y6AfuRKXr9+Uh2C3OhAPO3QEA1j3KoeAhpYrF
0pDWtJkRFUHwyOTCz3HpiAeRG3RSqwM=
=GRcK
-----END PGP SIGNATURE-----

--5bv4mdxrrdvnbudo--

