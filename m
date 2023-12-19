Return-Path: <linux-kernel+bounces-6111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB08194C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CFF1C25126
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FE3FB03;
	Tue, 19 Dec 2023 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1BE4kY9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779943D0CB;
	Tue, 19 Dec 2023 23:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17142C433C7;
	Tue, 19 Dec 2023 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703029735;
	bh=6Awxn5V8AF848/sL+nni2y6BxV7vYA7baRCKnw14y/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1BE4kY9mKQ+gismCY/LJfkXQmNsCT6872ehEHdX++U0c1AgqKeDNv2A97UOnMu3m
	 6nixw/ZlAgr08kVBigelDw6ZCQHHhBXywVX/aSdNOQmSz8dUOxPsVRQxC+eIEUExMb
	 efywyJg0/FkooDguWnKhF55ooRvX13ghr7mTplfw9K81OxwSPUTMpeej27ux245DWB
	 vaD7KlF99H+rILYxj/ZzcHBrHXm3YMUheb06bVcETyQ3D0kkTK3N7A1AhnF2yodeAU
	 RfavRNEeiWIkOW56sRLWvf0F47gLdGFmRjXu7cN/R4uLWgfOV8NPtl6cGsWwC1H4L1
	 GMe+D68ejKvrQ==
Date: Tue, 19 Dec 2023 23:48:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 0/1] StarFive DWMAC support for JH7100
Message-ID: <20231219-green-footwear-e81d37f9c63c@spud>
References: <20231219231040.2459358-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oh06CCJkLIxcVNXN"
Content-Disposition: inline
In-Reply-To: <20231219231040.2459358-1-cristian.ciocaltea@collabora.com>


--oh06CCJkLIxcVNXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 01:10:38AM +0200, Cristian Ciocaltea wrote:
> This is just a subset of the initial patch series [1] adding networking
> support for StarFive JH7100 SoC.
>=20
> [1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.cioca=
ltea@collabora.com/

You need to send the binding patch alongside the driver, unless that has
been applied already.

Cheers,
Conor.

--oh06CCJkLIxcVNXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYIr4QAKCRB4tDGHoIJi
0h8IAQCS86wYpq5Hrwpt9eYpD/kbb3OmnLoYFWKbzhsIywOcwgD+NDOhb/Qneu3B
kkjU++IJXvuRpPCfETXRhcCGaxFrXQ8=
=7Klu
-----END PGP SIGNATURE-----

--oh06CCJkLIxcVNXN--

