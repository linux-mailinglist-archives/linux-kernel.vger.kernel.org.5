Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FE7E28EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjKFPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjKFPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:43:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FD134
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:43:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r01lE-0006yR-Qo; Mon, 06 Nov 2023 16:43:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r01lE-0074oJ-7b; Mon, 06 Nov 2023 16:43:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r01lD-00DmxG-UN; Mon, 06 Nov 2023 16:43:31 +0100
Date:   Mon, 6 Nov 2023 16:43:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/2] pwm: add driver for T-THEAD TH1520 SoC
Message-ID: <20231106154331.yonhekamzrhl4jct@pengutronix.de>
References: <20231005130519.3864-1-jszhang@kernel.org>
 <ZUj8/fhitNf8fRMf@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jsf3f7vbz6to4kdv"
Content-Disposition: inline
In-Reply-To: <ZUj8/fhitNf8fRMf@xhacker>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jsf3f7vbz6to4kdv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 06, 2023 at 10:49:33PM +0800, Jisheng Zhang wrote:
> Kind ping, is there any chance for this series to be merged for v6.7?

I didn't forget about reviewing your driver, but as such a review takes
quite some time I often fail to do the review in a timely manner. Sorry
about that.

Having said that I guess Thierry's tree won't pick up any new patches
given that we already crossed the middle of the merge window and patches
are supposed to be in next for some time before being sent to Linus.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jsf3f7vbz6to4kdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVJCaIACgkQj4D7WH0S
/k4QCAf/acNnr3Gu4/8Kw26Tso95OH5ZRC6qvEoB9lCUTWMCS92Q96p+w12Y7cpU
FwP+u2j1ZU75B9rU9/ghwcMSpeBkm0EvcVhxFJCcRfQCfqhNb4ZZosZs+xyNnEzC
dCIdbtRKzpejhd/rrzN9h9RrS9XrxO0rqp1Bx0zuQIz1S+SXmeQlBIXBrt8lJTSQ
XGLco64DSob6ydIuTMXMy4hsk7v5bp/2NaXoPKR2TusZ0PRjQ9uqPbtlkDHOKyh6
OvbK3CTWZTxLGQPtrUhuY0FwA5kbyMj/f0CzFLySXVzR8W+Pocnu5W7cSaMFqoBH
25rzVqBG6j12xDq3k0JwXL+jDoepLg==
=G7ji
-----END PGP SIGNATURE-----

--jsf3f7vbz6to4kdv--
