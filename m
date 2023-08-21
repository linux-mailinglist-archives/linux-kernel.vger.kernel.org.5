Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B3782508
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjHUICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjHUICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B025B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC94611B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB7FC433C8;
        Mon, 21 Aug 2023 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692604951;
        bh=wVawZypfbImK2Ibz+sdq6sPXO1RRKbl2Jin6gVIlzKc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vN7YioQ7a2kt0S5zUuk60M0n9nC0MLigmqZJzvnS5GURxtoF8Z+YDrMw8V5iGhO6P
         +sFPxGpKqxxFxGBpIIm3LNDtOItwXcHNQhrLtT2FowXQy/FljMB0R8CHI10EhNJdmo
         FqW3GD9Nl9KBbv+x4r5z3tBi5V0bpePHAnjtVMi4CYTFr8/dxkf4MIqhtGim3GtoZv
         JMGGRKZqrvv21e4+BDxx8oAMvkLqZh4gasZDHp76Bzbwhgr1Az8G5CrQBi20vj7uKm
         EXn2MQADQSsh0tF8sTAvpoK+OsAiQvGDRNI5vsQYOBO/vc1Zr68ZHMVIKJVrM2Qybz
         wT1UQlmZIkJsA==
From:   Maxime Ripard <mripard@kernel.org>
To:     dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230817094808.1.I41b04c3a8305c9f1c17af886c327941c5136ca3b@changeid>
References: <20230817094808.1.I41b04c3a8305c9f1c17af886c327941c5136ca3b@changeid>
Subject: Re: (subset) [PATCH] drm/bridge: Fix kernel-doc typo in desc of
 output_bus_cfg in drm_bridge_state
Message-Id: <169260494885.199179.14472084217400049781.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 10:02:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 09:48:09 -0700, Douglas Anderson wrote:
> There's an obvious copy-paste error in the description of
> output_bus_cfg. Fix it.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

