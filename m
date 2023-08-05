Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047F770D6D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjHEDPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEDPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:15:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9379F4EE3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7L4T1AL5+RtCz9Ap2gwFgceIH+Pc5pEwFeeTVbAOImA=; b=Oos3wzzmFm7BA2/siU/CP2NLk1
        oq5BiYAg9MPC95uNokatRLJHxH33Q+RcAeqUfVf2MEW5MP7fOFx4seVyVdpyiT4B1XeGH8WzhIkEL
        q1RGLy5Mrbjavwo865eKsyjYP+ve5wDc5VIUraEQ7BJx+4xECQkHFpWkZnIYYQTo+/KZhkiJFckok
        oEC4F44ZiAGb+HqCEgPyoolo+tnx4C/6xTylHUkmeBj+l2DnWth6h6xp50l3lC03TYtEialc9gMpT
        5pDBBXpBUd0oycUm71lncwDBGC6tqL4fhpocnJWSBEJG8uZJV3A/txKM2dNPisx0SaTLZlNCChi2q
        fBUrtUMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qS7kp-00DddC-4x; Sat, 05 Aug 2023 03:14:59 +0000
Date:   Sat, 5 Aug 2023 04:14:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Subject: Re: [PATCH 0/9] Fixes and cleanups to compaction
Message-ID: <ZM2+sztr1CPCwIBN@casper.infradead.org>
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 07:07:02PM +0800, Kemeng Shi wrote:
> Hi all, this is another series to do fix and clean up to compaction.
> Patch 1-2 fix and clean up freepage list operation.
> Patch 3-4 fix and clean up isolation of freepages
> Patch 7-9 factor code to check if compaction is needed for allocation
> order.
> More details can be found in respective patches. Thanks!

As with your last patch series, half of the patches are missing.
Looks like they didn't make it to lore.kernel.org either:

https://lore.kernel.org/linux-mm/20230804110454.2935878-1-shikemeng@huaweicloud.com/
https://lore.kernel.org/linux-mm/20230805110711.2975149-1-shikemeng@huaweicloud.com/
