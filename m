Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC17D3AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjJWPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0842110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AE56C433D9;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=KnASla35Yk8mT/Sw5VL+9nhWIgXHk7sLBFUwKgaMFlM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nzALcLDWPiWYWH+MJJ6qf5mVY68VDW69q6r1x810xoqxxfdu5w8UbH4e39lHIQPem
         nUhDaFijt7OJWSE1YNMqSkDfOiNHxxqX7CicQZNqiLEqHTtxqEZtIpbSkXw2ITa1b6
         trvbLDveo78EMsM8oQQGPB/aPfcI1DY0IzUMj80SML0RnK7iYz2jyk8QhJ1lHjIoSu
         X2EXgD47iCTVLcIgq+QiJitfTxp6iwGASohF3pSLM5QESS77+DNqFatbSeXo9mpnDz
         tnkkf0XkoZgmRFRLRGXWnKbDQgKb2A4TwF1zXEbN93DrkisejVdPn1HqG+ctTGixZM
         rKlwc19PY2Bag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F9B4E4CC13;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling of __get_node_page
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502512.26537.14708449902617826361.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <1697611862-25239-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1697611862-25239-1-git-send-email-zhiguo.niu@unisoc.com>
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, niuzhiguo84@gmail.com,
        linux-kernel@vger.kernel.org,
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

On Wed, 18 Oct 2023 14:51:02 +0800 you wrote:
> Use f2fs_handle_error to record inconsistent node block error
> and return -EFSCORRUPTED instead of -EINVAL.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/node.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix error handling of __get_node_page
    https://git.kernel.org/jaegeuk/f2fs/c/9b4c8dd99fe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


