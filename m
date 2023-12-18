Return-Path: <linux-kernel+bounces-4054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42681774C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FC91C25598
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F08495DE;
	Mon, 18 Dec 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql8mNLtJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4063D556;
	Mon, 18 Dec 2023 16:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F76C433C8;
	Mon, 18 Dec 2023 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916423;
	bh=1TJ6z/2n5yA1zKpBSS1FKvSKJzOxpKY5yqQW1tlh3co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ql8mNLtJYBvIiyP75UozTFORi+cRvJHqYZbr7sAFqi66/8aSUlHiXNL51rrGy2dok
	 8doZaNXnZHhNtVjjZzV6nyiJOmMQ1/cEHLxQOtHLn3tiKLyoXVbDSiyqQdEpvWrb5V
	 TkIGqehOMGrXN0733jM7IzJtmC2Pbdo//TwYiDCY4nfGhBApRE9yEQxRtK+kRYOmhY
	 5dtMfc5y6VIIUx+oszI1dYeATjexh3TeWf8dkME8TnJqMj/1sXCIRI0ZS9oA7T1esq
	 xJKoCOmZkWNvuujL5cjgQ/7nvNs7fsb7X6RmlJurC7hAwem/sQmRLEc0IwcPWoG42E
	 LkDgspBOMPyLQ==
Date: Mon, 18 Dec 2023 16:20:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: opp: sun50i: Add binding for D1 CPUs
Message-ID: <20231218-unsavory-private-50e5b52c632f@spud>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
 <20231218110543.64044-3-fusibrandon13@gmail.com>
 <20231218-disprove-judgingly-ee54d39474a7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PwKTfaebQ6MCV6JT"
Content-Disposition: inline
In-Reply-To: <20231218-disprove-judgingly-ee54d39474a7@spud>


--PwKTfaebQ6MCV6JT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 02:54:35PM +0000, Conor Dooley wrote:
> On Mon, Dec 18, 2023 at 12:05:40PM +0100, Brandon Cheo Fusi wrote:
> > Add binding for D1 CPU OPPs.
> >=20
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml    | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-=
operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun=
50i-h6-operating-points.yaml
> > index 51f62c3ae..fddaa3216 100644
> > --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operati=
ng-points.yaml
> > +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operati=
ng-points.yaml
> > @@ -23,7 +23,9 @@ allOf:
> > =20
> >  properties:
> >    compatible:
> > -    const: allwinner,sun50i-h6-operating-points
> > +    enum:
> > +      - allwinner,sun50i-h6-operating-points
> > +      - allwinner,sun20i-d1-operating-points
>=20
> This doesn't match what you have in your devicetree.

Per Samuel's comments in
<aad8302d-a015-44ee-ad11-1a4c6e00074c@sholland.org>
it looks like this binding is correct but the devicetree is wrong.

Thanks,
Conor.

--PwKTfaebQ6MCV6JT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYBxQAAKCRB4tDGHoIJi
0vHVAP0ZNkABGZhaykdtLfenWxGy/DxKf2+/30Xy3k645aMFswD+P5h11MvaPRsk
hQWx46DLx9lxxmCqqlWZxNdXTrfSUA0=
=W9Bc
-----END PGP SIGNATURE-----

--PwKTfaebQ6MCV6JT--

