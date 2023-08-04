Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799E770502
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjHDPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjHDPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28549CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C844D62077
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3022BC433C8;
        Fri,  4 Aug 2023 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163599;
        bh=bkzit33VmdoUD6BWlsNFe9JgzY2f8SKPYIRIBtcatOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/wmZHiopppHK/MJlnx0llX9Mksf28G/kXdY8g7/v4ybME3mj4mfRGE4txu7To0U4
         D0DMqYnGWtVRN3lndOCOG5m+5uMh8laySuwipdk/uJQ4HJGUC8itVTsLuNcMKdfl2s
         MR+VcmtgeKVECnsWusAU/h1GR3PJcsLkqmWNRYn4ppQFJmifI5/XhiHymw+docKAD9
         C4mzEuj/Hr8CW8OFokEcGN9Kufe1/P5/TAjPy2B2KIogrK8jGerBeHyhw6FjXIWbr3
         uAwE1W/fmb3mSdcVu/RH3zHN5C+d5WYA9y5NCMpfok1DJRWQhhhpRhZ9Ax5wRE4bgr
         suzrzYJWsK6Ow==
Date:   Fri, 4 Aug 2023 16:39:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power
 supplies
Message-ID: <20230804-track-polymer-dff0f803645d@spud>
References: <20230803215506.142922-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L0gVLHdTSEnPRpVf"
Content-Disposition: inline
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L0gVLHdTSEnPRpVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 06:55:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> WM8960 has the following power supplies:
>=20
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
>=20
> Add them to bindings to improve the hardware description.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--L0gVLHdTSEnPRpVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0bygAKCRB4tDGHoIJi
0os0APwJQfgW205aF/eC8Y0ogViquNkLqRfa0+Pg/XQRRW156QD/Z10cvSfoQX1b
wvrDDHnT/uKDDleuREkMlMuf2E8PVAA=
=36x1
-----END PGP SIGNATURE-----

--L0gVLHdTSEnPRpVf--
