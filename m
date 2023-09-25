Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7327AD7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjIYMSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:18:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF82ACE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF963C433C8;
        Mon, 25 Sep 2023 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695644319;
        bh=+JXbgHqUQ0aKUPdu2YpA/gNhZEobY1Ib1Js2eZ6C4y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSFJXhqMU2CPq714eb0uq2pEc9nv8j/cwX+sX0cQkJMfFGxsIUDvhY5cV5xmCjd/M
         E1Hxf1DTQu5ojdO+6Wag6OTSsxYBgjPYjej15Hg5GhS4f+28eePgmg59pIKGs/1DHj
         upDFAiWEv+IkeCUZczfxORA8SP1okbOUkEs63qVemIMTACFYGMrdRuFSM4CX5eBNG6
         IuG3MXPG31SSkyJi6STlJMcc3lZZo/h6r1SmCr4xHEHAY51n6ljSYHevI4vqxMVU4m
         EgebJXe+2nOqKz+eHk1JiT/RppNwmHnbVrMUVsStzmkQi4tFfD/2Mpoo5cUc8mYHXF
         xZRyr7aR78lwA==
Date:   Mon, 25 Sep 2023 14:18:33 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 07/12] regulator: mt6358: Add supply names for MT6358
 regulators
Message-ID: <ZRF6mbpswWoxdJsl@finisterre.sirena.org.uk>
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-8-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C03nZbIMQ4GsEMUt"
Content-Disposition: inline
In-Reply-To: <20230919104357.3971512-8-wenst@chromium.org>
X-Cookie: I had pancake makeup for brunch!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C03nZbIMQ4GsEMUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 06:43:50PM +0800, Chen-Yu Tsai wrote:
> The DT bindings for MT6358 regulator now defines the supply names for the
> PMIC.
>=20
> Add support for them by adding .supply_name field settings for each
> regulator.

This doesn't apply against current code, please check and resend (I was
using -rc3).

--C03nZbIMQ4GsEMUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmURepIACgkQJNaLcl1U
h9CZBgf7BZ9QaFpLALkLChBSjjaoNvvXZz88PigXkOGFHH1EzKUeQg2iA35QMiZU
5+HHyO01EtSiVuAAB7Ih/f1QjLgnaRc5rooaBYYgO2oy8TO7CDIs+zi58f5Rj3gq
ifKFsw/u3yfhd28Cg55RLbKugC/VmCjRD8fPthvhpSH9d4uKCwSwca4m5k48dUQ6
RuHHUSIr1lEbrL3cpsPUg65EYV2TQYFDPSZjLnqfpXvfna+a+JOnmYzT4WNBvwzy
wx0pVsbA5L+9FFuTPWWZlAbPL1gqnxaCVx4jnfaraolAciq53by4g59tbg4mkNoH
MFOeJQpe9yDMJaFeC1cWs0L6IZU4IQ==
=q4Ky
-----END PGP SIGNATURE-----

--C03nZbIMQ4GsEMUt--
