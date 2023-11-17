Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082687EEF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbjKQJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjKQJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:50:50 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECAAD;
        Fri, 17 Nov 2023 01:50:45 -0800 (PST)
Received: from i5e861935.versanet.de ([94.134.25.53] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r3vUp-0003ER-CA; Fri, 17 Nov 2023 10:50:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     mturquette@baylibre.com, Weihao Li <cn.liweihao@gmail.com>,
        sboyd@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: rk3128: Fix HCLK_OTG gate register
Date:   Fri, 17 Nov 2023 10:50:33 +0100
Message-Id: <170021461022.1221251.9951712126746337546.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031111816.8777-1-cn.liweihao@gmail.com>
References: <20231031111816.8777-1-cn.liweihao@gmail.com>
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

On Tue, 31 Oct 2023 19:18:16 +0800, Weihao Li wrote:
> The HCLK_OTG gate control is in CRU_CLKGATE5_CON, not CRU_CLKGATE3_CON.
> 
> 

Applied, thanks!

[1/1] clk: rockchip: rk3128: Fix HCLK_OTG gate register
      commit: c6c5a5580dcb6631aa6369dabe12ef3ce784d1d2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
