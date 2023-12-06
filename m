Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DE8076C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442667AbjLFRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379717AbjLFRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:39:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C5D42
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:39:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAvrJ-0001zC-1c; Wed, 06 Dec 2023 18:38:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAvrH-00E0m4-Ce; Wed, 06 Dec 2023 18:38:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAvrH-00FdlK-32; Wed, 06 Dec 2023 18:38:51 +0100
Date:   Wed, 6 Dec 2023 18:38:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 12/18] dt-bindings: pwm: add binding for mt8365 SoC
Message-ID: <20231206173850.s6dndsjeeuy3sjan@pengutronix.de>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-12-5c860ed5c33b@baylibre.com>
 <20231023214411.sbrdqgethas25rkd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywtlv6jlyscfsmgx"
Content-Disposition: inline
In-Reply-To: <20231023214411.sbrdqgethas25rkd@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ywtlv6jlyscfsmgx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 23, 2023 at 11:44:11PM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Oct 23, 2023 at 04:40:12PM +0200, Alexandre Mergnat wrote:
> > Display PWM for MT8365 is compatible with MT8183. Then, add MT8365 bind=
ing
> > along with MT8183 SoC.
> >=20
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> What is the merge plan here? Should the whole series go in via drm?

I'll assume that Alexandre will send out a new round of this series and
this patch isn't supposed to be applied as is to the pwm tree. So I'm
marking this patch as "changes requested" in our patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ywtlv6jlyscfsmgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVwsaoACgkQj4D7WH0S
/k4hSggAle3BHyJ1MVsRw1KxYXPxxCujjOlC/iVTOF+lNCnkFIgsBCP3LIGUb/Vw
5cmRVOyQP9gr52PMZeQo7aa3eMxhZqixVS3FbEWppG6kPVCE2RwP6CV7SfP7N3Hp
VjKdzXifWVgRH366u/RaWoVuLftZvofZFYMTtF24KxoH0r40anqojRtJYYLwy/np
NDqAUYu3WNdjYKWsNa1s1PBSlasbG0B7bcAP5RfRuJXoTuTssx2XxrbjLcpu3Zhr
jPMxcBS60BO81t/LYCTMHDz6RNHpacGnRHTeWbnUaZm1SuHpyFuRGSAfIBkAmDGX
DXzkv8oxnnoFs+g0fj0LuxnlSkXixg==
=95Im
-----END PGP SIGNATURE-----

--ywtlv6jlyscfsmgx--
