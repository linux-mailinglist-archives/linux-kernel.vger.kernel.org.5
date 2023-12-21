Return-Path: <linux-kernel+bounces-9081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85381C022
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94B2B245C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730A376DBD;
	Thu, 21 Dec 2023 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uX+OAt35"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAA64ABE;
	Thu, 21 Dec 2023 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703194123;
	bh=zNqrk68RWsqEtkEK2LkbMxeHAdfaQx6xL3P+8sPc3/E=;
	h=Date:From:To:Cc:Subject:From;
	b=uX+OAt35h58XA2/N9Dw9szV2CZYTwV2j4QLubD6CCffCp91WBRUZ1NHT23vxFaghR
	 3gdaiZk9ZaQ5K0o0g9HrImOZw9R8CxTC7+Mj51x31NY79UWvGAeVK4Ee+sxK2wyLBY
	 V9uqtM1SA5CEDgyn8O9aKWbjazBOrdn1bwA0AWoNi+gXH+EaYRGuYjSw82eIt0/YN9
	 xUyjd1Bdj+nfnEMvs73BvaELrMwnJdVbW170OysAyqv2m9fk3YbiATFwvh7kqb5tus
	 VvJlzt62C3r8J9tlVo6Q+drghdqUM1cMgkR0Dw8c9NF8ypDav4R3xRiKd3PqnExqqt
	 VPQuBAT8TAmWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx3T755Qqz4xQj;
	Fri, 22 Dec 2023 08:28:43 +1100 (AEDT)
Date: Fri, 22 Dec 2023 08:28:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the afs tree
Message-ID: <20231222082841.41a77b36@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iqBQBnOWgUhe0GothG+0kp=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iqBQBnOWgUhe0GothG+0kp=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c64ea642f5ff ("afs: Add some more info to /proc/net/afs/servers")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/iqBQBnOWgUhe0GothG+0kp=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWErgoACgkQAVBC80lX
0GxtWQgAkh+EzBE/VUzS2Lv7/SQAHDzDf1SIB+ywd+2xKLQ6BqjXBPqA5sjDLVnz
jJfxP+b0IsDftAlIiUrxyuBPwxLeUFq15DxX8khQvF5FlVYSXm/eMCfjrMsAzf2O
ZcYRdM7xJ3lco6x9YQa/HWpGCavys+/rUDkOn6Du7WNP1Gi1s3M1Zf8xYehBFJMZ
lGjMOH3Wt4sVawYGJ6Cz3bavyyDPguet8a4mipUufj+a62uQTDk9+ky5IoGr+dKE
6C6cw58kMwb/8TniO952G6lGcIqynVdFu9OBhpTbvJbLrA5PU2ppK0qHNbpcxn+t
pOJiZOxUckVKAckZ7W18FIy5Th2qjg==
=utUm
-----END PGP SIGNATURE-----

--Sig_/iqBQBnOWgUhe0GothG+0kp=--

