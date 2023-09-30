Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA97B43AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjI3Usx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3Usv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:48:51 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18159D3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:48:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmgtE-0001gM-7D; Sat, 30 Sep 2023 22:48:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmgtA-00A82J-9I; Sat, 30 Sep 2023 22:48:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmgt9-006ecY-Uj; Sat, 30 Sep 2023 22:48:35 +0200
Date:   Sat, 30 Sep 2023 22:48:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2] modpost: Don't let "driver"s reference .exit.*
Message-ID: <20230930204835.fbgl5pko2emgewqd@pengutronix.de>
References: <20230930165204.2478282-1-u.kleine-koenig@pengutronix.de>
 <CAK7LNATyRg6Hc-fnTETERj-tdMFGaBDt0Fyhy9+jKCzAvzQ6Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rt2n5oc2fzud6qqb"
Content-Disposition: inline
In-Reply-To: <CAK7LNATyRg6Hc-fnTETERj-tdMFGaBDt0Fyhy9+jKCzAvzQ6Pg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rt2n5oc2fzud6qqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Masahiro,

On Sun, Oct 01, 2023 at 05:33:54AM +0900, Masahiro Yamada wrote:
> Then, I hope you (or somebody) will volunteer to fix broken drivers.

I already added that to my todo list. However it's otherwise non-empty,
so I won't promise to tackle that quickly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rt2n5oc2fzud6qqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUYiaIACgkQj4D7WH0S
/k7XYQf/fdqfsNpiGYsX2MPI2hlnSDbHGBRX4S1z81iV32Ou6avCBuXREuxqYBWI
98Kh3waniSh05EeoTI5On+EucLGRn9bb51oZrEqF9YXZvI34RInl9YXH4kaQ8B9E
B44F7i8s4l1KvkxL6gdCdbiKzPOvbV7WBLhUCgpGWXhb+8i9/OikEH9qB4U5saHw
P8PiBlkqNSF4M+OeunZSK8TEKnk1yV2dmgTzHprpSJGRJYP5ZMrRB4xWCsGtTQl2
sIw+lUzHkeCpF1ZEeOAJAVdaVP11fEbSTiJgvaarxaHvAUHIZmSk80vCtWC7COki
da0CjSPQIRO7bzER/3yePc61gdyMOw==
=w15k
-----END PGP SIGNATURE-----

--rt2n5oc2fzud6qqb--
