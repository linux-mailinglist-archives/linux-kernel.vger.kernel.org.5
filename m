Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243F7567B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGQPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGQPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3410DD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B646111E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38888C433C8;
        Mon, 17 Jul 2023 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607215;
        bh=+rnHwN8BBAAxjKI/C9wyRzOwjJHGXHe1uOyuMUQV4R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuNNBooE1Dz7YPOXtUJEvFsXxWmkurJCKNh5REK8t/ZSAWUoC78Ls/1tS/irBoNMC
         XJPFWvBhQBky3VNWh8RCq9mIXzQ6Zv4lH7vcjavOi4+A7498mSMxc8t/Z9Z9Gd2D09
         pxaoFhBiSMU+51f4uicikh2ZlUMpNYyeQ/rfivr0FUNAx8aHD0PtQpk+U8/ZG0IOce
         ClVOWaCK5EkXOzQginaFUaFRGpAjv4+3pDofgVCE/oLHEv49W34NZNUIkcsjH4d+o8
         5nCTOAVQHfZDN85Qtqp/wFKS+XHK1DbV8GNiRlELjQdCnO3CWlsyvzMLTPutG71AFd
         ZSzC5K+WMkM4g==
From:   Robert Foss <rfoss@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>, Xin Ji <xji@analogixsemi.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH RESEND] drm/bridge: anx7625: Use common macros for DP power sequencing commands
Date:   Mon, 17 Jul 2023 17:19:54 +0200
Message-ID: <168960718497.2919250.12489201173225348002.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710090929.1873646-1-wenst@chromium.org>
References: <20230710090929.1873646-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 17:09:27 +0800, Chen-Yu Tsai wrote:
> The DRM DP code has macros for the DP power sequencing commands. Use
> them in the anx7625 driver instead of raw numbers.
> 
> 

Applied, thanks!

[1/1] drm/bridge: anx7625: Use common macros for DP power sequencing commands
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2ba776f903cb



Rob

