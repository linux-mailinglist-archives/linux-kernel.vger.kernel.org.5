Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E027FB667
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjK1J4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjK1J4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:56:31 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27401A8;
        Tue, 28 Nov 2023 01:56:36 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7upR-0002pQ-SP; Tue, 28 Nov 2023 10:56:30 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] RK3128 clock fixes
Date:   Tue, 28 Nov 2023 10:56:28 +0100
Message-Id: <170116536542.2181089.13845527972157638659.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127181415.11735-2-knaerzche@gmail.com>
References: <20231127181415.11735-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 19:14:14 +0100, Alex Bee wrote:
> This series has 2 patches which fix some clock driver issues for RK3128.
> 
> In v2 [0] there was one more patch [1] which I dropped now, since
> it has been merged already (was submitted by somebody else [2]).
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20230829192958.250248-1-knaerzche@gmail.com/
> [1] https://lore.kernel.org/linux-arm-kernel/20230829192958.250248-3-knaerzche@gmail.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20231031111816.8777-1-cn.liweihao@gmail.com/
> 
> [...]

Applied, thanks!

[1/2] clk: rockchip: rk3128: Fix aclk_peri_src's parent
      commit: 98dcc6be3859fb15257750b8e1d4e0eefd2c5e1e
[2/2] clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name
      commit: 99fe9ee56bd2f7358f1bc72551c2f3a6bbddf80a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
