Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0437AD202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjIYHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjIYHnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:43:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6AEE3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:43:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B70DC433C7;
        Mon, 25 Sep 2023 07:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695627829;
        bh=myK966qEnI1fuOXxADF5RQjS2NfbvQRXNNgyejzLHj4=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=UiCDSEHjLXz/jLtBbfWl5B4S4Ym9uBq6RwMJ2p0h2hAqwrzdaoRMdzJVQFpLaCY80
         /GVuxtcqij0XH/qOz/JOQysqGiraJ7Iun7zmySqKQQO6gta7tnHaWYvtJqchzYCm5+
         35e3OF1s2aAadcVaMtGl1/8S/1weII6ctTObE2d8J/glGGmqR0bFo4JoGkJk2iWFXv
         wInst2oS4ylO5cRscPZCJOFj8BTtLV+/ORMNPRdScKBJqx1kVG+KVFXhS8aYDPKhE3
         nLAPggpGza2ITIDwdAMZ3YdlwlWgj3DCOFS+d1Zfw9LNePzjnsEQEPv/YC5hUU+Kt/
         KL3lZRS39smWQ==
Message-ID: <42011ce6616bfb7bda5337a94c19b287.mripard@kernel.org>
Date:   Mon, 25 Sep 2023 07:43:46 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Jernej Skrabec" <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 1/7] drm/sun4i: dw-hdmi: Deinit PHY in fail path
In-Reply-To: <20230924192604.3262187-2-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-2-jernej.skrabec@gmail.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        samuel@sholland.org, wens@csie.org,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 21:25:58 +0200, Jernej Skrabec wrote:
> Commit 9bf3797796f5 ("drm/sun4i: dw-hdmi: Make HDMI PHY into a platform
> device") removed code for PHY deinitialization in fail path.
> 
> Add it back.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
