Return-Path: <linux-kernel+bounces-16224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F9823B17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759EF1F25B25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361A5C89;
	Thu,  4 Jan 2024 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pdlDImvx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3E5257;
	Thu,  4 Jan 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704338631;
	bh=kdT/0YmXxcAO7Qs3QAs0jFqsuX+e974rQ9q04UyQwtQ=;
	h=Date:From:To:Cc:Subject:From;
	b=pdlDImvxukkibxI6SFmkg2Galm+3ucf0pJdiUAbqGX2KZ1rJ9hdWow9wQox5kBYoW
	 8beJzieRKEehif0G/fCesWq47Pgc0T1UC/2TeQ4zYXa9HCyC2nng4YW4GPZQi3qxqU
	 UGj0qITiZCeDhT/EvzuBwS8fDDGJcUBAPRijMVQy7FztfOx0zkoGhqLUxnxgTqLIqw
	 9cs7QkKPbKNgmv9TfANgvZsgl9g5AL6gLSat//WhiVdEl1SoPvntb0RXn1Fn7pof4C
	 KC+STOYo9OE6KjfnqEsbuVgVl8nN/UqzFxTcmsMeFkxsqUoQI9XHnC6A61A4KnMQyx
	 LTaGyZh5+9nGg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5Bkv07y1z4wd7;
	Thu,  4 Jan 2024 14:23:50 +1100 (AEDT)
Date: Thu, 4 Jan 2024 14:23:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp tree
Message-ID: <20240104142350.34d38d09@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EiBY5d=zaAVcPJXH./t7etJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/EiBY5d=zaAVcPJXH./t7etJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the nfs-anna tree as a different commit
(but the same patch):

  cb6d2fd30ddd ("SUNRPC: Replace strlcpy() with strscpy()")

This is commit

  d8056629633c ("SUNRPC: Replace strlcpy() with strscpy()")

in the nfs-anna tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/EiBY5d=zaAVcPJXH./t7etJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWWJMYACgkQAVBC80lX
0GzjIwf/XOROYE7gyMoHu64nFeX08UxAdX8xzQTc/2ODwmfHVGANsQQfNmBZIRti
ph+hGO6GTg0ymeOztSM6CEzzREnbj3/ctrJ+PSzAS8V8cTa99qLuQ/f7dITxbKRB
TDUvEQcmslY5YtmlNAT3Eqmjf+tQF584h8C0Jvhk+gtrQJXeDetYDy3PkGD6G/Re
7JDBZktMfbLxPbAkq4spmrBCvZ8KK28tj6RPFv657N1b8+8wGQb602bAfefFIHU7
ZliSy56d7FRT/USpFwhVndONabxg0bWDGvsR+9WpmKgqy1fvwhs+9RBzgeG+BF/q
gZDnFyP2mMCIV0E+ZGFez5cV4zBqZw==
=61yR
-----END PGP SIGNATURE-----

--Sig_/EiBY5d=zaAVcPJXH./t7etJ--

