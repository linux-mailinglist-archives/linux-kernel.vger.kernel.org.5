Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745447F651E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjKWRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbjKWRS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:18:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3ED46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:18:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6FEC433C9;
        Thu, 23 Nov 2023 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759914;
        bh=4uuYv4ivuEW0QNa8dUnLLuSPDWYlT69BIfr2llFRLnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VciWPKaDUoyUh1FepWZVBgnEAvCej2jGYm2TSGV21kR6rxT2wHdKYHWulmTMoEseV
         QJusH27Z2ZudBxQ1B7xUrUc9F4ScACAMaLstO7vxgwRI77pW+krMbgdRx0Rrp9b8Q1
         PNEsnqINMuYcAspPMGU0UN0hwXfgGqIxek4NNPZ/xITtRw2uXqBEuyw7S+v9NBAcFo
         L0HW1CeTZJra/bOWhtwwHUl9sKInrZ7VuduC4xYij7KkMbxYpWUawG84Z046Kzoo14
         R4WVMicENkQ6N3XbwHcxg/0VgPHaVVXdNT7du6iXWx1pXsOn8M4QQRqCGmpN4EhRX6
         VePnpFLDsd0nQ==
Date:   Thu, 23 Nov 2023 17:18:28 +0000
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
Subject: Re: [PATCH 1/4] dt-bindings: display: mediatek: dsi: add compatible
 for MediaTek MT8195
Message-ID: <20231123-wipe-starch-741e674c1f54@spud>
References: <20231123133749.2030661-1-mwalle@kernel.org>
 <20231123133749.2030661-2-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gjaPXcNp/j7dUovY"
Content-Disposition: inline
In-Reply-To: <20231123133749.2030661-2-mwalle@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gjaPXcNp/j7dUovY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:37:46PM +0100, Michael Walle wrote:
> Add the compatible string for MediaTek MT8195 SoC, using the same DSI
> block as the MT8183.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--gjaPXcNp/j7dUovY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+JYwAKCRB4tDGHoIJi
0k5mAQDNhAGJgE8ZQcNenl97mgSMbjnMQQZT1j8Z6HsCMI1JeQEAm8dsDuvsCcp8
mPJKmSYIoy4Aes//J8lAQpbhat4N6wY=
=3Y9w
-----END PGP SIGNATURE-----

--gjaPXcNp/j7dUovY--
