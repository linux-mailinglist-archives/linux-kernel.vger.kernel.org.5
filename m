Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94E75EDBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGXIfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjGXIfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486CD10C1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B545360FCF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99BCC433C8;
        Mon, 24 Jul 2023 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690187722;
        bh=Z5HY1j3XekN0wuWmc3Gm3XQ0wBUul6TgGJXDB+eNZNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOuh8YN5DpUam/j60jnSdNhC+63dFxHoHy2Zk5oTqEVE/HlZ/7d3WO/ImXs/tq18K
         x7yJxNox45X7BJPu90lZdz7U/l/XZewqHKQnZSLZ5wL0B97k4qd5yLgUlaagCo2cG9
         gp7BRd7Q6IiBu4Yya45YTkG2WrqFiZ4Z9fpy2JeiTKWiOeFvy1etBCKm3GRnTWhLnL
         z1Bj5HhE5XVthlPbCOINK3Z/A3ms0wCdIGmP/0DPPri5XeZ6nVZx4sJA0mU0+YLWtW
         hi0CMmSIzw88J01sNzFn2ABTblavtbfhjobzWHwBkofmhcDYCYDQdxgAtULiCY70fH
         Xg5OXEONsHp/g==
From:   Robert Foss <rfoss@kernel.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Robert Foss <rfoss@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Pin-yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11] drm/bridge: it6505: Fix Kconfig indentation
Date:   Mon, 24 Jul 2023 10:35:15 +0200
Message-ID: <169018770962.615452.8291957504440998877.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712065054.2377278-1-wenst@chromium.org>
References: <20230712065054.2377278-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 14:50:53 +0800, Chen-Yu Tsai wrote:
> From: Pin-yen Lin <treapking@chromium.org>
> 
> Replace the spaces with tab characters in the Kconfig file.
> 
> 

Applied, thanks!

[1/1] drm/bridge: it6505: Fix Kconfig indentation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dd9c1329027d



Rob

