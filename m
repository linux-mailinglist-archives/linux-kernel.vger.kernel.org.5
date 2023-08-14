Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000F77C1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHNUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHNUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F06C3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19006437B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58829C433C9;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046222;
        bh=7ahPsYJb2VWj+5q4JjbIrqJmgJYdovuwK0IeKkfLRoM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IaLOjP0BzL70Cg1XYavERrlSXeabLnxia2+U5i1szJ0GbbZpyM+S3fDS84jPHuPyd
         0/5WCWKE15xIO/JC9t5gSB7hxrlre3HinG/ylj1t6AG9J3+v0XaWjvE8/YGnnvI8Sg
         ctPVJlj4xzPPjxNRnYEtnokyJYn2882OnE/Sg25VHVagXrBOa5vMRYlk4voW4Uh1wt
         +euJBLr8NL4GnKSMRYtUiiM9LY7rfLzT8gBkMNBIGhfylKSKHp8+a8qDBlj2pkkiyD
         hq6fFJvRH554MNzByRLR95PyiFFAzWbpKTrb02NOWqxQL1Eun20DDxzwKKKBiIcK81
         kTX5NvkLsTxbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31477E93B36;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: increase usage of folio_next_index()
 helper
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169204622219.5033.17422365206843508436.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 20:50:22 +0000
References: <20230717071109.5663-1-duminjie@vivo.com>
In-Reply-To: <20230717071109.5663-1-duminjie@vivo.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 17 Jul 2023 15:11:09 +0800 you wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  fs/f2fs/data.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: increase usage of folio_next_index() helper
    https://git.kernel.org/jaegeuk/f2fs/c/a842a90926b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


