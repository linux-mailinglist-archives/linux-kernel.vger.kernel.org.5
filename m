Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332979E6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbjIMLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbjIMLab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:30:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545321726;
        Wed, 13 Sep 2023 04:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E33F0C4339A;
        Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694604626;
        bh=fys3AwpYMFkt4YpMz2d9cBa4HOo29zLSnKJq0CztGhM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HoigTJxBqwRaERj0uhNCxnLnoW8QdbIdiKARdggVKYc4BF94U8xJ9jLO8vpKvZCIg
         +Tc6HJXn0UBZE/QFNZw5+NBrOaFd+jr8M7WtTev9Rprbpu8Mo5ipDsK5fkQzqjQ32l
         Q9MITKDV0bDOyh591rVUBvkCOv6bjRPKwnKdtrqaFa3Eptl/lVI0b6JvosIcrgovIo
         fZ4DQvxukMTSyKErFxumMx6LytrSXyzI/wxB0oUIK/HFl/FqnTrgvEtm9zZhAtHK2b
         TlyD5lw7wsfyfG1DT+8kwuIBcatUPCrzXJTfk9dJfJJGPSjV5u/b69CN4IMldbZ2lP
         S+mjqMQup/b+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D08B7E1C281;
        Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hinic: Use devm_kasprintf()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169460462685.4298.10103672469852664707.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Sep 2023 11:30:26 +0000
References: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     cai.huoqing@linux.dev, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 21:50:52 +0200 you wrote:
> Use devm_kasprintf() instead of hand writing it.
> This is less verbose and less error prone.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_tx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: hinic: Use devm_kasprintf()
    https://git.kernel.org/netdev/net-next/c/9cc91173cf1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


