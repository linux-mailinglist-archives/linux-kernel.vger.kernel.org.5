Return-Path: <linux-kernel+bounces-587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0255881434D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352581C2254A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36011192;
	Fri, 15 Dec 2023 08:09:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD816426
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rE3FR-0002sV-6E; Fri, 15 Dec 2023 09:08:41 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rE3FP-00FzBq-TY; Fri, 15 Dec 2023 09:08:39 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 45AD52639D1;
	Fri, 15 Dec 2023 08:08:39 +0000 (UTC)
Date: Fri, 15 Dec 2023 09:08:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH] phy: phy-can-transceiver: insert space after include
Message-ID: <20231215-cover-overheat-14be5a6fc0d6-mkl@pengutronix.de>
References: <202312151407+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hs7kqyfvdpf4yw4d"
Content-Disposition: inline
In-Reply-To: <202312151407+0800-wangjinchao@xfusion.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hs7kqyfvdpf4yw4d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.12.2023 14:09:00, Wang Jinchao wrote:
> Maintain Consistent Formatting: Insert Space after #include
>=20
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hs7kqyfvdpf4yw4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmV8CYMACgkQvlAcSiqK
BOiG4AgAqxMkdiIDbL8RsDETy9Wjp4cYppoKf1BnajImFH+U7XrztoezITfJTY0v
y4qyitEITNAedX3EHrhISxTE7oMs7imd0ZNTGaAtfH7UhG+MMrDY7QAUe62rbyPY
YUHlnJZWkKMN4wo66VcERXg8r4Peaqf3Lwm8bfPgPfuvs/K/jZ6Vly5DyhfcXIRo
cY0Y6RneBdvW7qrWKe5RSoaioTNz9GtqGvsyoSOSOLuX+1P/6VJTFciImIdNWFNe
b8Io4TvI9TLKawTAqJmce5V10CUtmYubr5Y/fgp4/qbuVYVGCpzmJBp3r4hFWXB7
/vraeHL36ZPUnyHG4BN0r27abltHYw==
=JmnX
-----END PGP SIGNATURE-----

--hs7kqyfvdpf4yw4d--

