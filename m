Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C67F769A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjKXOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKXOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:41:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ABC19A4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:41:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6B4C433CB;
        Fri, 24 Nov 2023 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700836911;
        bh=sN2GV7ooCULXSqP4A45dgDJT99C/q8vC8n4JoqkQwkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZlkN8TCzfmvQw+zzZzoOpOxWzQXubQmb+3KG6Pfqe6wOFk8DbHTn9r34srQLIBus
         +o2w6oBIEL2mjiwOjv0VeYMAp5wGtsfFjUkiw33gECaIJG5pcIV325wWOFM7uG03JI
         I9naTpaw78L/lfvDeYQT4Zg595YZXDZrCdsmCawd7Ej3YHUVAjUnpbQkzjy0iOVapE
         dzR3++E+TIqzu6LQo1qQxiRLZm1K1w/3o8hYpUzKgtg2TGzQssQQYd11Amp37xOs7a
         vA4DjYXZ/raNg4NI1JTeWa69+CkHTGEiuTWccZi0yl5rg7GPlGkQF4buv3e58zYSND
         CbXINWXgZKFGQ==
Date:   Fri, 24 Nov 2023 14:41:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 04/12] dt-bindings: phy:
 amlogic,g12a-mipi-dphy-analog: drop unneeded reg property and example
Message-ID: <20231124-vowel-reversing-619f7c4e5060@spud>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-4-95256ed139e6@linaro.org>
 <20231124-felt-tip-everybody-f2a6836e52af@spud>
 <c3a07912-07da-4965-94b8-3c0d8889ddc4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgsO/76B+uGPTN6M"
Content-Disposition: inline
In-Reply-To: <c3a07912-07da-4965-94b8-3c0d8889ddc4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgsO/76B+uGPTN6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 02:50:58PM +0100, Neil Armstrong wrote:
> Hi Conor,
>=20
> On 24/11/2023 13:36, Conor Dooley wrote:
> > On Fri, Nov 24, 2023 at 09:41:15AM +0100, Neil Armstrong wrote:
> > > The amlogic,g12a-mipi-dphy-analog is a feature of the simple-mfd
> > > amlogic,meson-axg-hhi-sysctrl system control register zone which is an
> > > intermixed registers zone, thus it's very hard to define clear ranges=
 for
> > > each SoC controlled features even if possible.
> > >=20
> > > The amlogic,g12a-mipi-dphy-analog was wrongly documented as an indepe=
ndent
> > > register range, which is not the reality, thus fix the bindings by dr=
opping
> > > the reg property now it's referred from amlogic,meson-gx-hhi-sysctrl.=
yaml
> > > and documented as a subnode of amlogic,meson-axg-hhi-sysctrl.
> > >=20
> > > Also drop the unnecessary example, the top level bindings example sho=
uld
> > > be enough.
> > >=20
> > > Fixes: 76ab79f9726c ("dt-bindings: phy: add Amlogic G12A Analog MIPI =
D-PHY bindings")
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >=20
> > I feel like I left a tag on this one before, but I can't remember.
> > Perhaps I missed the conclusion to the discussion to the discussion with
> > Rob about whether having "reg" was desirable that lead to a tag being
> > dropped?
>=20
> I checked again and nope, not tag, but Rob's question was legitimate and =
I reworded
> and clarified the commit message following your reviews.
> On the other side you suggested a Fixes tag, which I added.
>=20
> The rewording is about why reg doesn't make sense on the nature of the me=
mory
> region and it doesn't make sense here like other similar nodes.

Okay, I thought that I had given you one. Perhaps I forgot to send, or
Rob's message came in between me asking about the Fixes tag & replying
with an Ack. Sorry about that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--xgsO/76B+uGPTN6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWC2JwAKCRB4tDGHoIJi
0rfLAQCNolGZjIZg5rXxw9C1OMazRjRDdxd0RzNgb5+TM66JZQD8CbqSE3MjrSJn
SkJrWLo0HrWEEIlIb569LlFJT5w6QQ0=
=UnJl
-----END PGP SIGNATURE-----

--xgsO/76B+uGPTN6M--
