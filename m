Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3A7F6A01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKXBEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:04:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA95D50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=McEkrzvQsANR3dYBGG5TkcCVdpI5YO1hkWmFCI4Iqi4=; b=Y/x8ZV+B5upfkW4D5wDII1uNdq
        JCnsvRikF+RjrCc5e6ocn9/lzN6IqfKw6yEIMgwn7KxoWG13qwrAU6ZAj5ejK1uhOOKiFW9A9I/qq
        EYLtirfPw9aRQNcQkrQRaT2Dq7f3i543CJVKooUXzYEPMDVAblLxSZ8Bo82pGhEOzgir2GRVb9oDK
        zA7gnSppFmB2Vls3V6+9kiVLFjGaqvQ7d5m52ZNrY+QihN/yCmIjIs0Fbwm0zk6oDh6Tdqwzxum9q
        ot49HUYL44skF3MAOfAl5b5dKpzxdLpiKDBx3QJEl1+GG3dxgXshmM5CACOF/SQBogrBsocQu1UXz
        bvCxHSXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6KcO-0083NW-9a; Fri, 24 Nov 2023 01:04:28 +0000
Date:   Fri, 24 Nov 2023 01:04:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <ZV/2nPBs5r1nIaW4@casper.infradead.org>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV7eHE2Fxb75oRpG@archie.me>
 <ZV9x6qZ5z8YTvTC4@casper.infradead.org>
 <ZV_rJtxdn1dU9ip0@archie.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV_rJtxdn1dU9ip0@archie.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 07:15:34AM +0700, Bagas Sanjaya wrote:
> On Thu, Nov 23, 2023 at 03:38:18PM +0000, Matthew Wilcox wrote:
> > On Thu, Nov 23, 2023 at 12:07:40PM +0700, Bagas Sanjaya wrote:
> > > Anyway, I'm adding this regression to regzbot:
> > > 
> > > #regzbot ^introduced: v6.0..v6.1
> > 
> > this is not a regression.  close it, you idiot.
> > 
> > 
> 
> why?
> 
> Confused...

yes.  you're perpetually confused.  stop trying to help, you only make
things worse.  learn about the things you work on, or give up.

