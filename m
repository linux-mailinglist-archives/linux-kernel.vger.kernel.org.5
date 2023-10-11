Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5B7C56A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJKOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjJKOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:21:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDCA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:21:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DE4C433C7;
        Wed, 11 Oct 2023 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697034071;
        bh=2gpLjyqUi6wcjJjAwFjG693BPOH5KzH0g4x8Uy+z3TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWkuPTZWxq7VqSIH5U9qpBsgJvX1VZMMRSMMB2ruW/80qHsTSP/8yLlmPr9otIEfl
         50GofoSBBobrbKfk9FChIXKZI7uU54+yXYNK7ujGNXaPNhwnTI+SKGVXqDzHlwhoMA
         cJ/0x17C5B+oTd92yl+oQolj1YN9x+NJt/U+6wCgsGHG/znA3JVPVFGBflSmmBMnSE
         /uw1M6puMBDLYPIc815P1UN2VGiyXNt+grmXMuTAJuqmKjBxXT26F5bo3vQT3uPh7p
         R6s2z3dhNe3nzODxN43Ak8fFffsWsnOuyRKJiJ3MaT/JbHZAwURGNltmhJDUx+PeOq
         KUrhAtp7Egd7g==
Date:   Wed, 11 Oct 2023 15:21:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mark Tseng <chun-jen.tseng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 3/3] dt-bindings: soc: mediatek: add mt8186 and mt8195
 svs dt-bindings
Message-ID: <20231011-motor-equator-db141b74726a@spud>
References: <20231011034307.24641-1-chun-jen.tseng@mediatek.com>
 <20231011034307.24641-4-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zBOX+bhAlTIL62fW"
Content-Disposition: inline
In-Reply-To: <20231011034307.24641-4-chun-jen.tseng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zBOX+bhAlTIL62fW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 11:43:07AM +0800, Mark Tseng wrote:
> Add mt8186 and mt8195 svs compatible in dt-bindings.

This commit message just repeats the contexts of the diff in prose.

> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--zBOX+bhAlTIL62fW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSavUgAKCRB4tDGHoIJi
0sqKAP9Z6J6MQ/uOMPuXIPe5q8SmKRkNtaXcVNBweiVeryHgeQD1F2xJdjmsESzy
iLjBjIDhUP9NvRUTQD/+6R2i+r1OBg==
=pNdI
-----END PGP SIGNATURE-----

--zBOX+bhAlTIL62fW--
