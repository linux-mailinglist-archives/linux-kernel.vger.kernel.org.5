Return-Path: <linux-kernel+bounces-27507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B541582F13F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06241C23632
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6E1C29F;
	Tue, 16 Jan 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh1sofLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA01C280
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A8EC433F1;
	Tue, 16 Jan 2024 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705418285;
	bh=rabLjfAy7bC7UlGHaMRzQZqur8kUO/H60wZSGrSwfEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zh1sofLJXBSctIa3CMNtRF2FZiP3Rm0uvEAkDOOgwzO4yeh4dYk3NyjRsbhfZ27k7
	 iKnex7NFcxSvAVBzlmcO/SOOLfRERzdKY2NPH6lQ9uGzjEtEnlMfrbTnuluZTk6pqD
	 5+o1hEb12/LYt/fkvNtt91sG1jRrKV28tXnDBDtNuI2b33m4Pau8YpWfCIWz2wHdcg
	 iH2k5KBolk06Pqi1gqJzPDH/E4lXC9111APJkBMuXJQ3hbaVLrQ99zAguwYKn5gseJ
	 DcCkXPioAleMxJ7wSMA7V2rScHRZuBjrLd6kuksX7QxBNoTdwH6yJIe1hIA4l8rM9b
	 D+3tuoe4TsKhw==
Date: Tue, 16 Jan 2024 15:18:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: event: Add netlink command for event mask
Message-ID: <2e9de7ba-0020-42b6-8fc6-71ebae4b9fa5@sirena.org.uk>
References: <20240116103131.413205-1-naresh.solanki@9elements.com>
 <e3e16af2-7f8d-4776-9726-f6282128a766@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z2aIztPMx+sJYNwX"
Content-Disposition: inline
In-Reply-To: <e3e16af2-7f8d-4776-9726-f6282128a766@gmail.com>
X-Cookie: Programmers do it bit by bit.


--Z2aIztPMx+sJYNwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2024 at 02:46:41PM +0200, Matti Vaittinen wrote:

> Do you think allowing setting the 'filtering' this way per socket would work
> or be beneficial?

I haven't thought about it enough to say anything about the working bit
but it does seem like it could be useful (eg, a UI might be interested
in more events than something just looking for critical errors).

--Z2aIztPMx+sJYNwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWmnigACgkQJNaLcl1U
h9CkAgf/Y+46lUJYdVIwwhubucfNH2JoaK11zm6Ux+fCQqK9Ht+2rC+jp9bjsz/H
pBdHgeZUT1wuo6JQFDCMxu+XAP1xxWgbvtlhFH06RiljAO9FBbIXRYDgs3An5o21
AAeJScw33Zx8f8kDbW+bYjOpyGNdHa1yvfAQAtxxn9sAM9Y3siMeW5UsW0R3yRzB
VOfuHfZnqH/FkV/9i5oEXwIQFTOh9t6X9QIxOCvdZ9LT+qDb8pJwYqTBJOXzY/oh
d9JQByPIBs/6kwTehCRgNUxG6IU4q/mEkn7Evi9a14azpOMhsJjDHxjLFKvP5NmS
vXLEOWTDbNb87ndwSqgV0Fbl6Dd+JA==
=zSBq
-----END PGP SIGNATURE-----

--Z2aIztPMx+sJYNwX--

