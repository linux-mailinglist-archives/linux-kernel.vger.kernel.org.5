Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9F7FF735
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjK3Qy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3Qy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:54:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EDC10DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:54:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C5C433C7;
        Thu, 30 Nov 2023 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701363272;
        bh=+JApM2xxvJ76AYAMsy1eDzT9dueJOrHv87TMof3GiAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpTGK9F7eUx2VyXMCE3tqj2B7X/ibYFfq6DVIOrkvzbt8KoSx5f5UeSxN9PicGLzb
         UHzHQMNtDyKSjPZYs60zwNsUTVPiv3CcX1frQ1JATuoP3pPKgWxQTFeJ+xbjU+kEbR
         NSE1ZJZYJKfrR8MJ0sh+BRw3sUuAHVuF84RJp8RdRGl8klNbxB0FsvIM9qSEWcg0tQ
         /LpwDpstlEOClk+Uvdl52hqB5MR17Nymmp70BBHUlGADo1Q1OyKN4siLtJqLZ7JDtE
         sXcS2jRxDkceFmR8SqlitXP+a1aREy1fdYQApfQE04qavRT+GQu1Wh7Cwyejio1A3t
         m7WewvYvVTnmA==
Date:   Thu, 30 Nov 2023 16:54:26 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, wojciech.drewek@intel.com
Subject: Re: [net-next PATCH v5 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
Message-ID: <20231130165426.GE32077@kernel.org>
References: <20231130034324.3900445-1-sumang@marvell.com>
 <20231130034324.3900445-2-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130034324.3900445-2-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:13:23AM +0530, Suman Ghosh wrote:
> A new mailbox is added to support offloading of multicast/mirror
> functionality. The mailbox also supports dynamic updation of the
> multicast/mirror list.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

