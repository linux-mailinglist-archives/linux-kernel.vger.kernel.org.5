Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5875C7E82F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjKJTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346525AbjKJTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:43:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23C29509
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:26:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D368C433B6;
        Fri, 10 Nov 2023 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699640817;
        bh=//+1dDG48RxoB34op9WnKpQOYu+pia2AtdgY57qSGLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8WYCXUex+ppIwdfM0LjitjhzijK6TZXEcSwIebEgQ3GOAO7UnVlxsupaq2VoYLC4
         Yh4W3b4VHx4k/zUGzSAZjnA12cuftE6C1Q8t6t7obYTYbI++iZG772pN/nRQm4D3IL
         5EZcp501bBGcNE3RIEsVmkN/Xt9POxz2bhJlDh7JuGUZAblW+XJv5k+K0Cs7BTrpY3
         GOKcUWNvNzlDkGRLbDrJ+7MtbejwoY2RLY+OQkgp8oq3Evh+5V1EUSQ1F51ukSc+xw
         qm3FEyYaBPHHWZ7N3Av1SWXOZrHgnLGmOfT2lh+uV/MRKQtqeY4jLvZwlXlLoiqNk9
         PfCie3iJEbl/g==
Date:   Fri, 10 Nov 2023 18:26:47 +0000
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
        Nicolas Belin <nbelin@baylibre.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 02/12] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl:
 add example covering meson-axg-hhi-sysctrl
Message-ID: <20231110-mascot-dollhouse-83f691dfa1ce@roley>
References: <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-0-81e4aeeda193@linaro.org>
 <20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-2-81e4aeeda193@linaro.org>
 <20231109-dictator-hedging-94b0dec505b5@spud>
 <046062f4-e415-4c3f-a05d-81bef9857649@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5w/g2E24/WOxYVxa"
Content-Disposition: inline
In-Reply-To: <046062f4-e415-4c3f-a05d-81bef9857649@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5w/g2E24/WOxYVxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 08:50:58AM +0100, Neil Armstrong wrote:
> On 09/11/2023 18:34, Conor Dooley wrote:
> > On Thu, Nov 09, 2023 at 10:00:03AM +0100, Neil Armstrong wrote:
> > > Add a thirst example covering the meson-axg-hhi-sysctrl variant and m=
ore
> >=20
> > What on earth is a thirst example? Some sort of "hysterical raisins"
> > type of thing?
> >=20
> > My confusion about that word aside,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Indeed, I'll fix this bad typo :-)

TBH, I thought it was intentional!

--5w/g2E24/WOxYVxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU514wAKCRB4tDGHoIJi
0sAoAQD6Sj0Me4v2FpLbfFQZfZK67SGa5V4LFec/ta5m+t6KBQEA6elLz7R9xNnC
0qtqNVWQEY1i0Kf4yBRSUOGQOB6qJAA=
=LCNw
-----END PGP SIGNATURE-----

--5w/g2E24/WOxYVxa--
