Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0786785FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbjHWS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjHWS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:29:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024EE66;
        Wed, 23 Aug 2023 11:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 804E3659E9;
        Wed, 23 Aug 2023 18:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF20C433C7;
        Wed, 23 Aug 2023 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692815377;
        bh=CK9pfhRAr2sj6hvtODZEGD2McXjU/G0SstabFxuZD9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7Su83kd8OIoiHWbfI1O/NqAMfWjj3bn82+QObZJEzWrPH04pegksgZ3I5p5iEHFy
         Kek0TA+DqXYnddqxN4/EnUU779EpBeJN4EINmTWjtfupP7FQe7W0IgAhzzmOKskXUA
         v8VUSCqYHn22WMuOW4cPlBiDYt/5nfbuGnDK8VQGWvCDSe/hYz2XfXzpQqulAxGyIm
         EmQYjDm3EkYi9psdbpzsTHpquOobEHYJ7Pk0sk38K8hcrralxSOcl69iJfhME71gmO
         3IhGHq9zcD45uvpq70cLxoRvX/3vllylB9RKVtE9aySpO6FH/azLxavEo2ZjgC0vqT
         5TgNIqRtUe3Yg==
Date:   Wed, 23 Aug 2023 19:29:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: add sc7180-lazor board
 bindings
Message-ID: <20230823-panoramic-frying-e31a5a10f764@spud>
References: <20230822094414.123162-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230822174101.v4.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
 <20230823-raving-either-fb7bdb98b846@spud>
 <CAD=FV=U2kHPu2coSniUXfDJH8gYMV6115NKkyS7Rt4mEx4fzew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SKRkslrplaWXv46m"
Content-Disposition: inline
In-Reply-To: <CAD=FV=U2kHPu2coSniUXfDJH8gYMV6115NKkyS7Rt4mEx4fzew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SKRkslrplaWXv46m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:17:17AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Wed, Aug 23, 2023 at 8:11=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, Aug 22, 2023 at 05:44:13PM +0800, Sheng-Liang Pan wrote:
> > > Introduce more sc7180-lazor sku and board version configuration,
> > > add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> > > add new board version 10 for audio codec ALC5682i-VS.
> > >
> > > Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.g=
oogle.com>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Conor: any chance you could reply to v6 (instead of v4) and add your Ack?

People need to relax! This seems only to have been sent yesterday?!?

> https://lore.kernel.org/all/20230823151005.v6.1.I26e017b00a341e7a5a2e94a8=
3596923713408817@changeid/
>=20
> I _think_ the v6 patch series is in good shape so I don't expect
> Sheng-Liang to have to send a v7. I'm worried that your Ack will be
> lost if it's not sent in response to the v6 patch.
`

--SKRkslrplaWXv46m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOZQDQAKCRB4tDGHoIJi
0nUvAQC7H1J8ukVJW0bjPsfIYR14XdALTP4WW6egIyzKAO2fEwEA3Vm5g3JnIF5n
jWHoRp8fgmYxdSpj4C5Vr7wVGUbRoQ0=
=ojeQ
-----END PGP SIGNATURE-----

--SKRkslrplaWXv46m--
