Return-Path: <linux-kernel+bounces-26122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8482DB9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC4E28381C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC61759C;
	Mon, 15 Jan 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQR/pEoz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBD175A1;
	Mon, 15 Jan 2024 14:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BE3C433C7;
	Mon, 15 Jan 2024 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705329940;
	bh=tRLQ0Z88RKbDDHqezEjN3omnxCVQLyn4MWvS8yuJ5G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQR/pEozoncS5C3Ol7jiA/QacLXasDr5SzqDhp7hsq0JpO3tPfLz3ZVokJj8586el
	 CjNNdgORcvFgXTBZXeHRrTEEv8OGN+DaWt4iql928ZOSZScnA79uc0Dl+x8Emf6vGn
	 TGoB/lSOBEhLgpOhOv8bZ53DIdeAoNzHi9+oPgYgPpmOqEOmF+faeFG0k/N8ribQXk
	 u+mpY34z54kgqNf6cg87CqtOhN3eBJSt3tqm2/UfuLDWOpobBRhIORmGyK6bJRCfM4
	 VO2BK8o28Uf6cfJjKB3GQymTLO0ISMdOEBNnXrcrXCH5A5DT+Qyv/uX/eTcsm87xdh
	 etysZWABystcw==
Date: Mon, 15 Jan 2024 15:45:37 +0100
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
Message-ID: <xagwa5cie5gjzidg5wa6ou3yd2qwta7ridci4jzkrpcccm24mz@aphgjsdytirz>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-5-afd@ti.com>
 <122DC5ED-2AA7-46A0-845F-083922458385@goldelico.com>
 <vpcgccul53oibwoqb3barj3rjxoyskoldjyfvjdzmytic3tonm@wq4aqsenk7rp>
 <7BC64F03-A4DF-411F-9B6F-6BCA436D9B50@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xx7p3mwtk5a7dcv"
Content-Disposition: inline
In-Reply-To: <7BC64F03-A4DF-411F-9B6F-6BCA436D9B50@goldelico.com>


--3xx7p3mwtk5a7dcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 09:55:00AM +0100, H. Nikolaus Schaller wrote:
> Hi,
>=20
> > Am 15.01.2024 um 09:25 schrieb Maxime Ripard <mripard@kernel.org>:
> >=20
> > Hi,
> >=20
> > On Fri, Jan 12, 2024 at 06:33:58PM +0100, H. Nikolaus Schaller wrote:
> >>> Am 08.01.2024 um 19:32 schrieb Andrew Davis <afd@ti.com>:
> >>>=20
> >>> Add SGX GPU device entry to base OMAP4 dtsi file.
> >>>=20
> >>> Signed-off-by: Andrew Davis <afd@ti.com>
> >>> ---
> >>> arch/arm/boot/dts/ti/omap/omap4.dtsi | 9 +++++----
> >>> 1 file changed, 5 insertions(+), 4 deletions(-)
> >>>=20
> >>> diff --git a/arch/arm/boot/dts/ti/omap/omap4.dtsi b/arch/arm/boot/dts=
/ti/omap/omap4.dtsi
> >>> index 2bbff9032be3e..559b2bfe4ca7c 100644
> >>> --- a/arch/arm/boot/dts/ti/omap/omap4.dtsi
> >>> +++ b/arch/arm/boot/dts/ti/omap/omap4.dtsi
> >>> @@ -501,10 +501,11 @@ sgx_module: target-module@56000000 {
> >>> #size-cells =3D <1>;
> >>> ranges =3D <0 0x56000000 0x2000000>;
> >>>=20
> >>> - /*
> >>> - * Closed source PowerVR driver, no child device
> >>> - * binding or driver in mainline
> >>> - */
> >>> + gpu@0 {
> >>=20
> >> I wonder why we don't add a "gpu:" label here.
> >>=20
> >> Almost all other subsystem nodes have one (e.g. emif:, aes:, dss:, dsi=
:, hdmi:, etc.),
> >> obviously for convenience when using a .dtsi file.
> >>=20
> >> It would allow a board-specific DTS to easily add status =3D "disabled=
" to avoid driver
> >> probing or disabling the GPU (e.g. if there is no display).
> >=20
> > There's no reason to disable it in the DT: the hardware block would
> > still be there and it's rendering to memory so it still could be useful.
>=20
> Well, if you know that the board does not have a dm3730 but a dm3725 with=
out
> GPU it is better to disable the GPU completely instead of loading the dri=
ver
> and make it detect by some internal bits that it has no GPU on the SoC.

It shouldn't even be in the DTSI if it's not in the SoC.

> > If there's no display on the board and you really don't want the GPU
> > driver, then you can disable the driver or block the module loading, but
> > it should be a distro / package / user decision, not a DT / kernel one
> > still.
>=20
> The same holds for aes: dss: dsi: hdmi: etc. If they are not used by some
> board file, they don't change a single bit of the DTB [1] which IMHO would
> be of reasonable concern to question additional labels.

Not really, no. If there's no HDMI connector, the HDMI controller is
useless. A GPU without a display can still be useful, depending on the
workload.

Maxime

--3xx7p3mwtk5a7dcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZaVFEQAKCRDj7w1vZxhR
xYLAAQD7hjmkBsOxfyoIsGNpz7ekssiiDTWUKJBEn79S9qdkjQD/ZF6T4o4JwKg2
1Y0Gk2k+BhScqbkykr/ZplBD8LyDcgg=
=po+r
-----END PGP SIGNATURE-----

--3xx7p3mwtk5a7dcv--

