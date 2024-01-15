Return-Path: <linux-kernel+bounces-26263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F882DDAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE64E1C20F12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DFD17BC2;
	Mon, 15 Jan 2024 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baIIcGGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C117C62;
	Mon, 15 Jan 2024 16:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE023C433C7;
	Mon, 15 Jan 2024 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705336563;
	bh=xUGRPQ2EffaZwZLMEGtFK+oABfjvuI3uXumfT349cmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baIIcGGKasqctSxWoLvoIPPfrKaUFdbi3SU7f2+lkFCiFEVr5lQdbQDJDBiRNob/E
	 S7mTeaClEEVSuokJ0I8H9bdImVf+TbIj8CKBxy0J74zjOmoDJRIzNdUcSgjMje6znx
	 LgH63B0/kouOCHiikIdpJDupCsZ0aRUyFL0sGnh3KWOuVZlE+5JsTilI8jGyHbdWEK
	 CoAI8C3SzUUYPb0F2YJf/4f0ef6A8y1AKTTHnPYVLeEGSZCiM2Na8RVeDenqP1mxGo
	 yJP3rDXHZ5oItZjiLQ3p4bAnE3gsu6XrIs2G1yKP7Bf8A4aOAPuRDcnY4kkVX8o1Cg
	 199mFZfiOZYwA==
Date: Mon, 15 Jan 2024 16:35:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: clock: sophgo: Add clock controller
 of SG2000 series SoC
Message-ID: <20240115-spendable-achiness-cff7918fe810@spud>
References: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953B0CD5B8796102DE358C2BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TuBYItwW9BIAMewk"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953B0CD5B8796102DE358C2BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>


--TuBYItwW9BIAMewk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 12:16:58PM +0800, Inochi Amaoto wrote:
> SG2000 series SoC has the same clock as CV1810 series, but the clock
> related to A53 is functional in SG2000 series. So a new compatible
> string is needed for the new SoC.
>=20
> Add definition for the clock controller of the SG2000 series SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-=
v1.0-alpha
> ---
>  Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.ya=
ml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> index c1dc24673c0d..59ef41adb539 100644
> --- a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>=20
> -title: Sophgo CV1800 Series Clock Controller
> +title: Sophgo CV1800/SG2000 Series Clock Controller
>=20
>  maintainers:
>    - Inochi Amaoto <inochiama@outlook.com>
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - sophgo,cv1800-clk
>        - sophgo,cv1810-clk
> +      - sophgo,sg2000-clk

I recall before you mentioned that the Sophgo folks were considering
renaming one of their devices. Is the sg2000 the renamed one, or a
different chip?

Thanks,
Conor.

--TuBYItwW9BIAMewk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVe7QAKCRB4tDGHoIJi
0uRwAP9mzzbnJcU5NjK3wd0CYbLltUApBRsV7oVkt08heTojJwEA5gmuu8dEjtdJ
1GycIchYx+T0qBt3L2ppGCqwqlIiMQ8=
=TyKR
-----END PGP SIGNATURE-----

--TuBYItwW9BIAMewk--

