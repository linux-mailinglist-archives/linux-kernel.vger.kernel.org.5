Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17917B5873
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbjJBQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjJBQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EB83
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:29:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6838C433C7;
        Mon,  2 Oct 2023 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696264141;
        bh=mpquLqeo+qKd5itabn6aSuY3Uz2rGl2cDIIZ9cGXsjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWZzPVNOZctAkLSmMo0omS8U+2XcDxsTMgcnAM2hjOpSq5QnaXQDodMtkFNzwCftD
         3wwdwTtOidr67YhK7GuPSQJGIQAvcCsVTVf36Drmjg9Mte0d4vcEQmETbehb9raWGi
         v0mEFfqr9biFWdJN9MnGIpAIqZC8CBGADSwp2YY9LPxuvqOxDEPHm4i/C9NeyMxhI8
         Uh8hZTtdChURccyXjovEOHyqkiFgmx1gntS/p6d7nkV2FevpxLj+zODsNN4FM/SiLQ
         wdxuUeYjY9KPsY4g36J+nKB6Q4NAdVxohPZty29VOFmudza1eh+5INZMj51zgeYqAZ
         FUbogPlQyk5Vw==
Date:   Mon, 2 Oct 2023 18:28:57 +0200
From:   Simon Horman <horms@kernel.org>
To:     KaiLong Wang <wangkailong@jari.cn>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: Clean up errors in ipv6.h
Message-ID: <20231002162857.GY92317@kernel.org>
References: <1f323424.8ac.18ad9c59948.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f323424.8ac.18ad9c59948.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:12:00AM +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>


Hi KaiLong Wang,

unfortunately, patches that only contain checkpatch clean-ups
for Networking code are not accepted.

-- 
pw-bot: rejected
