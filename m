Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B517E5A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjKHPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjKHPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:35:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF41BE6;
        Wed,  8 Nov 2023 07:35:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2072FC433C8;
        Wed,  8 Nov 2023 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457745;
        bh=IgF6+bXpdf75WXeAvSDDhYfuqLKw54SZ5acCbfcmfCM=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=ARShJAydwt6xGIMUHXoxDBU8oryuoqHXFOpcQQ+d6cLMDU6EO46fqFyeQ7KsP0K4l
         q+CM7FpfXEnnbhVVjBVjiKtoyxzB+daPnZPVAjRAKAIGjCrEhKFTwPi2ueWf5tWo6g
         dRzVSUVYl18keZDoeuT35fzRactdWJDiDuxTezN93qDJoJx60XLoGTiQuIJNnbAN3S
         3Z/9CM7IfAaI95wSbzJLiwbMav40wi0PRuKVCqXX79mL3YO3v5N/v9ogEvh1uI050t
         cb6P/uqg/ZBClDcMKzizo23lyL1zRhLfFuCZffLl1qLIh/0/rIH1IaRpTm8xcHlbcb
         /hRAJ/91WuEcA==
Message-ID: <302dfeb3069105f55d516d5b474cae18.mripard@kernel.org>
Date:   Wed, 08 Nov 2023 15:35:42 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Hsin-Yi Wang" <hsinyi@chromium.org>
Subject: Re: [PATCH v6 1/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01
 name and timing
In-Reply-To: <20231107204611.3082200-2-hsinyi@chromium.org>
References: <20231107204611.3082200-2-hsinyi@chromium.org>
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

On Tue, 7 Nov 2023 12:41:51 -0800, Hsin-Yi Wang wrote:
> Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
> auo_b116xak01: T3=200, T12=500, T7_max = 50 according to decoding edid
> and datasheet.
> 
> Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
