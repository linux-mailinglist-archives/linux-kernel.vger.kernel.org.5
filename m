Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524E7CED10
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJSBAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJSBA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:00:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6D12D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B2EC433C7;
        Thu, 19 Oct 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697677223;
        bh=jhqylZ1kbUblqylLlif48g5pTl+ZU53wYTDMSwgJjhY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ISG5FG5lO9n/A9rh8MO4aQPQ4xTuvW8DQPBvMvReqXaCCM9IIymOQzsVH8DP/n+oD
         lGjbk2Zyc7+wnKA/10mwhjbuW9dlqIxVrJccdpbNQcwwF1zh75/A2f1S8XQreBDycN
         G7lnqfZB/PkVSySwTHtH5Y1oPBNpiHg+ARfZBnx8kj9Xgs3C35U4HGgKPfWuZ3j7y8
         bjfZkAORrfT8MTY3LO4be4I3be8hirsXLVVqZNcjinWeySD2GKC3ge5N8rRen4Suv1
         LtQcgzEXQ0TlxgVIufANX4PgZbr12PY7mzcZ+srRbK3CwwV+pQhbrfX/EiulsNODi2
         5ZjQcqCjVlqwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAF8BE00080;
        Thu, 19 Oct 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers: net: wwan: iosm: Fixed multiple typos in multiple
 files
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169767722376.5576.467230838370578760.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 01:00:23 +0000
References: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231014121407.10012-1-m.muzzammilashraf@gmail.com>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     m.chetan.kumar@intel.com, linuxwwan@intel.com,
        loic.poulain@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Oct 2023 17:14:07 +0500 you wrote:
> iosm_ipc_chnl_cfg.h: Fixed typo
> iosm_ipc_imem_ops.h: Fixed typo
> iosm_ipc_mux.h: Fixed typo
> iosm_ipc_pm.h: Fixed typo
> iosm_ipc_port.h: Fixed typo
> iosm_ipc_trace.h: Fixed typo
> 
> [...]

Here is the summary with links:
  - drivers: net: wwan: iosm: Fixed multiple typos in multiple files
    https://git.kernel.org/netdev/net-next/c/2c6370a13f0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


