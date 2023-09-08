Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A86798935
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbjIHOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbjIHOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:50:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0498C1BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:50:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qecnr-0000rL-8z; Fri, 08 Sep 2023 16:49:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qecno-004tzA-BR; Fri, 08 Sep 2023 16:49:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qecnn-00HTuj-3Z; Fri, 08 Sep 2023 16:49:43 +0200
Date:   Fri, 8 Sep 2023 16:49:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7717@gmail.com,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED
 algorithm
Message-ID: <20230908144942.d3feisuyctppfb3l@pengutronix.de>
References: <20230130093229.27489-1-nylon.chen@sifive.com>
 <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
 <CAHh=Yk8R02NXK33aogQeJQB6x88B_gpbnjHj9wRrJEbDQf67Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sko3m4welni3xxse"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk8R02NXK33aogQeJQB6x88B_gpbnjHj9wRrJEbDQf67Aw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sko3m4welni3xxse
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 08, 2023 at 06:41:00PM +0800, Nylon Chen wrote:
> Sorry it's so long ago.
>=20
> I have completed the implementation of the new version, but there is
> one thing about this letter that I still don't quite understand.
>=20
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=
=B9=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > > The `frac` variable represents the pulse inactive time, and the resul=
t of
> > > this algorithm is the pulse active time. Therefore, we must reverse t=
he
> > > result.
> > >
> > > The reference is SiFive FU740-C000 Manual[0].
> > >
> > > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86e=
d8b16acba_fu740-c000-manual-v1p6.pdf
> > >
> > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > ---
> > >  drivers/pwm/pwm-sifive.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > index 62b6acc6373d..a5eda165d071 100644
> > > --- a/drivers/pwm/pwm-sifive.c
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > >       /* The hardware cannot generate a 100% duty cycle */
> > >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> >
> > The same problem exists in pwm_sifive_get_state(), doesn't it?
> >
> > As fixing this is an interruptive change anyhow, this is the opportunity
> > to align the driver to the rules tested by PWM_DEBUG.
> >
> > The problems I see in the driver (only checked quickly, so I might be
> > wrong):
> >
> >  - state->period !=3D ddata->approx_period isn't necessarily a problem.=
 If
> >    state->period > ddata->real_period that's fine and the driver should
> >    continue
>
> I still don=E2=80=99t quite understand the description of this paragraph.
>=20
> state->period !=3D ddate->approx_period seems to be used to compare the
> results of the previous and next two times.

There are two things to consider:

 - usually the hardware doesn't support all requestable states because
   the hardware's quantum is > 1 ns. That is, it might for example
   support periods in the form (160 ns * i / 3) for i in 1 .. 1023.

   If this hardware runs with i =3D 500 (that is period ~=3D 26666.66
   ns) because the first channel is configured to run with period =3D
   26667, and .request is called for the 2nd channel with .period =3D
   26700 ns, there is no need to refuse that, because 26666.66 is the
   best possible approximation for 26700 ns anyhow.

 - .apply is supposed to implement the highest possible period that
   isn't bigger than the requested period. So in the above case even if
   the hardware runs at 26666.66 ns without the possibility to change
   that, a request to configure for period =3D 30000 ns could succeed (and
   keep 26666.66 ns).

> Would you suggest I send the new implementation version before
> continuing the discussion?

Note that the above implements the optimal behaviour for a driver.
(For some definition of "optimal" that admittedly also yields strange
behaviour at times. The reasoning for this to the be thing to implement
is, that's the corner cases are easier to implement, idempotency is
possible and it's easier to work with than rounding to the nearest
possible value.)

While I'd like to see the sifive driver to implement this optimal
behaviour, it's not mandatory that you convert the driver to that
behaviour. Just make sure to not make it worse.

So to answer your question: If you understood what I wrote above and are
motivated to improve the driver, it would be great to do that before the
next review round.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sko3m4welni3xxse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT7NIYACgkQj4D7WH0S
/k7+OQf/aB4uHhJdqYMAfP5Rn5iRxbBRaaQLJXyjJR+bimx8Ifz0f8kzeyYTS25Z
TL/+jlQhpkbjafGdXzxd85LaVch+7shaSohfzWs824wO85zDRk1CgjQ7q69mmdtN
A7lecYRDNxIT5/bYV9E/xizIs2RMWJ7o21mrFJiJxwY4B95CP/BSpIqAURkRN7KQ
35yVWF/KxFrKKkJ4xgvt/g6AzAlqqphRrjLNugi8AMY19w0kiIqCifrnMkgNZ71c
9fZqHhqo5x/dxm0pbOMoMvEkK8ZcEdS6bfV9P5iaiXUvnehkKnQnrj9yr3hOqGAm
XshPrgtNxkkPdbH++33xOMQZ7tNd/g==
=ZZNC
-----END PGP SIGNATURE-----

--sko3m4welni3xxse--
