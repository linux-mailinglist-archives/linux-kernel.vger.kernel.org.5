Return-Path: <linux-kernel+bounces-21177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF2828B57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8E1C20EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0F3B794;
	Tue,  9 Jan 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtDy9JMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039739AEA;
	Tue,  9 Jan 2024 17:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4607C433C7;
	Tue,  9 Jan 2024 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704821657;
	bh=syCE0BwfVDeT7qH/cCOtSq9aFIuBR8gzEpq+znSgolk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtDy9JMoBJ8Bqdzgh4pdgHwfeHnq/lTRlgWOjpVrsVDh9iQUpWTaCcbauLGaYfMVt
	 PMwEzI3ItkcSQAaYRbsO2fnDxjRWVqpZ2lKto9elLBlu+RHndSsAgQTudV6zbS8G2t
	 6pUx78AGOpsTp/Yju8lgUpLpNZngGJVCdzP6guysEzeWmlzcEgihoLbbBKBk1yYsH/
	 NcvQ48SixJR3Kr04zgXJRJ3QazKc3AiWQo0XhMkjJRq99Jo8Tu0bLjbkUclRuFIMMI
	 nI0N8DtwtWV4H+/0RMm5mzRLRkZeEHJgHA3T3aYzxz0vkI/QU+N6GB2ey/BucqCUEn
	 M3UxvVa7cdXhQ==
Date: Tue, 9 Jan 2024 17:34:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2 3/8] riscv: dts: thead: Add TH1520 pin control nodes
Message-ID: <20240109-boggle-frugality-03a77cab8308@spud>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
 <20240103132852.298964-4-emil.renner.berthing@canonical.com>
 <20240108-majorette-overtly-4ec65d0a15e9@spud>
 <CAJM55Z_2zhELW3E7p94J05We17xTC2Rejs5AigNJOHCGHVr_zg@mail.gmail.com>
 <20240109-tiptoeing-twirl-ebb943e17a29@wendy>
 <CAJM55Z9Ka3hiNmgFuy01Yd0YyxL-SzS=A7S3k84=B1xABKbJhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hJD6qYXNgkRLNOMK"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9Ka3hiNmgFuy01Yd0YyxL-SzS=A7S3k84=B1xABKbJhA@mail.gmail.com>


--hJD6qYXNgkRLNOMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 06:28:19AM -0800, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > On Tue, Jan 09, 2024 at 04:02:01AM -0800, Emil Renner Berthing wrote:
> > > Conor Dooley wrote:
> > > > On Wed, Jan 03, 2024 at 02:28:40PM +0100, Emil Renner Berthing wrot=
e:
> > > > > Add nodes for pin controllers on the T-Head TH1520 RISC-V SoC.
> > > > >
> > > > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonic=
al.com>
> > > > > ---
> > > > >  .../boot/dts/thead/th1520-beaglev-ahead.dts   |  4 ++++
> > > > >  .../dts/thead/th1520-lichee-module-4a.dtsi    |  4 ++++
> > > > >  arch/riscv/boot/dts/thead/th1520.dtsi         | 24 +++++++++++++=
++++++
> > > > >  3 files changed, 32 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b=
/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > index 70e8042c8304..6c56318a8705 100644
> > > > > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > @@ -44,6 +44,10 @@ &osc_32k {
> > > > >  	clock-frequency =3D <32768>;
> > > > >  };
> > > > >
> > > > > +&aonsys_clk {
> > > > > +	clock-frequency =3D <73728000>;
> > > > > +};
> > > > > +
> > > > >  &apb_clk {
> > > > >  	clock-frequency =3D <62500000>;
> > > > >  };
> > > > > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dt=
si b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > > > index a802ab110429..9865925be372 100644
> > > > > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > > > @@ -25,6 +25,10 @@ &osc_32k {
> > > > >  	clock-frequency =3D <32768>;
> > > > >  };
> > > > >
> > > > > +&aonsys_clk {
> > > > > +	clock-frequency =3D <73728000>;
> > > > > +};
> > > > > +
> > > > >  &apb_clk {
> > > > >  	clock-frequency =3D <62500000>;
> > > > >  };
> > > > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/b=
oot/dts/thead/th1520.dtsi
> > > > > index ba4d2c673ac8..e65a306ff575 100644
> > > > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > @@ -134,6 +134,12 @@ osc_32k: 32k-oscillator {
> > > > >  		#clock-cells =3D <0>;
> > > > >  	};
> > > > >
> > > > > +	aonsys_clk: aonsys-clk {
> > > > > +		compatible =3D "fixed-clock";
> > > > > +		clock-output-names =3D "aonsys_clk";
> > > > > +		#clock-cells =3D <0>;
> > > > > +	};
> > > >
> > > > Did this stuff sneak into this commit accidentally?
> > >
> > > Not really by accident no. It turns out the clock tree has gates for =
the bus
> > > clock of each pinctrl block and I think it's better to add this clock
> > > dependency to the bindings and driver up front.
> >
> > Maybe if I had looked a wee bit more deeply I would've noticed that it
> > was used there, but it's always good to mention the rationale in the
> > commit message so that it's more obvious why you're doin it.
>=20
> You absolutely right. I forgot to update the commit message.
>=20
> > > Since there is not yet any clock driver the initial device tree for t=
he TH1520
> > > included the dummy apb_clk that two of the pinctrl blocks derive thei=
r clock
> > > from, but not the "aonsys" clock needed by the "always-on" pinctrl. I=
 thought
> > > it was better to add this dummy clock with the only (so far) user of =
it, but if
> > > you have a better idea, let me know.
> >
> > No, that's fine. I was just wondering why there was an unmentioned set
> > of clocks being added. If they're stubbed fixed clocks I dunno if it
> > makes sense to add them to the board.dts/module.dtsi files though. Where
> > do the initial values come from for the rates? Out of reset values or
> > set by firmware that may vary from board to board?
>=20
> The vendor u-boot sets the PLLs different from the reset values. For now I
> think it's the same code for every board using the Lichee Pi 4A module (a=
nd
> probably also for the BeagleV Ahead), but it might still make sense to mo=
ve the
> freqency to the board instead of the module device tree.

Yeah, think so. Only temporarily though, do you have a clue if anyone is
working on the actual clock driver stuff? Seems pretty Deadge?
https://lore.kernel.org/linux-clk/?q=3Dth1520

Cheers,
Conor.

--hJD6qYXNgkRLNOMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ2DkwAKCRB4tDGHoIJi
0pcOAPoD+P51AMazIRXDSkpKgUQM6eBblVNkqmaR1okaVmmX7wEA7wVS+pAjp9hI
N8snAcL1efQHu26mrSkIAL4yScknnwg=
=wI/n
-----END PGP SIGNATURE-----

--hJD6qYXNgkRLNOMK--

