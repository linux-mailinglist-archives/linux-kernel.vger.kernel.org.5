Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19880F278
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjLLQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLLQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:29:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061198
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:29:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944BAC433C8;
        Tue, 12 Dec 2023 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702398583;
        bh=4JW2S8XtH2w0oEakH/oOgs84YyeslEKxjY8L2izjfDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUMX9KRLgK/+PuRSRYFVx98x9iA0mSlMupFig+yV0Uw5dFXtiUNE406wFDEwI22l9
         iP+br3B9xrKSyP76l6Pff/jLfR+X4sMQjOrgUMiM0/GvjuG34XXlSGcEa+X+QG6THd
         Uds+8/topXVekPryazuwUyuLpJk8bXXwibuyOKR+4W16ORWQyk3lv94goxS/eEOCeS
         ynLhYh/YBWQQ5YaX98NbpRQzUGcyD3Nttu8a00ol+S2d61QwbpaaE/Wb5O7/S/mKV9
         oK3+qT19TFPUAJEnKBz4mNLWouagrb35WTWBNUXWXpm2oYfDLn8yQ5zd7YdOFSMqwJ
         KHZEI4f2RUZ9A==
Date:   Tue, 12 Dec 2023 16:29:35 +0000
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
Subject: Re: [RFC PATCH net-next v3 6/8] dt-bindings: net: mediatek: remove
 wrongly added clocks and SerDes
Message-ID: <20231212-operative-stubbly-2104c96bdee5@spud>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <5859da6629b8b6c100eca4062dd193105bf829ba.1702352117.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+o7guYCYluYJGIdc"
Content-Disposition: inline
In-Reply-To: <5859da6629b8b6c100eca4062dd193105bf829ba.1702352117.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+o7guYCYluYJGIdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 03:48:10AM +0000, Daniel Golle wrote:
> Several clocks as well as both sgmiisys phandles were added by mistake
> to the Ethernet bindings for MT7988.
>=20
> This happened because the vendor driver which served as a reference
> uses a high number of syscon phandles to access various parts of the
> SoC which wasn't acceptable upstream. Hence several parts which have
> never previously been supported (such SerDes PHY and USXGMII PCS) have
> been moved to separate drivers which also result in a much more sane
> device tree.
>=20
> Quickly align the bindings with the upcoming reality of the drivers
> actually adding full support for this SoC.
>=20
> Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth bind=
ing")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--+o7guYCYluYJGIdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiKbwAKCRB4tDGHoIJi
0i6mAP4xedv8lwi5+7mG3Qv7H3gtEeZ+DpqQpCRsutWbDn8KZwD7BsjQ2fZrh+hO
LiWdVCZSG8Ibj8eKPbm5Qai3qluMGgA=
=F1mi
-----END PGP SIGNATURE-----

--+o7guYCYluYJGIdc--
