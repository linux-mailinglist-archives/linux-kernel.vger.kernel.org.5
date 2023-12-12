Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADBC80F258
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjLLQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjLLQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:21:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DDD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:21:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6B8C433C7;
        Tue, 12 Dec 2023 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702398106;
        bh=I4hXkEoUTFcolc2OptvZYGQLuDHWI9mD2TQ75fDGAEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaJ/cK3ae/NyZnW+kIfXD31ZVQhxWOZvEpEiCVaZ2axAEt8mVlkfRPOH7ZSZz1vbq
         DLCfEavz6/qjkfAjqzIjV1AHKLEKaNugKFiqJZ3wgh+siQAnwmyOiaSO71VYUtuMAw
         5yp5ECVxUihw9upcoHDCAEwoE53y+gipQccjtaUeNeCpnwvzeVQPmzD+ycWnGs3j8n
         Nfsl9d2RQwEA9bvLFqEbgmlPTy5ACynj/IAbZyLZzi+ZKxHjg/s32OCuwLJuS8K9ol
         V5Pa/ygKBO/eCWPJ3UTgIVD/om+8hOznatNNxeZbuDcUn6NZb2Gj5R2KXnEldsah5A
         wL0bvkZNkNtTg==
Date:   Tue, 12 Dec 2023 16:21:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 1/8] dt-bindings: phy:
 mediatek,xfi-pextp: add new bindings
Message-ID: <20231212-renderer-strobe-2b46652cd6e7@spud>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <b875f693f6d4367a610a12ef324584f3bf3a1c1c.1702352117.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WPQBtHmwAqf+kt5+"
Content-Disposition: inline
In-Reply-To: <b875f693f6d4367a610a12ef324584f3bf3a1c1c.1702352117.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WPQBtHmwAqf+kt5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 03:46:26AM +0000, Daniel Golle wrote:

> +  mediatek,usxgmii-performance-errata:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      USXGMII0 on MT7988 suffers from a performance problem in 10GBase-R
> +      mode which needs a work-around in the driver. The work-around is
> +      enabled using this flag.

Why do you need a property for this if you know that it is present on
the MT7988?

--WPQBtHmwAqf+kt5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiIkgAKCRB4tDGHoIJi
0igfAQCIaKPOwiNl671rEJW649XaWHfBlXjLZAGVfwCmX2BsbQEAyKovajF2JIX8
oC8ansV48AdAaqaRErICzJeNb8cD4gg=
=vMqS
-----END PGP SIGNATURE-----

--WPQBtHmwAqf+kt5+--
