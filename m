Return-Path: <linux-kernel+bounces-21117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC20828A27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABAD1F25ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29383A26E;
	Tue,  9 Jan 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS6hffrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3339AFA;
	Tue,  9 Jan 2024 16:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22925C433C7;
	Tue,  9 Jan 2024 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818435;
	bh=xumFkzh9dOhqQuxWQPzQ0UOI+crU8zGpXe3IKeAJiLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mS6hffrM8lke09V6OI+rr+zWeUuXVm+yeEU3pex4lAnkO+QzbfFKtZWS6RNtOfBVA
	 OXxdShG6OWUaVqBcepdY/kNTyzMMux9hWwpIfT7glq08vpVWPk3rkXSwBOOczEpx1b
	 5pr4Qd4QM/S8EAeiLqRne6LSZ26SOHa8XR8taeUy/aobdgDP28leKB5rK21zF8f7UC
	 pt1i/Ex4Iz3Rncmy6J3HMrdl6ZqvjDNIw5Bg5qUnGksuQcVyiDUgrx61b7EJCK5KcW
	 xxGWa/gsx+kaUpbyWXMbgJxTXbt8ECq4NEHX0IOwMQ72xTcW4QIXD9lV7FB4Qt4D/a
	 8x83Ov3qSVoaw==
Date: Tue, 9 Jan 2024 16:40:29 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
Message-ID: <20240109-perennial-darkroom-953f86a05adb@spud>
References: <20240102205941.29654-1-zajec5@gmail.com>
 <20240108-helium-retriever-043ed3e1dbe0@spud>
 <1a9d7f5b-4a00-4026-81b8-7af3031c6656@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bl2E85BvxztBLFCl"
Content-Disposition: inline
In-Reply-To: <1a9d7f5b-4a00-4026-81b8-7af3031c6656@gmail.com>


--Bl2E85BvxztBLFCl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 07:12:35AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> Hi Conor,
>=20
> On 8.01.2024 18:38, Conor Dooley wrote:
> > On Tue, Jan 02, 2024 at 09:59:40PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > >=20
> > > MT7988A is another MediaTek's SoC with just 1 device available right
> > > now: Banana Pi BPI-R4.
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I sent V2 meanwhile, could you reply to below PATCH instead, please?
>=20
> [PATCH V2 1/3] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4

In the future, just give me the message-id in these cases.

--Bl2E85BvxztBLFCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ12/QAKCRB4tDGHoIJi
0pSZAQCakbEDbpyJU1zZrJrksXPLUy1QLurql1JT2lp+rbNL5QD+MXaybdojog9v
8C36eHKqtqb6uPGDATzIRYl+BUuRRQU=
=mce9
-----END PGP SIGNATURE-----

--Bl2E85BvxztBLFCl--

