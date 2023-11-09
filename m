Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8BC7E6E81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjKIQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKIQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:20:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73574358C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:20:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504FEC433C7;
        Thu,  9 Nov 2023 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699546812;
        bh=6FnXrXpYVcgrn+bbbH/PHAi1F7snZalU5SnpXZiFEDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrXilxCqiLZp7Kdouyj71BlX1GTL6MbKv21Hg9FAyemrqs0Zh7DaTihBoDqQ1jWHI
         qDel+m9CilRr86XVFUnkpkmZDeGhYfid/4nSi9+XtB6KoU1jLj+gfmaS86g4VILtWC
         9FWaF223KuM1bDQrgip5h/m+0WirT04Tlot7WpmIULKPiktzZQMHrgxb+yUhTvMonv
         0AeOgx2A1YnyJUDQAAAGHMs6yCNNCDWJRb26rVWAIW+5lcOuapcNa3MqSqPby6TrwV
         McjDWCNGtyAaItfIkgOyqDjXRljb57ht6tYBmWK4iMIslGsriZazF8NOpt+iZuGDJP
         0A1U3Re4FZKvg==
Date:   Thu, 9 Nov 2023 21:49:58 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 0/2] bus: mhi: host: Add SDX75 support and its
 dependency
Message-ID: <20231109161958.GI3752@thinkpad>
References: <1699344890-87076-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699344890-87076-1-git-send-email-quic_qianyu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 04:14:48PM +0800, Qiang Yu wrote:
> This series add new configuration for Qualcomm SDX75 and new parameter
> ready_timeout_ms for waiting ready state.
> 

Applied to mhi-next!

- Mani

> v1->v2: Start with "bus: mhi: host:" for the cover letter subjects
> v2->v3: Use Qualcomm SDX75 in commit message of the cover letter
> 
> Qiang Yu (2):
>   bus: mhi: host: Add a separate timeout parameter for waiting ready
>   bus: mhi: host: pci_generic: Add SDX75 based modem support
> 
>  drivers/bus/mhi/host/init.c        |  1 +
>  drivers/bus/mhi/host/internal.h    |  2 +-
>  drivers/bus/mhi/host/main.c        |  5 +++--
>  drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
>  drivers/bus/mhi/host/pm.c          | 24 +++++++++++++++++-------
>  include/linux/mhi.h                |  4 ++++
>  6 files changed, 48 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
