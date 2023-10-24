Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B867D5BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjJXTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:48:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F7111
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:48:41 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qvNO9-0007MI-BB; Tue, 24 Oct 2023 21:48:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 0/2] drm/rockchip: vop: Add NV15, NV20 and NV30 support
Date:   Tue, 24 Oct 2023 21:48:26 +0200
Message-Id: <169817682323.1800793.13214115140253891113.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023173718.188102-1-jonas@kwiboo.se>
References: <20231023173718.188102-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 17:37:13 +0000, Jonas Karlman wrote:
> This series add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced
> by the Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.
> Also include 10-bit 4:4:4 support since VOP can support that also.
> 
> First patch adds new fourcc 10-bit YUV formats with 4:2:2/4:4:4 sub-sampling.
> Second patch adds support for displaying the new fourcc formats.
> 
> [...]

Applied, thanks!

[1/2] drm/fourcc: Add NV20 and NV30 YUV formats
      commit: 728c15b4b5f3369cbde73d5e0f14701ab370f985
[2/2] drm/rockchip: vop: Add NV15, NV20 and NV30 support
      commit: d4b384228562848e4b76b608a5876c92160e993c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
