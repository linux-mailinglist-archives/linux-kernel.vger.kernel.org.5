Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110C67F9726
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjK0B2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0B22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:28:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC467119
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:28:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C204CC433C8;
        Mon, 27 Nov 2023 01:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701048515;
        bh=6gJ+oVXcv85wKK5hi51Aq9ovh5iUlMZEHZqeIkmUNI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/HQF17Zj4KnA5g6PmiJnyHdkhHSBuXOvxxS98kW7tkXSdZD/aKW+S3ky91EvRJ8A
         uBiDW2nDhNJz9iR4TZywGOp+veME0bRvJcxFqbeT17eMRQ3Tcu1lJ16l7G5LdIRx3s
         JsDV5KuABeTStqngW3znQrCqknzq+QNoOHlkx1jfrf3GBZhj/dJGVT73R3YuUekhoh
         OQwjTDWdyeAdaKsnYdhZSifpVzwoxwRGYG5I3dlIQ057ilXx255fAD/OmK1UpUFIg7
         r4BPzgVW7z7v80bHRmKv6QU0PA98iu0CUcaA0FtcNqf3CMU9gsYlBKWLdd/S5ndm9F
         2kJwiFklfOvug==
Date:   Mon, 27 Nov 2023 09:28:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 2/3] arm64: dts: imx93: Configure clock rate for audio
 PLL
Message-ID: <20231127012829.GC87953@dragon>
References: <20231122101959.30264-1-chancel.liu@nxp.com>
 <20231122101959.30264-3-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122101959.30264-3-chancel.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:19:58PM +0800, Chancel Liu wrote:
> Configure clock rate for audio PLL. There's one audio PLL on i.MX93. It
> is used as parent clock for clocks that are multiple of 8kHz.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Applied, thanks!
