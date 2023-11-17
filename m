Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECB7EEF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjKQJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:50:50 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4CA7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:50:45 -0800 (PST)
Received: from i5e861935.versanet.de ([94.134.25.53] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r3vUp-0003ER-NK; Fri, 17 Nov 2023 10:50:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk356x pcie msg interrupt name
Date:   Fri, 17 Nov 2023 10:50:34 +0100
Message-Id: <170021461019.1221251.11825529275422088497.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114153834.934978-1-heiko@sntech.de>
References: <20231114153834.934978-1-heiko@sntech.de>
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

On Tue, 14 Nov 2023 16:38:34 +0100, Heiko Stuebner wrote:
> The expected name by the binding at this position is "msg" and the SoC's
> manual also calls the interrupt in question "msg", so fix the rk356x dtsi
> to use the correct name.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: fix rk356x pcie msg interrupt name
      commit: 3cee9c635f27d1003d46f624d816f3455698b625

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
