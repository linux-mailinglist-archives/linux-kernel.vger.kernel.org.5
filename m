Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31507FC12A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbjK1QDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjK1QDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:03:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F073FDA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:03:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837ABC433C9;
        Tue, 28 Nov 2023 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701187431;
        bh=+pato+LffL0P+vw0mTjTTPCUEE3imABiIUqXTtcAvp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ND7N4ysP/c6pHxK6EgD0UorMDPSQIBULubLzj+4yb56G042te3HoTCFbid9l/TNkl
         n5/4PUMMqlL5K9VVTz8hDyuwCOh5xxaZ0VICQOiM9mhWW9scUNHRrCfcNL/FiHsfDN
         0bKA0F9cjzqEVxEgSh5QCbAOFHsVCpXwcvhGWxW+VPHl4HBrF+WpHBP0PUrbzmjPog
         TLrByMin8bewXrWRB09zdyDoPIQRx9fvW1TF5RfLF774+6hjuQt4YHxHlp6aX0i9/G
         wpoiM/cTUEsGGAjGBiH+mau5rSsuWvnuNjnEtod7IDseYg/NAala5A2EMuJVMqnGfh
         AurHUWPD0q+0w==
From:   Robert Foss <rfoss@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Robert Foss <rfoss@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/bridge: Fix typo in post_disable() description
Date:   Tue, 28 Nov 2023 17:03:44 +0100
Message-ID: <170118741506.1051024.17483818104518491512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124094253.658064-1-dario.binacchi@amarulasolutions.com>
References: <20231124094253.658064-1-dario.binacchi@amarulasolutions.com>
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

On Fri, 24 Nov 2023 10:42:30 +0100, Dario Binacchi wrote:
> s/singals/signals/
> 
> 

Applied, thanks!

[1/1] drm/bridge: Fix typo in post_disable() description
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=288b039db225



Rob

