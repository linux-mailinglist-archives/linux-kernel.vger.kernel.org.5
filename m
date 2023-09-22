Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB17AADB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjIVJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjIVJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:21:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4172A194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:21:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26684C433C9;
        Fri, 22 Sep 2023 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695374461;
        bh=FjPhN6i5lI0cC5cDbAlNjqvB+J5Zmihtz1gx9fX7IO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gi52uqSF3zSmY9VnWK1Jt14RJ/0It6ReB/mBCSFaFF5RMNtMVN5+nnSZQPu1w3VWb
         Jw/sK9ELJwYQwVQFEXaUKVUbAOOSEUobHboaU+CVnfUTECcEtfkcF1+r8BPpfueMs5
         hUbmpzYF3zuPPbczfZi6kg6L5I06HPt0NzDy1chNqHUr0OU16oySz5+h7l66ZOhb53
         B6lgN5Yqfv67NPDRyhhQz8+oMkUIh6FUFBjTXpBcweMx/QApxXDis0N2fuubYaHdd1
         PdiUIuY/ytWD7WxAttXcrrwnm2C1dO+Dg2Pbs13u2A2DDElZmNKcRrwA0l6NmIEzgz
         6APduN6UAdzTQ==
Date:   Fri, 22 Sep 2023 10:20:54 +0100
From:   Simon Horman <horms@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
Subject: Re: [net-next PatchV3] octeontx2-pf: Tc flower offload support for
 MPLS
Message-ID: <20230922092054.GU224399@kernel.org>
References: <20230921085055.7258-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921085055.7258-1-hkelam@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 02:20:55PM +0530, Hariprasad Kelam wrote:
> This patch extends flower offload support for MPLS protocol.
> Due to hardware limitation, currently driver supports lse
> depth up to 4.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

