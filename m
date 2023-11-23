Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DBA7F6524
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjKWRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjKWRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:18:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B810D0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF7C433C7;
        Thu, 23 Nov 2023 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759942;
        bh=o2B91gSRao1cm4mdpvvnT+cSLBigCNcp+xOQKNDn4A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iahmJvGwt/0+ze9HXyRn6fXTXrsOTmscoofcYH5cE64Jn+7Zl8OLC1CsQeuehJrOY
         6Nj1HThnyqA4d+fAqJBUcrJxXD+QW0B5pIjUwP3GoYDMk0i2jNOWHXxCObeyDUEJPg
         BK87uBg791nuLw0vqhA5LNrgFRDeXfzXCV28zeFMgyTI03tZoEtN5phBiD3/o1MaYP
         bHJIRWj06VnuJSLrOEyQsSZGuoaf3eWlidsEtc1uc0u8MOPZOAt8EUGrYiwRaSEXjU
         moXac9FzCSAkQ9lEp26WhADWaZJd124nbIfpyxM6Qqeo2RGdvvjSDZSG+dPnE3Kkhh
         As2xxVshd2euA==
Date:   Thu, 23 Nov 2023 17:18:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: phy: add compatible for Mediatek MT8195
Message-ID: <20231123-atypical-gradation-d98b95e9c416@spud>
References: <20231123133749.2030661-1-mwalle@kernel.org>
 <20231123133749.2030661-3-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ji3UuPhd3xxexBJ5"
Content-Disposition: inline
In-Reply-To: <20231123133749.2030661-3-mwalle@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ji3UuPhd3xxexBJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:37:47PM +0100, Michael Walle wrote:
> Add the compatible string for MediaTek MT8195 SoC, using the same MIPI
> D-PHY block as the MT8183.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ji3UuPhd3xxexBJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+JfwAKCRB4tDGHoIJi
0vWUAQCIxBJSBYQxfxnK0ADmbM0UaJC+Lie7AsTjs/2zhG8mjgEAjeZIyAzwtVtq
+xaFexacDMYRWoecls9a4vRISuN+1wE=
=mQTP
-----END PGP SIGNATURE-----

--ji3UuPhd3xxexBJ5--
