Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C057BF902
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjJJKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJJKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704B9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:50:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB7CC433C7;
        Tue, 10 Oct 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696935022;
        bh=a9Ixs+pZD+1syOpUkOXG7aRBfv3sf5X967JIZ271tuM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gSaeTU1tOnUOR9T+UKd+U2lkBtPvMhM1q9tzG+Ll6mf2yhLB6QrcpiJrFs7OChbD1
         9qqIOBQ+8S5C2S5fefv38743sDtJKAJjY9L/GABVJQhOCjFzekOEgUgOijja3VIQp1
         R98kF8AT7nzRQ7xpo94y6LZDarszlNISmSQbLOXpof8WrSuTfWUV2AA7ovYcu0eLpR
         mVdFcBM8CZry6qRioTqalnfVY1FgSKHZMFTI+WmZ4gFE+eYuToBUZNaBrbY1CVmCeB
         yG6ZdnUbsjAqLx8rsDFfvWfBlGCoHYSjttXlIxg12Di3pt27ION3Ig7Q7nD4HvqUlQ
         waTGZHCWPXg8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F9A4C595C5;
        Tue, 10 Oct 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atm: fore200e: Drop unnecessary of_match_device()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169693502211.11220.8874004135364112002.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 10:50:22 +0000
References: <20231006214421.339445-1-robh@kernel.org>
In-Reply-To: <20231006214421.339445-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 16:44:21 -0500 you wrote:
> It is not necessary to call of_match_device() in probe. If we made it to
> probe, then we've already successfully matched.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/atm/fore200e.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Here is the summary with links:
  - atm: fore200e: Drop unnecessary of_match_device()
    https://git.kernel.org/netdev/net-next/c/f0107b864f00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


