Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31F788BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbjHYO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbjHYO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E819AE;
        Fri, 25 Aug 2023 07:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D401862C7B;
        Fri, 25 Aug 2023 14:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD22AC433C7;
        Fri, 25 Aug 2023 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692973666;
        bh=UksBdrJBzm/E55qDKqtkZMez6Zo0v+Z97iw2xCA3TEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyZP72FBnStze+r9BnWyPApB1h7vLsXBKgwj5SOM62pRh892THuUfVJmFjcSERomT
         UN2YBoMdNNbvaJGrPgGwj/Vw3PYx3amtGKZGeFHeU4Vpem/NFeFF7cH+YEazBTsx0T
         +CSPYYEMxo9j9g0eEvFJRMcu4EaFjRP5fkAGCD1a8Cy7q1dKyN1cPrpWYagRTOHfjk
         vBtgySlby3pkTX1E1zhiynTYIyxthE2T6nIwUZ6LElorgVPCr/89BkTNynwJ5IlzMx
         SAi2tjLW9N7ZtthyI733S0lREiTHCTRbSfxxXaax4/HWXYgaSie6M6emrXmt2VjGxI
         N7Zmo0VEOHb0A==
Date:   Fri, 25 Aug 2023 16:27:43 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Helen Mae Koike Fornazier <helen.koike@collabora.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        robdclark@google.com, corbet@lwn.net, khilman@baylibre.com,
        sergi.blanch.torne@collabora.com, gustavo.padovan@collabora.com,
        linux-rockchip@lists.infradead.org, daniels@collabora.com,
        martin.blumenstingl@googlemail.com, robclark@freedesktop.org,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Subject: Re: [PATCH 2/6] drm: ci: Force db410c to host mode
Message-ID: <5xlfrdnutrncqdyal36222ka7qkgbtrixm3cpjk6reb7xu6zwu@nyiowsjng5k6>
References: <87pm3b2pkz.fsf@intel.com>
 <29c7-64e8b600-1-6afffd8@162524228>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uahdtp2khpso5z52"
Content-Disposition: inline
In-Reply-To: <29c7-64e8b600-1-6afffd8@162524228>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uahdtp2khpso5z52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Helen,

On Fri, Aug 25, 2023 at 03:09:04PM +0100, Helen Mae Koike Fornazier wrote:
> Hi Jani, thanks for your comments
>=20
> On Friday, August 25, 2023 10:56 -03, Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>=20
> > On Fri, 25 Aug 2023, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> > > Force db410c to host mode to fix network issue which results in failu=
re
> > > to mount root fs via NFS.
> > > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c1=
5c80a54dda510743cefd1c4b65b8
> > >
> > > Since this fix is not sent upstream, add it to build.sh script
> > > before building the kernel and dts. Better approach would be
> > > to use devicetree overlays.
> > >
> > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > ---
> > >  drivers/gpu/drm/ci/build.sh | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > > index 7b014287a041..c39834bd6bd7 100644
> > > --- a/drivers/gpu/drm/ci/build.sh
> > > +++ b/drivers/gpu/drm/ci/build.sh
> > > @@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
> > >      fi
> > >  fi
> > > =20
> > > +# Force db410c to host mode to fix network issue which results in fa=
ilure to mount root fs via NFS.
> > > +# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b=
8c15c80a54dda510743cefd1c4b65b8
> > > +sed -i '/&usb {/,/status =3D "okay";/s/status =3D "okay";/&\n\tdr_mo=
de =3D "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> > > +
> >=20
> > It seems like a really bad idea to me to have the CI build modify the
> > source tree before building.
> >=20
> > The kernel being built will have a dirty git repo, and the localversion
> > will have -dirty in it.
>=20
> Is it bad?
>=20
> The other option was to work with device tree overlays (but we still
> need to spend some time to see how to fit it all together)

That would be much better. libfdt provides an fdtoverlay command to
merge a base device tree with an overlay.

Do that while setting up the DUT and you're done :)

Maxime

--uahdtp2khpso5z52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOi6XwAKCRDj7w1vZxhR
xSBKAQDfFOVdXMCZ/9a7sggeX0OzQ2xZtgSgfdTEVanD/QmKiAEAo93ffgaueCJa
HBQKGvHTkvdsjLQGuuPJdVW683tzXAU=
=kd8L
-----END PGP SIGNATURE-----

--uahdtp2khpso5z52--
