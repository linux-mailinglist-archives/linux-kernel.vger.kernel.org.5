Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0927C9533
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 11:45:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A5A1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DWg2eSQYtr6dBInriybuSYfPequhU1StyqvonL/p56U=; b=PM/mBgk6MoKpG9FIiTg7dY7DzP
        MkVAP4KxP0FexNE4lg4Kfk5jQK8V/o5tZEEccujyQ1NzdsAvJJq1Gvn6GO5/XDctQOq/MxGB6QMgb
        LDKZB9lm+ElcKOTTyxjPXmtzdNKkVd3L8nRP8ERb8DODK+VQBJtIo5tGujT9Wgum4Sm2ne+atwvVC
        E5xzYZYeBlnDf2GSp7CW56ZCS+IF6eOoz0rf/yMvWdFyXRWhXyAmYigW8RYvvsz8yoGjAeLVreYFD
        K9NnuQZYvAP3DsX06sJl34SMfLorvuWwmNkZvQDiB19K/OE6m+CcNuxCiOYGzzvxatPQ49EdrNKPv
        H4rdapxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrgpG-00CFiP-IB; Sat, 14 Oct 2023 15:45:14 +0000
Date:   Sat, 14 Oct 2023 16:45:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
Message-ID: <ZSq3iuuGy7zSl4sz@casper.infradead.org>
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
 <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 08:31:35AM -0700, Randy Dunlap wrote:
> >  	/*
> > -	 * The caller from rmap relay on disabled preemption becase they never
> > +	 * The caller from rmap relay on disabled preemption because they never
> >  	 * update their counter from in-interrupt context. For these two
> 
> I don't know what that (partial) sentence is trying to say...
> Maybe someone else does.

s/relay/rely/
