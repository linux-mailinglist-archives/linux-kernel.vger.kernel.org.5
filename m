Return-Path: <linux-kernel+bounces-13664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E6820AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690C11F215F3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9AE4415;
	Sun, 31 Dec 2023 09:27:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994D33CE;
	Sun, 31 Dec 2023 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJs66-0006lb-2N;
	Sun, 31 Dec 2023 10:27:05 +0100
Date: Sun, 31 Dec 2023 10:26:32 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>,
 Julian Calaby <julian.calaby@gmail.com>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless v2 0/4] wifi: b43: Various QoS-related fixes
Message-ID: <20231231102632.4e6f39eb@barney>
In-Reply-To: <20231231050300.122806-1-sergeantsagara@protonmail.com>
References: <20231231050300.122806-1-sergeantsagara@protonmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oU+WI7IVMn8P07XG25DRyrC";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/oU+WI7IVMn8P07XG25DRyrC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Dec 2023 05:03:27 +0000
Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:

> Rahul Rameshbabu (4):
>   wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
>   wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
>   wifi: b43: Stop correct queue in DMA worker when QoS is disabled
>   wifi: b43: Disable QoS for bcm4331
>=20
>  drivers/net/wireless/broadcom/b43/b43.h  | 16 ++++++++++++++++
>  drivers/net/wireless/broadcom/b43/dma.c  |  4 ++--
>  drivers/net/wireless/broadcom/b43/main.c | 16 +++++++++-------
>  drivers/net/wireless/broadcom/b43/pio.c  |  6 +++---
>  4 files changed, 30 insertions(+), 12 deletions(-)
>=20


Acked-by: Michael B=C3=BCsch <m@bues.ch>

for the whole v2 series.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/oU+WI7IVMn8P07XG25DRyrC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWRM8gACgkQ9TK+HZCN
iw6Tbw/8DfJ057LLYYSvsQWxSxjEXCFP5kXzwtf+Mz3BfpJLJ5bThfAGCLx8qW7W
xAeTc/53XvHSjNnsV5i4bMF29eW2gdXQxzXY1b6xiDCSV8YuJFQp7TtO5q+LXpMP
ReflOhXfpbg8d6pcTj/wbGVCBJYN9Ycw12q9QrsrhOn7FsjRXdzq1Sv7wMOsF1GT
ye8djWsHoREH4LYYPgPa/+Y9k3l5Y94yOJbsjE71suecVzTgwKWBjTdFwSD1oi2F
MfDp+5cFM98I99CnPIXBdNMjeULCeWloDvI2j+oJ9l7o+o/QA4ypS7a3WzTfEdDU
IldGcAZ+4wQoigM249CbmRAHN0z0L0yjsZgPSbkdzAOqil9Tkm8ZhVz+yhtkdiS+
3a7exfcSf25TTBnzH/asC0qLrzCMW+9h2uZWc2DZpSABbYQB3tPiPDSL5buAkJ70
njctvYoiE9IPtXIjpXpGtztRw3e7CKJRvFfickX/0x9uMWVXM5uh1y4ecbZQSIF9
kCJekQdW8+pYv6SZCKg7WAZ42ggTbbbKNYF2OqMgxtRwQIMu4y9QMlyZkkH30twp
P+JIt9vn2Otm48db2z10vpjhUdzdpNCDORpNfh/d9oU8WrsID2YO2hMairlpUBfa
7ywJ0gXRIjKtFZSf1JQQ6wQjH39Tz4zRTZ7JFDHdUU9jIIM+i58=
=m0zx
-----END PGP SIGNATURE-----

--Sig_/oU+WI7IVMn8P07XG25DRyrC--

