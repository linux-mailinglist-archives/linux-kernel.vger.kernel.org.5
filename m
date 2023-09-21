Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831637AA1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjIUVGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjIUVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:04:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FBB7B95D;
        Thu, 21 Sep 2023 10:37:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C8C32777;
        Thu, 21 Sep 2023 09:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287817;
        bh=L+vZhOZ+kADCdlkNh/ewNubAwKMK2F34h8/SL9SRhQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKwFLd0jXAMRuLlul0c7VWcfGPByInmWP9KdPOz1MKQ1gd5QXckHnTdP0YYEeWceh
         DjIlUty4xIaEJqfl0PTnLlfU0/Zm4fyf7hSugAD4u6Khs3T+6FEI4TmOSSvndtfNoA
         FcRl75SSu//v5N6Yzm/5uTnBvmUsX4yRIs21Af8BYv0RL2fUSqeNpPbp7e3fnJ5nyL
         lPDqaFY2VXA9FG/KtikMTNuYOiiiNQapMA+/jEdL/LghBhbOMJtNXaO+70IMbKn8ew
         8jJwFAp5GrxCTtKnjoH8V9/nMZStYWqRv/TVdfgVRbrUyDhlb2d/K43pTqtedLCYT5
         0RbVJIPSbCGiA==
Date:   Thu, 21 Sep 2023 10:16:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: thermal: mediatek: Add LVTS thermal
 sensors for mt7988
Message-ID: <20230921-552234bd29791cbdcd037a2c@fedora>
References: <20230920175001.47563-1-linux@fw-web.de>
 <20230920175001.47563-3-linux@fw-web.de>
 <31fbdae8-d41c-358b-c8ea-6ee31b158dfd@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yu54HnRP5ZgUSnoq"
Content-Disposition: inline
In-Reply-To: <31fbdae8-d41c-358b-c8ea-6ee31b158dfd@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yu54HnRP5ZgUSnoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 09:55:46AM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/09/23 19:49, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Add sensor constants for MT7988.
> >=20
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--Yu54HnRP5ZgUSnoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQwJ/gAKCRB4tDGHoIJi
0miwAQCKJ0wVlAlz1nuHioGwDLUxrjxPyHOl3leR4myna8AQdAD/eX7X9YhwjllL
Nsb24tuvDQAHgMvN/gj+zYyrG9Nevw0=
=7RDp
-----END PGP SIGNATURE-----

--Yu54HnRP5ZgUSnoq--
