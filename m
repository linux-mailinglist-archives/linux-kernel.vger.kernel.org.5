Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77980F1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376738AbjLLP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjLLP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:58:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B110AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:58:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D16C433C8;
        Tue, 12 Dec 2023 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702396687;
        bh=kHCIVEVBzI52qhmBl5M/wcd6l7pWChQnaNSwcL3b+5A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UzKMpM/HT5BrwYhI+RBWTK2uGUHe2gsvdSpEI2nxj+UO8pc/xfHfYmjwFwyMhLLfb
         fARJRune7QMLqNucxKrdbNamxf1wl//qAxlCZDvRIo/Q9a9mqLwHOuJxeBa3Jp1u2M
         b/Y+xtXhCL4ewzwOP1/D6vjVe4QrvraCRSAJOp/wCu8atLGmj7NwNubEBsRB1vCyWw
         kanRco2eswcI99anGBA5OSMjWjqEKooJevRdXIW3kIrGQBjci+ZSeXX5VUWnLbuKSg
         V3XHZTD3fAlUxvzLYlxrQ2qacm/A+M52+mIovvIeED6dLipIBy9udwu//pv0jH7cuk
         m/uF8JBZltyEQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231212081239.14254-1-wsa+renesas@sang-engineering.com>
References: <20231212081239.14254-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Message-Id: <170239668506.84470.10579761461556330418.b4-ty@kernel.org>
Date:   Tue, 12 Dec 2023 15:58:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 09:12:38 +0100, Wolfram Sang wrote:
> Documentation says only DTDL of 200 is allowed for this SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
      commit: e5c7bcb499840551cfbe85c6df177ebc50432bf0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

