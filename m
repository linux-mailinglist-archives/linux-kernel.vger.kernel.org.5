Return-Path: <linux-kernel+bounces-13953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15E821585
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078101C20EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7DDF9DE;
	Mon,  1 Jan 2024 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GiGWh4nQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A757F9C3;
	Mon,  1 Jan 2024 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704147459;
	bh=jnfiSVdTzJ86zToeJsrO3Q6T2ovObuN4eFEHjCoaQDU=;
	h=Date:From:To:Cc:Subject:From;
	b=GiGWh4nQHhSSNPpymC/bwaKLczvBtVBemy+5M5Mzw7JZZNJHsPiHsQuZF8UOaXHPc
	 kEC58l7TW6Z7jKYzQcGRNUULPiheFSoL7pPaD8twi+52SkQjYcEAdx3+SPM5nPzJxg
	 cTudBcCznehf9S7vmGiUtb3PuAsPqWnKFR45mXrstTzU5DOOy/DeSqTTlAdQ0BuIJN
	 UsmEPZeHL3P2nlykwQBZ+C70VBFkaKIFOzT3LrloHNg/JTDDke9wmcqGbCP+wqQUn6
	 iH9s1rHVsIcx9+x/BdELrdbNobf351zWPXiA6b9sqJs4ng+5JTaJ6x7gLknSBZE1Rr
	 XIPt21mupYtpw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3r2V2Bs4z4wnx;
	Tue,  2 Jan 2024 09:17:38 +1100 (AEDT)
Date: Tue, 2 Jan 2024 09:17:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Torgue <alexandre.torgue@st.com>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the stm32 tree
Message-ID: <20240102091736.0cc42b20@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3YvS5ATBLY5SZeLM3vM6J/1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3YvS5ATBLY5SZeLM3vM6J/1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  769e4b077b2e ("ARM: multi_v7_defconfig: enable STM32 DCMIPP media support=
")

This is commit

  ed27e15bc490 ("ARM: multi_v7_defconfig: enable STM32 DCMIPP media support=
")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/3YvS5ATBLY5SZeLM3vM6J/1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTOgAACgkQAVBC80lX
0GyKeAf8DiSV7AbkKWSk0w18M6PJ1vULFe45+BiANIh3qV77QXfXl1p7n4RK/May
tSD0yXE10ZJtZLqKYMFuS7cKXd77ToqwF3BSRq5Np+HPM038gvt5oQDFDehmmmV+
5gjFR1kK5ZjPrwFPWm/t2xIJq9d/O45fD3Z1Xu+uSpp0nF+ke8TY4en17wQ8YeeX
OZqFDZiaUtRjlk9GbJaCojkdYGQJymQtdPVigXH+PTxJRzckCRIoDHfRADhY9Rpp
NvmcXRZU0FStjZH6kNPOysi9JX8cA0KfaIIf0lBjf8OKkZrMfZkBv4EDkZxTAx+2
ZAwgKdm/g2GUfCM2NVP5q0BrMOooHQ==
=9nlA
-----END PGP SIGNATURE-----

--Sig_/3YvS5ATBLY5SZeLM3vM6J/1--

