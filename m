Return-Path: <linux-kernel+bounces-18998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7382664A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582A11F21493
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE90125D1;
	Sun,  7 Jan 2024 22:04:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pokefinder.org (pokefinder.org [135.181.139.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AD125A7;
	Sun,  7 Jan 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-dreams.de
Received: from localhost (183-123-142-46.pool.kielnet.net [46.142.123.183])
	by pokefinder.org (Postfix) with ESMTPSA id 16575A4A0E5;
	Sun,  7 Jan 2024 22:55:12 +0100 (CET)
Date: Sun, 7 Jan 2024 22:55:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the i2c tree
Message-ID: <ZZsdvyddoXxWBfbR@kunai>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240108082408.75eff37e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5UYYWqDANUVmM7Bg"
Content-Disposition: inline
In-Reply-To: <20240108082408.75eff37e@canb.auug.org.au>


--5UYYWqDANUVmM7Bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>=20
>   ba6181152308 ("i2c: core: Fix atomic xfer check for non-preempt config")
>   e3bcb32ffc10 ("Documentation/i2c: fix spelling error in i2c-address-tra=
nslator

Yes, sorry, I needed to change the commit messages in the last minute. I
told Linus about that in my PR. I can add the new patches to linux-next
tomorrow.


--5UYYWqDANUVmM7Bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWbHbsACgkQFA3kzBSg
KbaYQQ//bFKuhh1jjoBrXOR1II0ST9cT00QK8+gSXvq/55+996/bLAgYvEl77VGt
4O8xgZuW6rSVG/ftKZSXAJLWvJaV0W/QVg+Yw2Az28Br7E8XnbdKrVIi7G9YV5Pv
MMt4HRC0MmB98YHQ/Kq9NWbTFMDdQA6Rr6s9+1gUU9t2qGUp+QnQLziS17G7vYNv
3xJSR9C+lkDh5fKQik/CrziD6FmF48TtwTXXsOkLTbHbOJudtdVlZcNrLFcfdMLL
3ZepRu9QKYdkdwHGkJvWH7jSijPurB3Fo8Su18yui9rwQ+22A4B+P4SCNzUXXSga
kQbWuxwkio2LCjXJsTy85KUAXG88CzF/C+A3kY26Po7JT93bpJzk6N/+IDuE4T4n
JpPXsKGaWv0ByhMlNv9xT11kQpV5TeDf+Y+TJufzsghBqu2cAXD3NH4t9oqeo6Rt
S/uTFe3fxu4VClAQz+VjWFRJt++33pI8x6MqYURfzO6qBJJDo1eOfLHrt1T745x/
jT3nPPTmCyo9d7lHMVU5f/ARecTjS+nl8nlyYJHd0yhnna4JPSL4e1/h2l+tQgwm
GSDn/avwvHQBbEkSv1FIpMd/4Ir+98del0TfdeBZgX8cErd7tgYbMwyeKKQbuAO+
Nx8/NMFVWSH4N9RS6rhGm4GcEdzsRh1ADnatxhxrBL/pzckdi0M=
=nh1X
-----END PGP SIGNATURE-----

--5UYYWqDANUVmM7Bg--

