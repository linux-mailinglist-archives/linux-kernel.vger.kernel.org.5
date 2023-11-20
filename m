Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320437F1941
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjKTRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKTRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:02:41 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC5BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:02:36 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r57fI-0000jr-Uf; Mon, 20 Nov 2023 18:02:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, hjc@rock-chips.com
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, airlied@gmail.com,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/4] Rockchip rk3066_hdmi update
Date:   Mon, 20 Nov 2023 18:02:18 +0100
Message-Id: <170049972584.1779880.13529778706599017239.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
References: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
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

On Thu, 2 Nov 2023 14:40:13 +0100, Johan Jonker wrote:
> Update the Rockchip rk3066_hdmi driver in a somewhat similar way
> to what is proposed for the inno_hdmi driver.
> 
> Johan Jonker (4):
>   drm/rockchip: rk3066_hdmi: Remove useless mode_fixup
>   drm/rockchip: rk3066_hdmi: Switch encoder hooks to atomic
>   drm/rockchip: rk3066_hdmi: Remove useless output format
>   drm/rockchip: rk3066_hdmi: Remove unused drm device pointer
> 
> [...]

Applied, thanks!

[1/4] drm/rockchip: rk3066_hdmi: Remove useless mode_fixup
      commit: 1044f4a31734eef000f42cdaaf35bb2f76286be5
[2/4] drm/rockchip: rk3066_hdmi: Switch encoder hooks to atomic
      commit: ae3436a5e7c2ef4f92938133bd99f92fc47ea34e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
