Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7677A6062
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjISK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjISK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:58:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF5114;
        Tue, 19 Sep 2023 03:57:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2E4C433C7;
        Tue, 19 Sep 2023 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695121061;
        bh=rgkEHzS1P2+GGnG5W33Ph4ysUqmd/eb2iIGx9omjpvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xhbn8JD6cfQMx8xR+PU3g5QAAmLNxJv3xNP1Ho+oV8lXgW6zWTw3qXvcARVgU7Wfr
         sUNZYHdnYNdWFNVcUx+jVb0TJ9Iw1SgJacseBhE5q1nHoaraprg8K7+tigNTIGYnm3
         g4Hey3mLWEVrl7BkCXJkFr9uy/7BNIrkGkYBIMXh9L1vP4PaFA7BPfjTrG8ckoEDdT
         keWQxOVG8bHvqB7wSgv1q3uvtrjuRZId3hzoCrxUVYmnVKao3DQuQaieLBW6ZwCohm
         Jej6EoiX+OfNKq8SrqZtONz2suiXBG17mnbkkNuyljP+F2pD6vMQ/ZiNRWIphxD7/e
         V714Ep4Kg7rsQ==
Date:   Tue, 19 Sep 2023 11:57:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: Re: [PATCH 1/2] media: dt-bindings: mediatek: Add phandle to
 mediatek,scp on MDP3 RDMA
Message-ID: <20230919-6c70a74fa46fa4b298764ce4@fedora>
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com>
 <20230919095938.70679-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VPROubqw5lKdslhi"
Content-Disposition: inline
In-Reply-To: <20230919095938.70679-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VPROubqw5lKdslhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 11:59:37AM +0200, AngeloGioacchino Del Regno wrote:
> The MDP3 RDMA needs to communicate with the SCP remote processor: allow
> specifying a phandle to a SCP core.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--VPROubqw5lKdslhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQl+nAAKCRB4tDGHoIJi
0vTHAPkB522lK8X8euYhusx64TpJF2vQQOJR1RjAvmbcREUgFwEAh7u7X/ovyasV
iE0cp6ttCXGMYAnwPH4WEyu7sYGokws=
=xseb
-----END PGP SIGNATURE-----

--VPROubqw5lKdslhi--
