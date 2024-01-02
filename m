Return-Path: <linux-kernel+bounces-14859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86591822347
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9997E1C2165F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229E168BF;
	Tue,  2 Jan 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E8hgLdQZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81553168AD;
	Tue,  2 Jan 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704231130;
	bh=ctS7MiAx/ApYyWS0bpg8lpFZkZX++9smodbx4CqW6kg=;
	h=Date:From:To:Cc:Subject:From;
	b=E8hgLdQZEkIqgN5sgGp4nJLJ6UOyOCx1rTrMM+n9qt5XTTSriQIKCRDmSIlNk8pGn
	 Am8Uu8P+K8oBx1fD/7URoEt9d+V17xznH0z9H1myHWMLxjzhhk19KDuEqcSxybPceo
	 M3rwWxJ4wpH1B0iqRfqNtGHne0aFnuCbyv0Gkr7SWD68XKR3uBAG8D7Gi3iPu4LbMM
	 KMnpjnMC9+djpU8FHeQqV8uVuRXaeKfSk2rNFxrzEOIl2gF+RJvZp5IXdyIAYrsXyV
	 RapRmJJ90kVKjjEpz2X3EqlRikEovqXLoGYGXtf8Prx29yFPWjCgs99s7ABVulQomG
	 REZOriqiYxwLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4QzY5Jgzz4wch;
	Wed,  3 Jan 2024 08:32:09 +1100 (AEDT)
Date: Wed, 3 Jan 2024 08:32:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Cc: Vicki Pfau <vi@endrift.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the hid tree
Message-ID: <20240103083208.03071ea8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QTb5NPCkgkeh=tGhcU.6NHe";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QTb5NPCkgkeh=tGhcU.6NHe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  917972636e82 ("HID: hid-steam: Disable watchdog instead of using a heartb=
eat")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/QTb5NPCkgkeh=tGhcU.6NHe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWUgNgACgkQAVBC80lX
0Gw5bQf8CnaJh0IDe1QauopSub427O4f0FbyvWmdHgJeNxU0zqVXAAPbELI5vhiX
ejlaa/BD8juot9RVcxeaYIovuwlPou7tot358tGTajFro4LP4ikwK/KlJWVLoYab
oPdeWqmppOcaXgfzAu2Tx5em9RFrSqjiuEi5btqwZ1ItTgn3wqhtQE8IQ0yYqc6s
T/Mi/Pf76jkHWWnEEMycC4Qlq/sDm2VW7ZxqYGTQgtCVYhcQ8jefjKSDr5AE2oqa
t+2kSwLRbltR22sG7PJ72iHnocslcot1jdyMg732s0aCmChVLyQXvByTHEejzZsk
8F/Azs/vcLMbTLUJKiT3Dwg6G8dL4Q==
=H2Nl
-----END PGP SIGNATURE-----

--Sig_/QTb5NPCkgkeh=tGhcU.6NHe--

