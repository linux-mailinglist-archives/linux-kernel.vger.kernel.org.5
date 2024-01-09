Return-Path: <linux-kernel+bounces-21101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F72A8289DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F16B241D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963C3A1D4;
	Tue,  9 Jan 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUNd/Nj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2DB3A1BB;
	Tue,  9 Jan 2024 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A26C433F1;
	Tue,  9 Jan 2024 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704817226;
	bh=P21KAUUxSYEu3xFekCmy23VZ39OvyiMglzFNoXQDU7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUNd/Nj+tSHTfoG05OfMde7bK+K7zbjh2J3YcazJEm+gqdfvLfVmdLq0E6eLodTEa
	 y2sjE8oWnz6y6Qll9DEFuo6opcL/Et2Q3syYE4pHKnVInP/ctYShbFgDhw8qAiicPS
	 xBAvzdJZM1RDnYUx+dzamO8w9nvyHZ5QRjqnPWW6i2RuknK7BnZWUnHOTYgbRDVNCE
	 dVjkEs6Lxm/64LjY5qaTEWrzirSxjEoxLyKdgJ0PZTIRaTP3+bXVpZ8USnl4xb8Syf
	 tkgCjG9Ry2+MeiSAg9jbY6D88xB+mEyynG6qIWHJX0THse9ipJtZv8ATzqfPNe2mXJ
	 z1zJCDY3OKzRg==
Date: Tue, 9 Jan 2024 16:20:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: gregkh@linuxfoundation.org,
	rowland.harvard.edu@mx0a-0016f401.pphosted.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add Marvell ac5
Message-ID: <20240109-brink-catfight-1f11df16d2b4@spud>
References: <20240109081044.10515-1-enachman@marvell.com>
 <20240109081044.10515-2-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1S6LNRWKf4LsTFJ/"
Content-Disposition: inline
In-Reply-To: <20240109081044.10515-2-enachman@marvell.com>


--1S6LNRWKf4LsTFJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 10:10:43AM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
>=20
> Add Marvell ac5 device tree bindings to generic EHCI.
> This compatible enables the Marvell Orion platform code
> to properly configure the DMA mask for the Marvell AC5 SOC.
>=20
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1S6LNRWKf4LsTFJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1yRgAKCRB4tDGHoIJi
0gPjAP9wdF7OaFb81LFt0ze6rkEowrwGYZZYzCoFBX33capmpQEAp+XVl/+LMmZ/
qIVIgJSpgdCdXY7VW7zDJcP1flKBwAI=
=VtJO
-----END PGP SIGNATURE-----

--1S6LNRWKf4LsTFJ/--

