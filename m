Return-Path: <linux-kernel+bounces-27616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F2782F309
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC171C236EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A51CAA4;
	Tue, 16 Jan 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE7HF9zb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B91CA87;
	Tue, 16 Jan 2024 17:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BFAC433F1;
	Tue, 16 Jan 2024 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705425300;
	bh=AM/mT4cfVjyQmj8eYYeWn3zIDa2zuDQADbRVMWcGQdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cE7HF9zb3MEIMMqRSRNybfeEURjS9oo8qSa2eouXnVBcJp8jCdDLXmwyQHHwaxOTp
	 3L7ifg/Ezqf9+cJrXxyFVMLSyGFMcnOIE6FDpTl00HC2NzJPbAinpaP26ggF6Eq4uV
	 DFW+lyp9Y6z6Z9hV+Puo25xhruj4VwB6cxnyHrRdljDUHl2c7jCI6z8yX8c/bCCmLS
	 v/Ke9t6b48smIY5ohyuRz4FGtvhuiQyX/gczFKu4lZnng/KbBDXxaF07peT6AMbL3X
	 eOsv7zPA7r45u1QeYjJF2F6GQkh7f6dTk22up8doKBv1L74rMzyGt5F6QCKwD+DbZz
	 MMaCrur52lMTQ==
Date: Tue, 16 Jan 2024 17:14:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@denx.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Tim Harvey <tharvey@gateworks.com>, Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 2/3] dt-bindings: arm: fsl: Add Sielaff i.MX6 Solo board
Message-ID: <20240116-donated-squealing-ff35a3bfe18d@spud>
References: <20240116105317.267525-1-frieder@fris.de>
 <20240116105317.267525-3-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DfmlNYOfuJd0KgGS"
Content-Disposition: inline
In-Reply-To: <20240116105317.267525-3-frieder@fris.de>


--DfmlNYOfuJd0KgGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:51:56AM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Add compatible for the Sielaff i.MX6 Solo board.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 32b195852a75c..f6cdf4a8e51a2 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -469,6 +469,7 @@ properties:
>                - prt,prtvt7                # Protonic VT7 board
>                - rex,imx6dl-rex-basic      # Rex Basic i.MX6 Dual Lite Bo=
ard
>                - riot,imx6s-riotboard      # RIoTboard i.MX6S
> +              - sielaff,imx6dl-board      # Sielaff i.MX6 Solo Board
>                - skov,imx6dl-skov-revc-lt2 # SKOV IMX6 CPU SoloCore lt2
>                - skov,imx6dl-skov-revc-lt6 # SKOV IMX6 CPU SoloCore lt6
>                - solidrun,cubox-i/dl            # SolidRun Cubox-i Solo/D=
ualLite
> --=20
> 2.43.0
>=20

--DfmlNYOfuJd0KgGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa5jQAKCRB4tDGHoIJi
0hO4AP9CXUUylAtaQzw7HfQVBSy6p8Z4JW5/NMb0Uqt2v/xgAQEA1fMAeW5GZFTS
000iUenQZ/HZOWMfld459agOkgEzJgk=
=wYVv
-----END PGP SIGNATURE-----

--DfmlNYOfuJd0KgGS--

