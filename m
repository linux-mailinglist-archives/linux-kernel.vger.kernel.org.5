Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D267FD81B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjK2N2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjK2N2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3010FC;
        Wed, 29 Nov 2023 05:28:35 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE4D5660732A;
        Wed, 29 Nov 2023 13:28:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264514;
        bh=g+em6JqJZ00XbTVeewcZiGmqWrpvJAkV8acFNSWWYCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/7urABsZgqtZgA1BNQ8hGus2qaocBPrL9QSm1MvmYfaeZYo/BkwwgqGtER0AmTxB
         VfAZVwM+kR8cV7isyd3STG4fQeMxWnrV1o1ebsE7yAKmWJ12Wt2EfjDXXZlyThLA+m
         C8x20mLODITo0PKsvZ31+vFsKx9JSIRys32oO68Gpg+Ct/jSeVOkfxFe9MhMYrWJvp
         m4yVmoyJ0yPGebbVM8uGnqAvl4JbFJLCkymdU354CyWTCMHpQb3rtO2QCx9Wfc84mz
         7mftC5eXqkMczQGUL0F2X7yfl+AP3nLfVV3J2+i7v7kC+BzwRZvIhea3j1LXYSZRPR
         wXrGptJUIsGGw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com, Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
Date:   Wed, 29 Nov 2023 14:27:39 +0100
Message-ID: <170126437824.153055.13721908976403389958.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025170832.78727-3-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de> <20231025170832.78727-3-linux@fw-web.de>
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


On Wed, 25 Oct 2023 19:08:29 +0200, Frank Wunderlich wrote:
> All SFP power supplies are connected to the system VDD33 which is 3v3/8A.
> Set 3A per SFP slot to allow SFPs work which need more power than the
> default 1W.
> 
> 

Applied, thanks!

[2/5] arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
      (no commit info)

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
