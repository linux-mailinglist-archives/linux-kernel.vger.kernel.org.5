Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173BA7E5A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjKHPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjKHPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:36:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BB1FD6;
        Wed,  8 Nov 2023 07:36:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D095C433C9;
        Wed,  8 Nov 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457785;
        bh=ZNwyEHHUEwE32sPJEr2cy/zvLd4Oa0Y44mvEx4uVdC0=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=N+C+Mm9DOvW41xQlHZ2TVmIysLX42LJ/xl/PTNFiruH2Wu4ATYa4k2Jmpv/MAIV0f
         JANa/WnumUmKQNSBxLJwIR9sUeFXiRNwMFy/HhmYIK1TQmfxq4MgfutVxD/BrUNpF2
         gdMutlmGlJ5GqOQ4+Hw72DgbNIdVOTpzsJ/k3wv9PeGVJSsfK9EeHuUEKr6yLBthag
         TARWGt52CUMc2URaFLJV1QXt8K3WE59YxhNHBAAE6F9EKHGmDggCNU0n9C6bb5PrWY
         Y0COjbc32pM1Stb6a/svq9+UnG+z+49ttg52dv9b22VQijktsXe7br3iblISUX57po
         53QHjv6k/7OcA==
Message-ID: <3fb0760a9066c33947b64ec415d9baea.mripard@kernel.org>
Date:   Wed, 08 Nov 2023 15:36:22 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Hsin-Yi Wang" <hsinyi@chromium.org>
Subject: Re: [PATCH v6 3/5] drm/panel-edp: drm/panel-edp: Add several
 generic edp panels
In-Reply-To: <20231107204611.3082200-4-hsinyi@chromium.org>
References: <20231107204611.3082200-4-hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Douglas Anderson" <dianders@chromium.org>,
        "Jessica Zhang" <quic_jesszhan@quicinc.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 12:41:53 -0800, Hsin-Yi Wang wrote:
> Add a few generic edp panels used by mt8186 chromebooks.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
