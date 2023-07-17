Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C417568B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjGQQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGQQHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EDFFC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FCE461150
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5AAC433C7;
        Mon, 17 Jul 2023 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689610070;
        bh=iXIYteTk4ukjDs/e/8vdGRE/qy4ZaA4iRgqB5Mrtjdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoL6fejipreN6OGGBVpE13gCI5dRes8NBMbeXfAQKKiqXkbvVfhBwi2PGNin+aRwH
         mw5yrUUTFJcEFt0NO7eFCtEgVYHoUzL5n61ckxo4N7kWaJdktR9HlyYhMzkp0H5H4D
         xQeCapJ1lmSv+VdjzFQiklVdcTlWaz5nV+d++E4b0hhXz+qE4wWP1yiQuuLPhB7KEc
         JQYVc+5n9p5HQDuvLylPJtEP0CO4QCBHg9+zi5TPbVIDMqIDYodugmbb2dNMgtG9Bq
         xG/aakL/uGjCrIgBmyzkz+95NP3RzEFgUK+VHmbvByIRT46Cw2KfyUZ8YMA5e0ESaW
         ssuRuGCAtq3Kg==
From:   Robert Foss <rfoss@kernel.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Robert Foss <rfoss@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Use common macros for HDCP capabilities
Date:   Mon, 17 Jul 2023 18:07:32 +0200
Message-ID: <168961003702.2938487.17405338529770325814.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710091203.1874317-1-wenst@chromium.org>
References: <20230710091203.1874317-1-wenst@chromium.org>
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

On Mon, 10 Jul 2023 17:12:01 +0800, Chen-Yu Tsai wrote:
> The DRM DP code has macros for the DP HDCP capabilities. Use them in the
> anx7625 driver instead of raw numbers.
> 
> 

Applied, thanks!

[1/1] drm/bridge: anx7625: Use common macros for HDCP capabilities
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=41639b3a8b0f



Rob

