Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433AA7FD813
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjK2N2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjK2N2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B7CA;
        Wed, 29 Nov 2023 05:28:31 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1644D6606F5E;
        Wed, 29 Nov 2023 13:28:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264510;
        bh=4usmAEazxjJcK1yS+bx4LByLPrRqrN3n8pR4Vwqt66M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBFCLegwWw6vrecTHfGfBfMknsuUlBoP8Yo4UA6nCfYv0okD345ZaPnvZj5ZKmQCA
         4dJXwmvwOInjJ3LStbKL6HK7qrNbRPXrpH4zhuW9OwWNar6mcVC+JzdmjU9NFn8cLZ
         06jbxh24j+JvANDGgYHHkmClDW/kkDHMBl8OFJ/loxZgTyGRR9XtOcirMDQhDOqwTA
         WiQd8HgA3McaPBsHpFdhYzAtoAqz8XYktG96luiJuxwhX5UZ3C3Vs+y+pVvpKC8VLs
         wROgdU94+cfZAfI02Ki5ffpymaG2kJy1nPE032XKPtmPlgIoTMUjaJLtrRc9kDkXG+
         stJzBA623c6Hw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v4 1/7] arm64: dts: mt8183: kukui: Fix underscores in node names
Date:   Wed, 29 Nov 2023 14:27:36 +0100
Message-ID: <170126437823.153055.1015143470789500363.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026191343.3345279-2-hsinyi@chromium.org>
References: <20231026191343.3345279-1-hsinyi@chromium.org> <20231026191343.3345279-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2023 12:09:10 -0700, Hsin-Yi Wang wrote:
> Replace underscores with hyphens in pinctrl node names both for consistency
> and to adhere to the bindings.
> 
> 

Applied, thanks!

[1/7] arm64: dts: mt8183: kukui: Fix underscores in node names
      (no commit info)

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
