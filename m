Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAF7D8E01
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjJ0FK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0FKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:10:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEDC1B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:10:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACFE7C433C9;
        Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698383450;
        bh=EKNbDWtfaUD3WEEOAPnInrFXHTHRnJmKszb1TwkoXAQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FPfW6VUEDtCgms3wTS/NoQn0bTjAIhf2rT7LmcfiFZnnUma4vH+s7AcQpJTqhFzDf
         5PqWXdvs9Ky0kYM4yQmAk9aSg+fFDA+cLXoxaibFqwMnY7DG2DcnUFySn4s/P64AG4
         ncwhkO6LdnpDZTVaFG8xfOrw8NV2Iatk9Q9JqGraB3a1ifJ5aV/mZw7m7XLGV0GT+x
         KdlNG47mzhgXBVv11NqfWNJsHsxJEgBQUTVWAJAVbD3H/xA4StIIO/PycItxBOkMvN
         UVDGQiQ7zFUoRddAD1SumpMCe+ip8WqJYyP6tg/4CFM0D+XPFVuaOxBIJgD30YQQWF
         LQDvohJDt6IrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A4D1C39563;
        Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Maintainer change for ptp_vmw driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169838345055.10513.2288095940504010073.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 05:10:50 +0000
References: <20231025231931.76842-1-amakhalov@vmware.com>
In-Reply-To: <20231025231931.76842-1-amakhalov@vmware.com>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        richardcochran@gmail.com, jsipek@vmware.com, akaher@vmware.com,
        deep@dshah.net, pv-drivers@vmware.com, sdeep@vmware.com
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

On Wed, 25 Oct 2023 16:19:31 -0700 you wrote:
> Deep has decided to transfer the maintainership of the VMware virtual
> PTP clock driver (ptp_vmw) to Jeff. Update the MAINTAINERS file to
> reflect this change.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> Acked-by: Deep Shah <sdeep@vmware.com>
> Acked-by: Jeff Sipek <jsipek@vmware.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Maintainer change for ptp_vmw driver
    https://git.kernel.org/netdev/net-next/c/cc33a80b8164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


