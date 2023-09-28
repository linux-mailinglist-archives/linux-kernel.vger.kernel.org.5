Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788927B26D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjI1UsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1UsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:48:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58619D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:48:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlxvW-0006Oy-Fq; Thu, 28 Sep 2023 22:48:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlxvV-009erQ-B8; Thu, 28 Sep 2023 22:48:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlxvV-005kYi-1e; Thu, 28 Sep 2023 22:48:01 +0200
Date:   Thu, 28 Sep 2023 22:48:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20230928204800.tlsauorjk6iz5r7f@pengutronix.de>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
 <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
 <CAM+2EuKb9-Wc+HAmsmPfmdM49k=7yoXboDF+swaMS_bgXbCOQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gahfz3hanrircdwo"
Content-Disposition: inline
In-Reply-To: <CAM+2EuKb9-Wc+HAmsmPfmdM49k=7yoXboDF+swaMS_bgXbCOQA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gahfz3hanrircdwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:49:01PM +0530, Jagath Jog J wrote:
> Hi Uwe Kleine-K=C3=B6nig,
>=20
> On Wed, Sep 27, 2023 at 3:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
> > > The Bosch BMI323 is a 6-axis low-power IMU that provide measurements =
for
> > > acceleration, angular rate, and temperature. This sensor includes
> > > motion-triggered interrupt features, such as a step counter, tap dete=
ction,
> > > and activity/inactivity interrupt capabilities.
> > >
> > > The driver supports various functionalities, including data ready, FI=
FO
> > > data handling, and events such as tap detection, step counting, and
> > > activity interrupts
> > >
> > > Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downl=
oads/datasheets/bst-bmi323-ds000.pdf
> >
> > Maybe put this link better in the driver.
>=20
> Yes, if there are multiple commits on the driver, the datasheet
> link will move further down with the initial commit. I will add
> datasheet link in the driver.
>=20
> >
> > > +static struct i2c_driver bmi323_i2c_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "bmi323",
> > > +             .of_match_table =3D bmi323_of_i2c_match,
> > > +     },
> > > +     .probe_new =3D bmi323_i2c_probe,
> > > +     .id_table =3D bmi323_i2c_ids,
> > > +};
> > > +module_i2c_driver(bmi323_i2c_driver);
> >
> > If you want to compile this driver after v6.6-rc2 (which includes
> > commit 5eb1e6e459cf ("i2c: Drop legacy callback .probe_new()")) better
> > use .probe here instead of .probe_new().
>=20
> Thanks for pointing it out.
> I switched to v6.6-rc3 and I will change to .probe.

Note that you can use .probe (with that prototype) already since
v6.3-rc2. So there is no hard requirement to go to v6.6-rc3.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gahfz3hanrircdwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUV5oAACgkQj4D7WH0S
/k4esgf7BLpFWcXJXdhUexxP4+lc7WqPmab2RU67NFt7RdHv88Da4TAqWR+H7oWD
KJ1C8M59Ko+CV2jwfyCsef5tHE7WYlVUQOZixU+It/DOOY0r9wTOgt1B+iYl7BF9
vlfKNolt5AAlWMbunLjot7h3/37+mXLV+5JWMOBu/pmo6R1FM8mduXVJ7mdSZfRj
hWDuGnfTysXg60mPgVhMfjGNRkgc5qfmt/ec4Cf9uznBKfm8SbtH1oy4Ucs+uGtl
WaqtKfNh+shFge+7maB/JUo/bur8IO90K+Tadf4Gfh9i71J3RZKBQZioiWlaAyAX
skxOOb/jTr0UPgpUqnuINOcaTDoQFA==
=QnTw
-----END PGP SIGNATURE-----

--gahfz3hanrircdwo--
