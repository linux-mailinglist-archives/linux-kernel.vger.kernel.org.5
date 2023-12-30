Return-Path: <linux-kernel+bounces-13561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDE820813
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AE1C22566
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DFFBFE;
	Sat, 30 Dec 2023 17:44:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34BF9C4;
	Sat, 30 Dec 2023 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJdNP-000FuJ-1Y;
	Sat, 30 Dec 2023 18:43:58 +0100
Date: Sat, 30 Dec 2023 18:43:35 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 5/5] wifi: b43: Support advertising lack of QoS
 capability
Message-ID: <20231230184335.53e33db2@barney>
In-Reply-To: <87cyunk45e.fsf@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
	<20231230045105.91351-6-sergeantsagara@protonmail.com>
	<20231230144523.7df01ff5@barney>
	<87cyunk45e.fsf@protonmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/04xsz+cOeeKNmqlab4tIDAR";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/04xsz+cOeeKNmqlab4tIDAR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 17:10:26 +0000
Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:

> > The firmware probably is just too old for this device. =20
>=20
> I just retested with newer firmware released on 2012-08-15. I still see
> the same issue with QoS. This appears to be the newest firmware I can
> acquire from http://lwfinger.com/b43-firmware/, which I extract from
> broadcom-wl-6.30.163.46.

It's still pretty old.
Nobody has worked on getting a newer version extracted for a long time.

But I'm fine with just disabling QoS on this device.
Upgrading to a newer firmware probably is a bigger change.
That could be done later.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/04xsz+cOeeKNmqlab4tIDAR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWQVscACgkQ9TK+HZCN
iw4dZw//dQ+J3UdZS2OD5DDjJw7tXIufz5nExYFDCnCPhiW9dArIJGqqZHi2TbTW
6fwbXwKma3TgOaUYLWKBVmbsBqDbCRcX63Wum4BBnrZQHml1YlY1b3Qow9348Rtz
btqV1tCaOd6dgTWtZsGcotTiXsh+qXoOI/hclbNkr32Oh+3D47f10x4i+N6uJSdA
X+G3wvfyI0LZbj3wxxkQ1uNL7r5SdwpQKdqaiidnW77IRT3nJYWEtSK2UqaeDdDw
U2xGkOdW8J/5qPAiUHdD7Pvla56xBO+RsMtxuDWWfHfqtrXF7psNV3sBK/IXrtA+
cHmQEO66J0WwGSZlBxEwrI0A0iF4k+StjmZEz/SZ/T9Grsoqh8PXFgBAJ6zHpriF
Z+W4BgS81VvdsioKvvUlaU296i8BU1Q7OjUBa1GMAJabdMmAkIZSL0Qj8Szwe3Ow
lBXXkTPeMbt2u/hMmFQe+Ws1KX/fCJJSlb8KpGWkUgAkzifuqdq+07/j+MRTUnQ1
x7EUxzd1jh0EWLRxe1uh554F7WKX360BYZYrWnILTQ9stzibAtqsU3ZKOv/OJqF+
jy7d+hs5k0JouILMxFVkb/FqqEids0lgYf2iS8tfHPGpY4WT7cqc5kwXGKeNE0vF
AEnGZSejBr+sYnhOpDqRwmdRXXPa0RYlK/vJKePJT3YjE5I1YUw=
=fzl9
-----END PGP SIGNATURE-----

--Sig_/04xsz+cOeeKNmqlab4tIDAR--

