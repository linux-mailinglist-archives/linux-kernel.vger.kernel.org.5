Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203D57D12FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377778AbjJTPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377769AbjJTPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:39:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE681D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:39:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtrat-0004Hd-RC; Fri, 20 Oct 2023 17:39:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtras-0033gL-9T; Fri, 20 Oct 2023 17:39:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtrar-002bLX-Ve; Fri, 20 Oct 2023 17:39:22 +0200
Date:   Fri, 20 Oct 2023 17:39:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-pwm@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH V15 2/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <20231020153921.54m3pg4ocb4wy4jn@pengutronix.de>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-3-quic_devipriy@quicinc.com>
 <20231018204608.qyifcnnzgi2bgzn6@pengutronix.de>
 <CAL_Jsq+df_nmNVuf46-a5Dafe4THxD-5HS-BPsTn_yzTckrOJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qb63ejcofu46z6d"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+df_nmNVuf46-a5Dafe4THxD-5HS-BPsTn_yzTckrOJw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qb63ejcofu46z6d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 20, 2023 at 10:14:48AM -0500, Rob Herring wrote:
> On Wed, Oct 18, 2023 at 3:46=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Oct 05, 2023 at 09:35:48PM +0530, Devi Priya wrote:
> > > +  "#pwm-cells":
> > > +    const: 2
> >
> > The driver only supports normal polarity. Is this a shortcoming of the
> > driver, or is the hardware incapable to do that, too?
> >
> > If it's only the former I'd want #pwm-cells =3D <3> here. For ease of u=
se
> > I'd not oppose if you pick #pwm-cells =3D <3> even if the hardware can
> > only do normal polarity.
>=20
> Devi, Can we get an answer here soon.
>=20
> The MFD part has been applied and it references this schema causing
> warnings. So this needs to land or MFD schema reverted.

Or the reference to the pwm stuff deleted from the mfd binding?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7qb63ejcofu46z6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUynykACgkQj4D7WH0S
/k48jQgAmXt8jVXBYTItnGzsR/oCdJ99o6oIa2BvsxBL50ugA62CUaeC83anLO1a
qOrcp+6bNp+XAZpxNOirz3EeQKLrLQ+qpb/1fNBn4+e1YT7zv3MMXQesZWt7fhN1
OZ3pBJktPyO9ozHKXuTTOiTUwuKPPfJemCDMAEksxTCa9Wu3hgdMcjG7CmFN0XDI
Tl8XEyZIbN8h+FZDx6GTeVcr6AVy/m+ntGIY4EhLMPjNzG1HPVfWFCeIo0L9trzk
PxM3UkBQbepxL3faE+2V1J5grhNdsOH0y+avnw2jQvWMauopMpSRRtWj1WffPowd
c8b7t3zQV1HkugMxC8hE//Ph/krjyA==
=kaZT
-----END PGP SIGNATURE-----

--7qb63ejcofu46z6d--
