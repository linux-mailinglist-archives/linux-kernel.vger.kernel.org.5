Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117A7A965F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjIURC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjIURCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD33910C7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81BC4E76F;
        Thu, 21 Sep 2023 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306583;
        bh=TLvaJrIvbE3wSBgqozLTIG4l1mfwrfkwlcmiyZgo5cc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Yc8QPaUquEBjB1CSrc05c0riWprQKnlPs6h00lgeuRtRfYvx8vs5so2GFIzgYL933
         Ahhve/aeGebRnovdYJ8vhUpOGSzIgnGmNNeGeUB6FFgLD+pnWzEI5NUK3RP0OjQ2Qt
         3MqNy7R4bouj3AJJaLHcoufSFvzT2ENRMe8j5kDZhihTYKrsshU9hrctKcIpdw6ToK
         8Sr9dB256taMmBdgCC5Cs2OHx7gcNdi/6f3xvb3/sb9H9kEY0yLpCVFQOzuuC4kSQ8
         Z64XumVNjvBjmalpmWsSa8D6G+yu5zFsOaghT3UZ2Z60ocESMGcFxJm5I/WFkPMn5z
         /hgWUohSjMpGA==
From:   Vinod Koul <vkoul@kernel.org>
To:     chunfeng.yun@mediatek.com, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        Shuijing Li <shuijing.li@mediatek.com>
Cc:     linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
In-Reply-To: <20230908075310.17825-1-shuijing.li@mediatek.com>
References: <20230908075310.17825-1-shuijing.li@mediatek.com>
Subject: Re: [PATCH v3] dt-bindings: phy: Add compatible for Mediatek
 MT8188
Message-Id: <169530657939.106263.17269838650335090138.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Sep 2023 15:53:10 +0800, Shuijing Li wrote:
> Add dt-binding documentation of dsi-phy for MediaTek MT8188 SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: Add compatible for Mediatek MT8188
      commit: be5747285ea0774501c5c9d25cbff43e6b0b53b9

Best regards,
-- 
~Vinod


