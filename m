Return-Path: <linux-kernel+bounces-1620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F08150F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D27F1C23F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71445C03;
	Fri, 15 Dec 2023 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="dE/u/h8q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A694187A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=EwV6
	ANXcfpuqKizL5vgUsaHNQwbJJyivDm3DkJD6bBY=; b=dE/u/h8qJTnMc/3Bj0s5
	BzgxKlmUWO1Bm7j2jl1ZTMzq5ZDhKO777BJ8rmj1PoqM+XOiO7wb8OVcA4ucN7LL
	buDb1lzufAiTcdIHyvp0wM0rNH4mJqi0Hk95HdttMzMSSBdPmSOwYRJg9cVO4xMW
	frU1Z/1wr3FnkLkCMy85yBiVRDASlF4cvkQGUWgsvjRr0FDpEblkwbDvenSQxaUu
	pbIo4rQJGqmvjrO0kIFWKeD1The9ahLZxFC74BwKrT4dBEh97G2k7hg2b1Hre1Ny
	rYiLjSHNoEJa2q6L8BpYpdq+ArDEZtxSRvxTvdVNNitfTVyV9iJFdjJdftpAE7Tf
	qw==
Received: (qmail 1358809 invoked from network); 15 Dec 2023 21:15:15 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Dec 2023 21:15:15 +0100
X-UD-Smtp-Session: l3s3148p1@LVvmDpIMfUQucvBI
Date: Fri, 15 Dec 2023 21:15:14 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] gnss: ubx: support the reset pin of the Neo-M8
 variant
Message-ID: <ZXyz0l3KFqx9hliG@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
 <ZXfTwscAltoVY1lV@shikoro>
 <ZXsk4i/OTGFhiCk9@shikoro>
 <ZXwPeJFdEERbhj3b@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gQzt5N1o3G2NrJOX"
Content-Disposition: inline
In-Reply-To: <ZXwPeJFdEERbhj3b@hovoldconsulting.com>


--gQzt5N1o3G2NrJOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> All good. Now applied for 6.8.

Thank you! :)


--gQzt5N1o3G2NrJOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmV8s84ACgkQFA3kzBSg
KbYQwg//bP2qP2thoiTVZrXHDShR4T7g8iJNJQKFDp7BQ2UNPeIb71VEsa1MsHJE
BPgmKM0t6pExI0I5kZTKRxhnYbsZMD6lEyit0d4W4tY0Z0bmLPy5zoaciPgX1tsz
ffzLa4CFcu4MC171/5UkPBOhpE893/1OdQuQvUtx2UOxOY73/QSWuh+MyTSrxLPk
gGkah96y83Ara4qAeyeMpF/IGkrCklq8k5pEUVfWBNDF3iB1z1E6MW0wUegThCbi
x5bUT4o3yoaJiHqxtM+FGTgBp1tYcwmlSocoAbH8otTscW311zCKgawSX6UNzivJ
grzwRU9fVN795OZI+nlI0yiyNlSpNAKLnGfo+u0Vr+oXKHOBFT+0KRMf+PE5YWxj
yiLFNtapPNQMyEjYRyNgZzK0npg82POB8tzrpUSh4iXzlXkwCI0fay6qo1BrJBha
ChglGgnZ56huvX+UkIlR2H7vrvekOo5VnzWJkfnVYxD99TcgeUiZa9a6nLcpcWd+
+h0i+ZtuhaEubtLuhLhonbgqK9Jldj/n0GG1To0GsipFeFNRn/H6ddBQYmxYCQ1H
U0Vh95Gd+yQaBkpYyjTeqf1lcr8VMWF0EPEvLtxYSVyZjdvqPbp0SFNoYALkN3Xv
GNTyzF6D6TW/O+x5tar7U+a73UZcNo9YTUjK9Bq0meKjt7C4iJA=
=xa0h
-----END PGP SIGNATURE-----

--gQzt5N1o3G2NrJOX--

