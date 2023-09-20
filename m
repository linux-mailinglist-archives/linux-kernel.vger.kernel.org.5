Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9167A88EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjITPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjITPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92EB9;
        Wed, 20 Sep 2023 08:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64451C433CC;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225025;
        bh=LPE6+j2moV2jZAwig9ZRFQxDO5eBHD3zNmuotyL0WyE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XbgkrEQ4W4x9NCAJHZAXE5UJATS6dDywBYfa0FZ9s8CmXfjj/kf0I7o1iV4lqcbRb
         /forzMvEwI4+BBD4iiSgL6gM5XVM3f2eGyoW8v8jXTFb/1fyuKxRjfaLPsOBKDC74B
         HasL1zloOLxVfYD+rj2LoPHpZHC0Ie8aus/+MtVCeCkmbxpE9e4ysB1KQI20JOQlqr
         sN4tC++H1VkDYBogFMrqFLj9WE/Z8iXjbHGreQvGr4LbaWL1knQY4r+sx69dgIBfBu
         sFmr4HiBNTyCR4nPV0/QpNR93PIG+Dtfr5sg247+Pz8oVgljspMVvD18kZD4LH8BL1
         OBvqf6uk5VZPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41A6FE11F4C;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: set the default compress_level on ioctl
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169522502526.22557.11170809241417939586.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 15:50:25 +0000
References: <20230912205015.2582133-1-jaegeuk@kernel.org>
In-Reply-To: <20230912205015.2582133-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
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

On Tue, 12 Sep 2023 13:50:15 -0700 you wrote:
> Otherwise, we'll get a broken inode.
> 
>  # touch $FILE
>  # f2fs_io setflags compression $FILE
>  # f2fs_io set_coption 2 8 $FILE
> 
> [  112.227612] F2FS-fs (dm-51): sanity_check_compress_inode: inode (ino=8d3fe) has unsupported compress level: 0, run fsck to fix
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: set the default compress_level on ioctl
    https://git.kernel.org/jaegeuk/f2fs/c/f5f3bd903a5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


