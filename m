Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED57F1942
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjKTRCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKTRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:02:41 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CDC3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:02:35 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r57fJ-0000jr-95; Mon, 20 Nov 2023 18:02:29 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: Add NV20 and NV30 support
Date:   Mon, 20 Nov 2023 18:02:19 +0100
Message-Id: <170049972584.1779880.3039151921455735557.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025213248.2641962-1-jonas@kwiboo.se>
References: <20231025213248.2641962-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 21:32:46 +0000, Jonas Karlman wrote:
> Add support for the 10-bit 4:2:2 and 4:4:4 formats NV20 and NV30.
> 
> These formats can be tested using modetest [1]:
> 
>   modetest -P <plane_id>@<crtc_id>:1920x1080@<format>
> 
> e.g. on a ROCK 3 Model A (rk3568):
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: Add NV20 and NV30 support
      commit: 5fc6aa7db080fd90ef00846aac04e8a211088132

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
