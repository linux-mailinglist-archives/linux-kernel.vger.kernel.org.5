Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1527D3ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJWPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B88127
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33185C433CC;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=zRlv4DaNm0Gmd/x7Px1FxJGu+EjMhiDtFj9CBiNQvYA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=En6sdN510ga93u+uS376DZ79r78oh5cWCALnjZPiB90BZtofMSRxq5+v4YpXjfllF
         Iv4nuPsXh0h0bG0Zo+deriSy1/tID7lUvE0Fb087PM0ZuA46dfMJD3awvbR4IWJTc6
         kdELjI/sf5mSf2+1v9HBE+dXADmVHTqzjoY/LRnmTHlJNQR8RwHyTGWcOS1ds2dGDw
         yGChbPDOglaA8h5iKzF9R4tjyNC8MDJuHf0trB9ZTCX0mcyhShathrZJXLSED5zuQS
         QFGfc95GCNkGJFVGH/C+BrxMIXbFuUOdpTXemuu82R19Y2fPY3pvgB9a/N+kHQs6yw
         szQu3VuvHK28w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11964E4CC1D;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: let f2fs_precache_extents() traverses in
 file range
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502505.26537.3887577445667105094.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <20231010013459.115024-1-chao@kernel.org>
In-Reply-To: <20231010013459.115024-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 10 Oct 2023 09:34:59 +0800 you wrote:
> Rather than in range of [0, max_file_blocks()), since data after EOF
> is alwasy zero, it's unnecessary to preload mapping info of the data.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: let f2fs_precache_extents() traverses in file range
    https://git.kernel.org/jaegeuk/f2fs/c/6f560c0f2aa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


