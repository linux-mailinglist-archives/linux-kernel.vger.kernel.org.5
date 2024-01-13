Return-Path: <linux-kernel+bounces-25127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9F82C847
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01666288B46
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BD7F6;
	Sat, 13 Jan 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLmCdfsw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF955364;
	Sat, 13 Jan 2024 00:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1428CC433C7;
	Sat, 13 Jan 2024 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705105154;
	bh=jkYHmyccI1i0Ro3AnbMF7bjGr5rPQLyGrDauXfxXpDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLmCdfswI58RUzss1uuJ0ktawrWsZUBtQj+a6Ep/XyC4PAZ5Ze5y4X6DdsPXVVa2n
	 aJnYdXmdsy3EU+Fnkl24ZjoPqp4RaDaG+auyHTCo2TuYHQKjbobfa6oaG8mGRGmkDR
	 Xxr3mCSxf5axMay7yjiSJ6d9TqU3hACc5b9rK06j1dI7b5GHsiwPSg67WLkNUJxnXU
	 DrqAkQVtVD35t8xAdWjPQqIfUdMRw0l4qPIEOM8qic3d1518GZukE0EdZKKS/x5EL1
	 MacBhfkQnOEblZmKk1O33hrIXuC7ZAsaBNUciaRf5J6sB+UskC60LvOfSNkjQr21nq
	 XFn6IhthHn6Vg==
Date: Sat, 13 Jan 2024 00:19:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Atish Patra <atishp@atishpatra.org>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
	adrian.hunter@intel.com, ajones@ventanamicro.com,
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
	anup@brainfault.org, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	conor.dooley@microchip.com, devicetree@vger.kernel.org,
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be,
	guoren@kernel.org, heiko@sntech.de, irogers@google.com,
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	locus84@andestech.com, magnus.damm@gmail.com, mark.rutland@arm.com,
	mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
	robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
	tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
	wens@csie.org, will@kernel.org, ycliang@andestech.com,
	inochiama@outlook.com, chao.wei@sophgo.com,
	unicorn_wang@outlook.com, wefu@redhat.com
Subject: Re: [PATCH v7 04/16] dt-bindings: riscv: Add Andes interrupt
 controller compatible string
Message-ID: <20240113-sensuous-scraggly-dee35f3e213f@spud>
References: <20240110073917.2398826-1-peterlin@andestech.com>
 <20240110073917.2398826-5-peterlin@andestech.com>
 <CAOnJCUJ0fN5=+b4jDx+NPqUwgwGKuBNYt7d86dXYNyjzUYFAWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9j3hNYTLiVCjPwOZ"
Content-Disposition: inline
In-Reply-To: <CAOnJCUJ0fN5=+b4jDx+NPqUwgwGKuBNYt7d86dXYNyjzUYFAWQ@mail.gmail.com>


--9j3hNYTLiVCjPwOZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 03:50:15PM -0800, Atish Patra wrote:
> On Tue, Jan 9, 2024 at 11:40=E2=80=AFPM Yu Chien Peter Lin
> <peterlin@andestech.com> wrote:
> >
> > Add "andestech,cpu-intc" compatible string to indicate that
> > Andes specific local interrupt is supported on the core,
> > e.g. AX45MP cores have 3 types of non-standard local interrupt
> > which can be handled in supervisor mode:
> >
>=20
> PATCH1 in this series renames everything from ANDESTECH to ANDES to be
> consistent.
> Here you are adding DT binding with "andestech". Is there any
> fundamental difference between these two to demand
> this change ?

This one is the vendor prefix and the company has been assigned
"andestech" and they're not getting a second one. The rename of the
variables is a bit gratuitous tbf.

Cheers,
Conor.

> FYI: I don't mind either way as I don't have skin in the game. Just
> something I noticed while reviewing the series.
>=20
> > - Slave port ECC error interrupt
> > - Bus write transaction error interrupt
> > - Performance monitor overflow interrupt
> >
> > These interrupts are enabled/disabled via a custom register
> > SLIE instead of the standard interrupt enable register SIE.
> >
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > Changes v2 -> v3:
> >   - Updated commit message
> >   - Fixed possible compatibles for Andes INTC
> > Changes v3 -> v4:
> >   - Add const entry instead of enum (Suggested by Conor)
> > Changes v4 -> v5:
> >   - Include Conor's Acked-by
> >   - Include Prabhakar's Reviewed-by
> > Changes v5 -> v6:
> >   - No change
> > Changes v6 -> v7:
> >   - No change
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docume=
ntation/devicetree/bindings/riscv/cpus.yaml
> > index 23646b684ea2..33c2b620a59f 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -101,7 +101,11 @@ properties:
> >          const: 1
> >
> >        compatible:
> > -        const: riscv,cpu-intc
> > +        oneOf:
> > +          - items:
> > +              - const: andestech,cpu-intc
> > +              - const: riscv,cpu-intc
> > +          - const: riscv,cpu-intc
> >
> >        interrupt-controller: true
> >
> > --
> > 2.34.1
> >
>=20
>=20
> --=20
> Regards,
> Atish

--9j3hNYTLiVCjPwOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaHW9gAKCRB4tDGHoIJi
0k35AP9VKffvTBJtcf4LlW9yLeSkC4w/hmPUD8G6HFAB6oraGAEA3gp73X31G721
TR1o3EqGGSx+AvLvQPGz0Q4EWLyWFQc=
=ur8w
-----END PGP SIGNATURE-----

--9j3hNYTLiVCjPwOZ--

