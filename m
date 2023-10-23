Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3B7D3AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJWPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJWPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9610D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FE46C433AB;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=OKWIKmca4kW63hOA9qQevvO3LIv+dqiLYJlGjPsbZbE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g8B7PKtpL0Scf8QfuO9OGn5ygw3uIm7XzZl97Yoe42zP21xgVHm8hbbe6I/4UbDvg
         v3S+ldLjWaqgP27EGKbtXwmQDeDoXqwgTg9flJx41VgPG0OLhY7ewiiFg/P9IosP0b
         /RtDY81G0jyk3yQ0FD4xYrXmfqE20wTBAuiesuVxgLRjN93LpoPLEy2zLxZP9JmUHu
         Ea3OZ9hOuMkv/3Tr02mXDaYI8Jab+W9hvRNjEbXTffGgMN5qfS7KzmbqDXpyqH+G6P
         w+CPYRnpjbkaQR7VpI7w42n11oMQ5yuqIt8D1ShDViYEIxvyDE0rZV45GxhrhFlgxh
         RrloaKs36azeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33E20E4CC1C;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 0/1] Add 16K Support for f2fs
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502520.26537.15643252943037065209.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <20231002230935.169229-1-drosen@google.com>
In-Reply-To: <20231002230935.169229-1-drosen@google.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
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

On Mon,  2 Oct 2023 16:09:34 -0700 you wrote:
> F2fs filesystems currently have two large restrictions around block size.
> The block size must equal the page size, and the block size must be 4096.
> 
> The following patch, along with the associated f2fs-tools patch set, relax the
> latter restriction, allowing you to use 16K block size f2fs on a 16K page size
> system. It does not allow mounting 4K block size f2fs on a 16k page system.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/1] f2fs: Support Block Size == Page Size
    https://git.kernel.org/jaegeuk/f2fs/c/d7e9a9037de2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


