Return-Path: <linux-kernel+bounces-3865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D536D81744F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D935284E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C937895;
	Mon, 18 Dec 2023 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbhPZ5JZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE637868;
	Mon, 18 Dec 2023 14:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC24EC433C8;
	Mon, 18 Dec 2023 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702911282;
	bh=s3iiGBDd0jsA5GpHn3zZNS/JFO1WQ8YGurgE+GdbYWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbhPZ5JZK5Kof/4b0TzkfXcc3GHerqi+g8NhBJJCURhWt72q2okrrd66eYS0Wp66H
	 Sgjg6D5TbW0P96ptKmP0zlENg771eNxAaTBswnZOX3S1Kpk6aCK3lJ/0RqPvNn9vve
	 GAvF/kt8TvnBYGB2KREHF74mcav2vVQArDGCXoABjheuzszRK7k7Ucm9D+8i/gVr4V
	 NIt0yngV6Kh5XUuchlMK/TLveHl7U+I+F/tTaNcHJncwYWdXtIBGyq30P3AO/0RvJn
	 wT/RYSJ8cBLmhF1Dy+YUmUlRR5RTnYrOu4+qb3+XYRdxuuI3G0hgfHP/k5uLxt4Trz
	 1hlo72yV1x6EA==
Date: Mon, 18 Dec 2023 14:54:35 +0000
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
Message-ID: <20231218-disprove-judgingly-ee54d39474a7@spud>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
 <20231218110543.64044-3-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ex3+7jnV//1NaCLU"
Content-Disposition: inline
In-Reply-To: <20231218110543.64044-3-fusibrandon13@gmail.com>


--Ex3+7jnV//1NaCLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:05:40PM +0100, Brandon Cheo Fusi wrote:
> Add binding for D1 CPU OPPs.
>=20
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-op=
erating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50=
i-h6-operating-points.yaml
> index 51f62c3ae..fddaa3216 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating=
-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating=
-points.yaml
> @@ -23,7 +23,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: allwinner,sun50i-h6-operating-points
> +    enum:
> +      - allwinner,sun50i-h6-operating-points
> +      - allwinner,sun20i-d1-operating-points

This doesn't match what you have in your devicetree.

> =20
>    nvmem-cells:
>      description: |
> --=20
> 2.30.2
>=20

--Ex3+7jnV//1NaCLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYBdKwAKCRB4tDGHoIJi
0lyiAP9BYEhi78cgiuyY4EJyb87Pi/R3VwKDPk6tN/UiBYxD8QD7BdhHh5jX6e51
xmsnQRqdYF7y1UNW76jBO9VI4GrG/w0=
=i83T
-----END PGP SIGNATURE-----

--Ex3+7jnV//1NaCLU--

