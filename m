Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F7808615
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378491AbjLGJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjLGJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:41:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C214FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:41:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1FDC433C7;
        Thu,  7 Dec 2023 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701942089;
        bh=Y3CgmiwT0nwbzFuDeivLJTvO+yngal+TXRGUMoTsXPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETxJbbtaTcAlVygNymX7fa0IBfzVOw9h7RMRHsVrgMJFO7/DHXEU3p3oom2RCJ7nB
         DTvXd/3xXSrX6AqQ/D2HFanevLa8heMRQTHls/M5iC05CULgq2qIp4VuEvnaYA1+Cq
         IrSHdWT8H72lI5VlF07dpKZHgvmeJnLx1ZsoH7v6TNxJrGLQElGu7vyhZFUew1/r9B
         lTFVH5XVuMJnL9MYrV4UQq/WAfrh8T7k/UNBc82JPHz+5qqfDi6QQiI3coWf0cU7I1
         MDxfdYQKsXpOP0af4lwEOtmfrxNIzKuO5UshxuV27+9qpZ5zyDvjiYFItSNjmG8w9d
         oLtwNBwfx7H5A==
Date:   Thu, 7 Dec 2023 10:41:26 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 07/10] dt-bindings: display: panel: Add Ilitek ili9805
 panel controller
Message-ID: <3tddld7exqsjaulhblyrp3x52sxgnmt3tn3elqv23dihlro27u@zi5w5tpmpo3l>
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
 <20231205105341.4100896-8-dario.binacchi@amarulasolutions.com>
 <20231206143345.GA2093703-robh@kernel.org>
 <a437b0d7-5669-45c1-b54d-ce028a57efdb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glic6emmr37gh3aw"
Content-Disposition: inline
In-Reply-To: <a437b0d7-5669-45c1-b54d-ce028a57efdb@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--glic6emmr37gh3aw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 10:29:12AM +0100, Krzysztof Kozlowski wrote:
> On 06/12/2023 15:33, Rob Herring wrote:
> > On Tue, Dec 05, 2023 at 11:52:54AM +0100, Dario Binacchi wrote:
> >> From: Michael Trimarchi <michael@amarulasolutions.com>
> >>
> >> Add documentation for "ilitek,ili9805" panel.
> >>
> >> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >=20
> > Where's Krzysztof's Reviewed-by?
>=20
> If only there was a tool which would solve problem of collecting tags...
> Easy to use one command for applying tags from mailing list, so one's
> review will not be lost thus people will not waste effort doing review
> second time. How was it? a4? b4? c4?

FWIW, a lot of people still don't know about b4, or a relying on
features/workflows not supported by b4.

Maxime

--glic6emmr37gh3aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXGTRgAKCRDj7w1vZxhR
xdd2AQCabCWZ6Xj4jdOlLg8F46quQFKp6kMwULbiCwnB4i00LgEA2eD7fEPp6v6d
1bPIomhtjcluNkZkByoriyToApxs5Q4=
=tGcR
-----END PGP SIGNATURE-----

--glic6emmr37gh3aw--
